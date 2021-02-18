---
layout: post
title: "About Oracle Cloud Infrastructure (OCI)"
excerpt_separator: "<!--more-->"
categories:
  - sre
tags:
  - site reliability engineering
  - cloud platforms
  - public clouds
  - private clouds
  - oracle
  - oracle cloud infrastructure
  - oci
---

![](/assets/img/oci.png)
<!--more-->

I've created this diagram to summarize the services in [Oracle Cloud Infrastructure (OCI)](https://www.oracle.com/cloud/).
I usually use AWS for building applications but apparently, OCI is often used in enterprise solutions.
For example, [Zoom also chose OCI to deploy their infra](https://www.lastweekinaws.com/blog/why-zoom-chose-oracle-cloud-over-aws-and-maybe-you-should-too/).

Unsurprisingly, I found that the structure of services in OCI is basically similar to AWS in several foundational categories: Management, Security, Identity, Database, Compute, Storage, .etc. 

However, in terms of Artifical Intelligence and IoT applications, it feels like OCI has less showcases and developers who use OCI will be likely to have more tedious work to work.
For example, building a chatbot is a relatively easy task for IBM Watson users or AWS ML users.

Of course, quite recently, OCI has announced some of their tutorials in [Fraud Detection](https://blogs.oracle.com/machinelearning/a-two-step-process-for-detecting-fraud-using-oracle-machine-learning), and released their Oracle Machine Learning (OML) solution.

Anyway, all cloud platforms have their own upsides and downsides. Developers would learn to use and making their own choice. For me, for building AI/IoT applications, I still feel good with Amazon ;)