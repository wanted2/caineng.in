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
  - hybrid clouds
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

![](/assets/img/vmcaws.png)

For many years, enterprise customers have been deployed their infrastructure into VMware cloud with powerful and secure virtualization technologies like [vSphere](https://www.vmware.com/products/vsphere.html) for computing resources (VMs, .etc.), [vSAN](https://www.vmware.com/products/vsan.html) (storage) and [NSX](https://www.vmware.com/products/nsx.html) (networking). 
While new and leading public cloud solutions like Amazon Web Services (AWS) offer lower cost tiers, with greater opportunities in building innovative solutions, transforming from the existing VMware cloud to AWS is a trade-off between reliability (on existing solutions) with better business offers.
Building a hybrid cloud using [VMware Cloud on AWS](https://cloud.vmware.com/vmc-aws) is a way to achieve both goals: maintaining customers' trust while migrating to novel solutions.
<!--more-->

# Introduction: Migration to AWS

Enterprise customers refer to the companies who have more than 500 personnel each (See the report [1], [pdf](https://www.vmware.com/content/dam/learn/en/amer/fy21/pdf/691726_2020_Business_Value_Running_Applications_VMware_Cloud_AWS_VMware_Hybrid_Cloud_Environments.pdf)).
These customers have some characteristics in common: they have adopted a stable and reliable infrastructure for years and of course, they are refraining from making a sudden changes in what is already running well.
For example, a company who already have their infrastructure running on VMware Cloud and the system have established and have been running well for 20 years, then now it would be difficult t persuade the executives to change to AWS and destroy all what already been running well so far.

The problems arise when persuading customer to migrate to a new platform like AWS:

* **The cost of destroying what have been running well**: Our infrastructure in VMware have been running well for 20 years, now if we destroy everything, we need to investigate on re-training our staffs to be familiar with new systems. The cost of migrating our products to new platform is also high and the waste should be considerable. This is a common customer claim.
* **The gain of new business opportunities in new platform**: Does new platform offer us genuine solutions? Is the gain bigger than the cost?

Solving these trade-offs is a hurdle for migration to new businesses.
VMware has offered a great solution to this problem: hybrid clouds with [VMware Cloud on AWS](https://cloud.vmware.com/vmc-aws). In short, this means the customers **deploy their data center to AWS Cloud using VMware Cloud technologies**. All of the resources will be allocated in AWS but the management will be done using VMware Cloud solutions such as vSphere, vSAN and NSX [2, 3].

# VMware Cloud on AWS

## Benefits

* Access to a public cloud environment that is consistent with an on-premises environment and can be operated with the same tools and skill sets as customers’ on-premises VMware environments, allowing easy migration, operations, and integration with customers’ on-premises environments
* Ability to add or remove resources on demand within minutes and use resources with hourly pay-as-you-go pricing, enabling agility and flexibility with customers’ VMware environments
* Access to AWS public cloud services, including databases, data analytics services, and emerging technologies such as artificial intelligence/machine learning (AI/ML)
* Delivered as a completely managed service by VMware, with pay-as-you-go pricing and no up-front commitments

## Learning resources

### Tutorials

* [Migrating MS SQL Server to AWS using VMware Cloud](https://docs.vmware.com/en/VMware-Cloud-on-AWS/solutions/VMware-Cloud-on-AWS.919a954a9b6ca17cdc719ec42cda1401/GUID-E62521730EDBE3DC125813A448BA3B45.html)

* [Managing Oracle Database using VMware Cloud on AWS](https://docs.vmware.com/en/VMware-Cloud-on-AWS/solutions/VMware-Cloud-on-AWS.fd6ed3145c4c711ec04722e9f7803c98/GUID-354BA0BF983966BFF710F44563729DF7.html)

* [Performance Characterization of Microsoft SQL Server Using VMware Cloud on AWS](https://docs.vmware.com/en/VMware-Cloud-on-AWS/solutions/VMware-Cloud-on-AWS.324e0c5bdd4624ae8c3fbcd7460a8837/GUID-3F613B502E44AE64E4C88ED56EF7535A.html)

* [Optimize Virtual Machine Configurations in VMware Cloud on AWS for Enterprise Applications Workload](https://docs.vmware.com/en/VMware-Cloud-on-AWS/solutions/VMware-Cloud-on-AWS.91696a39d9cb804e2888c43d538bab50/GUID-2892F57D4799679E31DB27E9DF358475.html)

* [DNS Strategies for VMware Cloud on AWS](https://docs.vmware.com/en/VMware-Cloud-on-AWS/solutions/GUID-25B7F9346825C50F67BF60403CCCAE21.html)

* [Using an On-Premises DHCP server](https://docs.vmware.com/en/VMware-Cloud-on-AWS/solutions/GUID-F0065BCA2A940BFF7F4D3220ED2DB286.html)

* [Understanding Integrations with AWS Services](https://docs.vmware.com/en/VMware-Cloud-on-AWS/solutions/VMware-Cloud-on-AWS.c4d719788a38caf2d1599242f2b1b8cc/GUID-ECE503736CC8F886BE7B85CB79DB7405.html)

### Official guides

* [User guides](https://docs.vmware.com/jp/VMware-Cloud-on-AWS/index.html)
* [AWS guides](https://aws.amazon.com/jp/vmware/)

### Others

* [Series on how-to VMC on AWS](https://blogs.vmware.com/emea/en/2019/08/vmware-cloud-on-aws-get-your-basics-right-part-1/)
* [VMware Cloud on AWS Tech Zone](https://vmc.techzone.vmware.com/vmware-cloud-aws-tech-zone)
* [Introducing the HashiCorp Terraform Provider for VMware Cloud on AWS](https://nicovibert.com/2020/01/29/terraform-for-vmware-cloud-on-aws/)

# Conclusion

Small business customers are likely to accept the solutions using new platforms like AWS because they don't possess an existing solution their own.
However, medium and large enterprises will need to consider the waste when migrating to new business platforms.
Therefore, a solution like VMware Cloud on AWS is a big deal. 
Enterprises will not need to destroy their existing infrastructures, they only move the underlying resources which they rarely need to interact with to AWS, while they still use the same tools (vSphere, vSAN, NSX) for management in VMware Cloud.

# References

{% bibliography --file cloud-2021-02-14 %}