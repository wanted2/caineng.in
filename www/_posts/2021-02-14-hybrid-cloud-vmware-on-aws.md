---
layout: post
title: "On Hybrid Clouds: VMware Cloud on AWS"
excerpt_separator: "<!--more-->"
categories:
  - sre
tags:
  - site reliability engineering
  - cloud platforms
  - public clouds
  - private clouds
  - hyrbid clouds
  - customer data center
  - cdc
  - vmware
  - vsphere
  - vsan
  - nsx
  - vmware cloud on aws
  - amazon web services
  - oracle cloud infrastructure
  - oci
---

_Note: this post is about building Customer Data Center (CDC) for enterprise, not about applications for end-users._

For many years, enterprise customers have been deployed their infrastructure into VMware cloud with powerful and secure virtualization technologies like [vSphere](https://www.vmware.com/products/vsphere.html) for computing resources (VMs, .etc.), [vSAN](https://www.vmware.com/products/vsan.html) (storage) and [NSX](https://www.vmware.com/products/nsx.html) (networking). 
While new and leading public cloud solutions like Amazon Web Services (AWS) offer lower cost tiers, with greater opportunities in building innovative solutions, transforming from the exsiting VMware cloud to AWS is a trade-off between reliability (on existing solutions) with better business offers.
Building a hybrid cloud using [VMware Cloud on AWS](https://cloud.vmware.com/vmc-aws) is a way to achieve both goals: maintaining customers' trust while migrating to novel solutions.
<!--more-->

# Introduction: Migration to AWS

Enterprise customers refer to the companies who have more than 500 personels each (See the report [1], [pdf](https://www.vmware.com/content/dam/learn/en/amer/fy21/pdf/691726_2020_Business_Value_Running_Applications_VMware_Cloud_AWS_VMware_Hybrid_Cloud_Environments.pdf)).
These customers have some characteristics in common: they have adopted a stable and reliable infrastructure for years and of course, they are refraining from making a sudden changes in what is already running well.
For example, a company who already have their infrastructure running on VMware Cloud and the system have established and have been running well for 20 years, then now it would be difficult t persuade the executives to change to AWS and destroy all what already been running well so far.

The problems arise when persuading customer to migrate to a new platform like AWS:

* **The cost of destroying what have been running well**: Our infrastructure in VMware have been running well for 20 years, now if we destroy everything, we need to investigate on re-training our staffs to be familiar with new systems. The cost of migrating our products to new platform is also high and the waste should be considerable. This is a common customer claim.
* **The gain of new business opportunities in new platform**: Does new platform offer us genuine solutions? Is the gain bigger than the cost?

Solving these trade-offs is a hurdle for migration to new businesses.
VMware has offered a great solution to this problem: hybrid clouds with [VMware Cloud on AWS](https://cloud.vmware.com/vmc-aws). In short, this means the customers **deploy their data center to AWS Cloud using VMware Cloud technologies**. All of the resources will be allocated in AWS but the management will be done using VMware Cloud solutions such as vSphere, vSAN and NSX [2, 3].

# VMware Cloud on AWS

## Benefits

## Learning resources

# Conclusion

Small business customers are likely to accept the solutions using new platforms like AWS because they don't possess an existing solution their own.
However, medium and large enterprises will need to consider the waste when migrating to new business platforms.
Therefore, a solution like VMware Cloud on AWS is a big deal. 
Enterprises will not need to destroy their existing infrastructures, they only move the underlying resources which they rarely need to interact with to AWS, while they still use the same tools (vSphere, vSAN, NSX) for management in VMware Cloud.

# References

{% bibliography --file cloud-2021-02-14 %}