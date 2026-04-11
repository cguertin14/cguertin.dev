---
author: "Charles Guertin"
title: "Cyber Team Canada 21-22"
date: "2022-06-19"
description: "A recap of my time in Cyber Team Canada"
tags: ["ICC", "ECSC", "canada", "security", "CTF"]
categories: ["security"]
ShowToc: true
TocOpen: false
---

## Introduction

Between September 2021 and June 2022, I have had the privilege to represent my home country, Canada, at two international cyber security competitions. The first one being the *European Cybersecurity Challenge (ECSC)* followed by the *International Cybersecurity Challenge (ICC)*. My participation in Team Canada was directly related to the fact that some friends and I finished 1st in Canada’s Cybersecurity Challenge, in June of 2021.

## ECSC 2021

<img loading="lazy" src="/img/blog/ecsc_logo.webp" alt="ECSC Logo" width="200" class="rounded-lg">
<br/>

I represented Canada in the *European Cyber Security Challenge (ECSC)*, which took place from September 28th to October 1st of 2021. It was my first-ever international competition and it did not disappoint. The event was held in Prague, Czechia, which is a beautiful city in the heart of Europe. I had been in this city two years prior, so I knew my way around - my teammates and I had lots of fun sightseeing in this amazing medieval town.

The competition itself followed the Jeopardy format. This format requires players to quickly solve challenges and find flags to be submitted as soon as possible. Basically, the faster you submit valid flags, the more points you get. We quickly found out that the difficulty level of this competition was **way** higher than what we had been exposed to back in Canada. Looking back at the event, it is safe to say that we could’ve had better results had we been more prepared. Nonetheless, we had lots of fun during the event and learned a lot about the different kinds of challenges we partook in.

<img loading="lazy" src="/img/blog/ecsc_comp.webp" alt="ECSC competition" width="700" class="rounded-lg">
<p style="font-size: 13px; color: gray; margin-top: 10px">Photo via ECSC</p>

## ICC 2022

<img loading="lazy" src="/img/blog/icc_logo.webp" alt="ICC Logo" width="450" class="rounded-lg">
<br/>

I had the honor to represent Canada in the first-ever *International Cybersecurity Challenge (ICC)*, which took place from June 14th to 17th, 2022. The event was held in Athens, Greece, a country I had never been to before.

Contrary to the *ECSC*, this competition followed both the Attack/Defense and Jeopardy formats. Experiencing my first-ever Attack/Defense CTF was a major milestone for me. Already having quite some experience in defense software from my current job and accumulated knowledge, the defense folks in my team and I put a pretty good defense system in place which consisted of alerts coming from [Falco (security breach monitoring+alerting)](https://github.com/falcosecurity/falco), [Grafana (logs visualization)](https://github.com/grafana/grafana), [Loki (logs aggregator)](https://github.com/grafana/loki), [AlertManager (alerting system)](https://github.com/prometheus/alertmanager) and [Wireshark](https://www.wireshark.org/).

We hosted the logging stack on a cloud server to be able to forward logs to it coming from the vulnerable machine we were given at the competition. As for Falco, it was running on the vulnerable machine and sent alerts when it found breaches on our live services. Using this stack, we were able to find attacks and replicate them to other teams, while simultaneously finding flags and automating exploits with our red team. Unlike at the *ECSC*, we were much more prepared for this event as we practiced many times as a team before the actual competition.

This trip is definitely one that I will not forget anytime soon.

<img loading="lazy" src="/img/blog/icc_comp.webp" alt="ICC competition" width="700" class="rounded-lg">
<p style="font-size: 13px; color: gray; margin-top: 10px">Photo via @GaspareFerraro, Twitter</p>

## Imposter Syndrome

Going into these competitions, it definitely felt like a surreal experience. Representing my country in an international competition has always seemed far-fetched to me, so having the privilege to not only do it once, but twice, is massive. With that comes the feeling of maybe not totally deserving to be where you currently are, even though you did all the necessary steps to do so. That is precisely what imposter syndrome is. I constantly had to remind myself throughout both these incredible events that I did not steal my spot on this team, that I deserved to be there and that this was a big thing to be a part of. 

Participating in such high-end competitions allowed me to explore new tools, technologies and methodologies with respect to Cybersecurity, which in the end, made me feel like I picked up on a lot of useful knowledge. Imposter syndrome is something I initially struggled with when I came into the computer science field, and the feeling resurfaced during the *ECSC* and *ICC*. In the end, I was able to overcome this mental state and feel gratitude for being a part of this team.

## Acknowledgments

For both the *ECSC* and *ICC*,  I was lucky enough to be surrounded by incredibly talented teammates from all over Canada, including cities such as Montreal, Ottawa, Calgary, and Vancouver. A huge shoutout to [ENISA](https://www.enisa.europa.eu/), the sponsors and all the organizers for hosting both events, which were super well organised. That includes not only the competitions but also the logistics behind the restaurants, hotels and other necessities for all participants. Last but not least, a huge thanks to Team Canada's Tom Levasseur, Coach Dmitriy Beryoza and all the organizers from [CyberSci](https://cybersecuritychallenge.ca/), who put a ton of effort into taking us to both events while making sure we got everything we needed when we were there. All of this would not have been possible without them, so I am extremely grateful.

## Conclusion

I will wrap up this article by saying that I feel incredibly thankful to have had the chance to participate in these two international competitions -- it's something I have always wanted to do since starting University, and now I can check that off my bucket list. It was a great opportunity to meet fellow hackers and Software Engineers from all over the world. These events were a memorable experience that I will carry with me for the rest of my career.
