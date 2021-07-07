---
author: "Charles Guertin"
title: "Kustomize vs. Helm"
date: "2021-07-05"
description: "A battle of between two giants of configuration management in Kubernetes."
tags: ["k8s", "kubernetes", "kustomize", "helm", "config", "templating"]
categories: ["tooling"]
ShowToc: false
TocOpen: false
---

## Helm

[Helm](https://helm.sh) is described as a package manager for Kubernetes, the same way `apt` is the package manager for Ubuntu. It is one of the most used tool to quickly deploy applications on a cluster. Because Helm offers so many open-source applications, there is a marketplace where you can search for services and find how to install them, right [here](https://artifacthub.io). One of the main reason why it's so popular is that it allows one to very quickly install applications in a Kubernetes cluster with a simple command (of course, this statement varies depending on use-cases). For example, here's how to deploy `prometheus-operator` using Helm:

```bash
$ helm install prometheus-operator prometheus-community/kube-prometheus-stack
```

So, installing applications built by other folks is great with Helm, but what happens if you want to deploy your own services using it? Well, this is where it gets a little bit dirty.

Helm uses a pattern of defining a values files with key/value pairs that will be replaced inside the templated chart afterwards. Helm is quite famous in the cloud-native world for its use of [YAML templating](https://helm.sh/docs/chart_template_guide/). The latter works well when it's already written, but writing it can be painful, since it is difficult to read. The learning curve to the Helm structure can be quite intense for a new Developer. Moreover, some questions come to mind about Helm usage: 

* How do you deploy to multiple environments using it? 
* Why bother writing templates for your own services?



## Kustomize

## Why not use both?

## Conclusion