---
author: "Charles Guertin"
title: "My First Year As An SRE"
date: "2024-01-02"
description: "How my first professional year as an SRE stacked up"
draft: true # TODO: Remove this to publish.
tags: ["sre", "reliability", "engineering", "career"]
categories: ["welcome"]
series: ["career"]
ShowToc: true
TocOpen: false
---

## Introduction

Over the course of the last year, I've worked as a Site Reliability Expert II (SRE) at Lightspeed. It was my first year as a professional SRE, which is what I aimed to do while I was in University. It was a year filled with things I had never done before:

* first time being in an on-call rotation
* first time being an incident responder
* first time working as a Reliability Engineer for any company.

In the past, I have worked in DevOps and SRE, but never as an actual SRE. So, 2023 was a big year of learning in that sense for me. It was a year in which I strengthened my professional abilities by working with highly competent people: wether it was other SREs, Developers, Product Managers, etc.

I have learned a lot and it's been fun as well. Let's dive deeper into what that actually means.

## Accomplishments

This past year, I was part of various projects and initiatives within the Global Hospitality SRE team at Lightspeed.
Here are some of them that I'm particularly proud of:

### Public Speaking :mega:

During an Eastern Canada CNCF meetup in October I spoke publicly in front of other technologists for the first time about how we use Karpenter at Lightspeed to provision & scale our Kubernetes clusters. It's something I always wanted to do, so I'm really happy that it's now done and that it gave me the confidence to do even more public speaking in the future.

### MySQL 8 Upgrades

For one of our products, we have a fleet of 70+ MySQL DBs on AWS. Managing them is a challenge in itself, but then we had a notice from AWS that v5.7 was coming to the end of its lifecycle and that we had to upgrade to v8. We were able to achieve this before the due date, in less than 5 months.

### Karpenter Consolidation

We've had [Karpenter's Consolidation feature](https://karpenter.sh/preview/concepts/disruption/#consolidation) enabled for a while in lower environments, but not in Production. The reason for that is simple: most of our Prod microservices weren't properly sized, in terms of CPU & Memory. It took around 5 months of work along with Service Owners to properly size every single service running in our Prod cluster. We were able to automate this process by developing a tool written in Go that would query the Datadog API and use the Memory & CPU metrics and set them on the related deployments.

### Cost Savings :moneybag:

With all the financial instability in the world in the past year, talks of recession, layoffs and more, my team was tasked with reducing costs as much as possible, wherever possible in our infrastructure. Here are some examples of cost savings I was a part of:

* 25% reduction in EC2 costs for our Kubernetes Prod cluster, thanks to Karpenter Consolidation
* Using `gp3` storage across the board for all of our RDS instances / clusters over `gp2` or `io1`
* Reducing NAT Gateway costs primarily caused by Datadog outgoing traffic by leveraging [Datadog's AWS Privatelink](https://docs.datadoghq.com/agent/guide/private-link/?tab=connectfromsameregion)
* Reserving RDS instances + using Graviton-backed instance classes for MySQL 8 databases.

In the end, this was also a new thing for me to do. I had never worked on reducing AWS bills and learned a lot this year about how to do it.

### On-Call Duties

When I first started as SRE at Lightspeed, it took only a few weeks (maybe 2 or 3 weeks) before I was on-call during working hours. Once on-call, it also did not take long before I was paged and eventually part of my first Incident. Weirdly enough, I think that being part of incidents forged me. It helped me learn about our systems, how they communicate with each other, and more. It helped me construct a mental map of our infrastructure and speeded up my learning.

I'll leave it at that for what went well this year, but I have to say that it was a really good one.

## Challenges

Obviously, not everything can go well all the time :sweat_smile:. There were some challenges this year, let's dig into them.

### Firefighting

As I've pointed out before, being part of multiple incidents has helped me a lot this past year. But, at some point, we were spending more time investigating alarms rather than delivering value for the company as SREs. With time, as we got more experienced and more staffed, it got a lot better and we're no longer firefighting.

### Learning massive infrastructure stacks

Working in a big company often means working with big codebases, large infrastructure, a lot of (sensitive) data, etc. In my case, it primarily meant to work with various AWS accounts, a huge amount of Databases, Containers, and complexity. Learning this took a while, and I'm still learning how it all works to this day. My first few weeks at the company were a bit confusing because everything was new, everything was to be discovered and learned. But again, with time, it got a whole lot better.

### Legacy Systems

In any company, there are legacy systems. Lightspeed is no exception. In my experience, it can be challenging to work with those, especially when older technologies are involved, such as very old versions of a programming language, for instance. Or simply in-house solutions made before cloud-native ones were invented. I once read a great saying that said "Respect what came before" with regard to legacy systems and I often think about it when it comes to them.

### Implementing SLOs

SLOs are part of the SRE DNA. I've found that implementing them at scale can be quite hard. Rallying support and excitement from Developers is not easy with regard to SLOs, their usefulness and especially justifying why devs should get paged in case of fast error budget burn rate or if an error budget runs out of capacity. Something I'd like to eventually do is read about strategies to effectively implement SLOs at scale, properly convince stakeholders of their usefulness as well as convincing management. On that note, exploring [Google SRE's SLO resources](https://sre.google/resources/) be a good start.

## Foreword

To conclude, this past year has been very exciting. Working in SRE has been my dream for years and I'm happy to now be working in my field. I'm learning everyday and being challenged again and again. New technologies, scale & complicated problems keep me passionate about my job and I'm very grateful to get the chance to work as an SRE.


Thanks for reading.