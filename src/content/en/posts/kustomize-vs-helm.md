---
author: "Charles Guertin"
title: "Kustomize vs. Helm"
date: "2021-07-07"
description: "My take on the Kustomize vs. Helm saga"
tags: ["k8s", "kubernetes", "kustomize", "helm", "config", "templating"]
categories: ["tooling"]
ShowToc: true
TocOpen: false
---

## Prerequisites

If you want to follow along and try commands on your own machine, make sure to install `Kubectl`, `Helm` and `Kustomize` before reading this article by using the following links:

* [Kubectl Installation Guide](https://kubernetes.io/docs/tasks/tools/#kubectl)
* [Helm Installation Guide](https://helm.sh/docs/intro/install/)
* [Kustomize Installation Guide](https://kubectl.docs.kubernetes.io/installation/kustomize/)

## Helm

### Introduction

[Helm](https://helm.sh) is described as a package manager for Kubernetes, the same way `apt` is the package manager for Ubuntu. It was originally developed by Microsoft a few years ago, but is now part of the [CNCF](https://cncf.io). Since Helm is a powerful tool, its users benefit from it by quickly deploying applications in their clusters. Because Helm offers so many open-source applications as packages, there is a marketplace where one can search for services and find how to install them, right [here](https://artifacthub.io). 

### Usage

One of the main reasons why Helm is so popular is that it allows one to very quickly install applications in a Kubernetes cluster with a simple command (of course, this statement varies depending on use cases). For example, here's how to deploy `prometheus-operator` using Helm:

```bash
$ helm install prometheus-operator prometheus-community/kube-prometheus-stack
```

### Issues

So, installing applications built by other folks is great with Helm, but what happens if one wants to deploy their own services using this tool? Well, this is where it gets a little tricky.

When using Helm, users must define a values file with key/value pairs that will then be replaced inside the templated chart. Helm is quite famous in the cloud-native world for its use of [YAML templating](https://helm.sh/docs/chart_template_guide/). The latter works well when it's already written, but writing it can be painful, since it is difficult to read. The learning curve of the Helm structure can be quite intense for a new Developer. Furthermore, to me, two questions come to mind regarding Helm usage: 

* How does one deploy to multiple environments using this tool? 
* Why bother writing templates for your own services?

To answer both of these questions, we'll look at what Kustomize has to offer.

## Kustomize

### Introduction

Now that we have talked about Helm, let's dig into Kustomize. First off, [Kustomize](https://kustomize.io) is a configuration management tool, as opposed to Helm which is a package management tool. Despite their differences, Kustomize and Helm share some similarities. The former was built by Google in 2018 and aims to offer template-free configuration for users to customize their Kubernetes manifests in a brilliant way.

The main goal of Kustomize is to be able to write reusable configuration files for Kubernetes. This allows users of the tool to easily deploy their configuration to multiple environments without having to rewrite their configuration files for each one of those environments. In other words, Kustomize fixes Helm's problems -- by avoiding YAML templates and deploying to multiple environments easily. 

### Usage

Now, let's take a look at how Kustomize actually works. Let's start by a quick example of a simple deployment, which would define a `kustomization.yaml` file like this:

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
- deployment.yml
- service.yml

namespace: simple-demo

commonLabels:
  app.kubernetes.io/name: simple-app

commonAnnotations:
  contact: 'company@email.com'
```

We can apply this file by using either the `kustomize` binary or the `-k` flag with `kubectl`. I prefer using the `kustomize` standalone binary, since it has the latest Kustomize features, unlike `kubectl`. In this case, we would apply the configuration like so:

```bash
$ kustomize build . | kubectl apply -f -
$ kubectl apply -k .
```

In this file, many different actions are unfolding. First, it is not required to write the `apiVersion` and `kind` annotations, although some people prefer writing it. Second, the above configuration defines a few important fields: `resources`, `namespace`, `commonLabels` and `commonAnnotations`. The `resources` field is required, but not the others and here's why. The `resources` field defines the Kubernetes configuration files to use, the `namespace` will set the `namespace` field on each one of the manifests passed to Kustomize, `commonLabels` will do the same thing but for the labels, and finally `commonAnnotations` will do the same for annotations. Therefore, it is not required to specify labels, annotations nor namespaces in Kubernetes manifests when using Kustomize, except for a special use case where it is necessary to hard-code those values in the manifests.

### Upstream Kustomize Repositories

We've just taken a look at how to use Kustomize to deploy manifests, but what about installing third-party applications in a Kubernetes cluster? Well, this can be done by filling the `resources` field with a valid git URL, like in this `prometheus-operator` example:

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
- github.com/prometheus-operator/kube-prometheus?ref=v0.8.0
```

When specifying a URL like in the above example, it is good practice to specify a version of the upstream Kustomize configuration to avoid unpredictable behavior when deploying a stack. In this example, we're referring to the `v0.8.0` of `kube-prometheus` containing a `kustomization.yaml` file at the root of the repository, which is necessary when using upstreams with Kustomize. Note that the `kustomization.yaml` or `kustomization.yml` file *DOES NOT* have to be at the root of the repository. In fact, it can be anywhere, as long as it points to the right path in the configuration.

### Deploying to multiple environments

As previously mentioned, the main goal of Kustomize is to provide reusable configuration files in a seamless way. To visualize this, let's examine how to deploy Kubernetes manifests to multiple environments:

```bash
~/someApp
├── base
│   ├── deployment.yaml
│   ├── kustomization.yaml
│   └── service.yaml
└── overlays
    ├── development
    │   ├── cpu_count.yaml
    │   ├── kustomization.yaml
    │   └── replica_count.yaml
    └── production
        ├── cpu_count.yaml
        ├── kustomization.yaml
        └── replica_count.yaml
```

What's important to note from this file structure is the `base/`, `overlays/prod` and `overlays/development` folders. All reusable configuration files between each environments are defined in the `base/` folder. The interesting pattern here is that in each environment defined in the `overlays/` folder, they simply refer to the `base` folder in their own Kustomize configuration, without having to rewrite each manifest, like so:

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
- ../../base

patchesStrategicMerge:
- cpu_count.yaml
- replica_count.yaml
```

The above configuration reuses the base manifests and applies changes to the deployment. In this example, the cpu/replica counts vary according to their respective environment, which is why there are `patches` in the configuration file. The `patchesStrategicMerge` field allows the modification of resources in a very elegant way. For instance, the `cpu_count.yaml` file would probably look like this:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-name
spec:
  spec:
    containers:
    - name: my-name
      resources:
        limits:
          cpu: "40m"
        requests:
          cpu: "20m"
```

Doing so makes it possible to reuse configuration files between environments and patching manifests if necessary. In this example, we used the `patchesStrategicMerge` field, but there is also the `patchesJson6902` field that can be used for JSONPatches, depending on the use case.

We now have a good understanding of what Kustomize provides to the cloud-native ecosystem, but it offers so much more. For additional information, take a look at [their documentation](https://kubectl.docs.kubernetes.io/references/kustomize/kustomization/).

## Helm + Kustomize?

Now that we've covered Helm and Kustomize, we might ask ourselves: what if we used both of these tools together to deploy applications? The truth is that Kustomize pairs really well with Helm. The reason we might want to use them together is because not every popular third party application offers a Kustomize upstream, although most of them offer a Helm chart. There are two ways to pair these tools:

* Using Kustomize's Builtin Plugin [HelmChartInflationGenerator](https://kubectl.docs.kubernetes.io/guides/extending_kustomize/builtins/#_helmchartinflationgenerator_)
* Exporting Helm charts using the `helm template` command

First, using `HelmChartInflationGenerator`, one needs to define a file with the Helm configuration. Let's name it `helm-chart.yml`, like this:

```yaml
apiVersion: builtin
kind: HelmChartInflationGenerator
metadata:
  name: myMap
chartName: minecraft
chartRepoUrl: https://kubernetes-charts.storage.googleapis.com
chartVersion: v1.2.0
helmBin: /usr/bin/helm
helmHome: /tmp/helmHome
releaseName: test
releaseNamespace: testNamespace
values: values.yaml
extraArgs:
- --include-crds
```

Our `kustomization.yaml` file would look like this:

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

generators:
- helm-chart.yml
```

And that's it. We could achieve the same result by exporting the filled Helm manifests using `helm template`, but I personally recommend using the Kustomize plugin.

## Conclusion

In this article, we've talked about Helm and Kustomize, two amazing tools that provide great features to the community. We've digged into both of them and have seen how to use them together to benefit from the respective features they offer. Finally, we've seen how using Kustomize facilitates deploying manifests to different environments.

Now, it is up to you to make up your mind on these tools and choose what suits you best. Hope I could help!

Thanks for reading and talk soon. :wave:

## Further Readings

* [Helm](https://helm.sh)
* [Kustomize](https://kustomize.io)
* [Kustomize announcement from Google](https://kubernetes.io/blog/2018/05/29/introducing-kustomize-template-free-configuration-customization-for-kubernetes/)
* [Managing the YAML mess with Kustomize (video)](https://www.youtube.com/watch?v=1fCAwFGX38U)