---
layout: post
title: "Deploy Odoo to AWS EC2 and Aurora with best practices"
excerpt_separator: "<!--more-->"
categories:
  - sre
tags:
  - site reliability engineering
  - cloud platforms
  - public clouds
  - aws
  - ec2
  - aurora
  - postgresql
  - SQL
  - crm
  - odoo
---
![Odoo perf](https://odoocdn.com/openerp_website/static/src/img/2020/home/market_position_update.svg)
*Source: [Odoo website](https://odoocdn.com/openerp_website/static/src/img/2020/home/market_position_update.svg)*

# Introduction

## What is Odoo?
[Odoo](https://www.odoo.com/) is an open source software platform and eco-system for business apps that cover all your company needs: CRM, e-commerce, accounting, inventory, point-of-sale, project management, etc.
The suite of open source apps are very easy-to-use and full integrated: the customer deploy the base Odoo distribution in Odoo cloud with few clicks or in their on-premises server/cloud, and the apps can be integrated without pains.
Because every apps needed for business such as CRM,  point-of-sale management, etc. are available in the eco-system, installing can be done in some single steps and integration are with no pain.

<!--more-->

## Which Odoo edition should I use?

### Comparisons
Odoo has two different editions: [Odoo Enterprise and Community](https://www.odoo.com/page/editions).
The enterprise edition provides better support and richer set of features.
With community edition, the company pay less for an usable solution but with lack of some useful features:

* No mobile app.
* No integration to commercial platforms like Amazon and eBay.
* No digital sign, subscription, gift programs, VoIP supports.
* No custom supports such as field services, AI/IoT solutions, payroll OCR, scheduling, maintenance, etc.
* No social and marketing automation.

Not every features are needed by the companies and you should consider the need of your company first.

### Odoo Enterprise
There are several aspects to care about the pricing of introducing Odoo Enterprise to your organization:

* _The number of users_: Odoo license will be applied on the number of employees. Note that, employees who report their timesheet are counted as users. New customers obtain a 15% discount for each user at the time of this post.
* _The number of apps_: Only CRM app is coming with the base Odoo Enterprise. The price of each additional app ranges from 4 to 8 dollars.
* _Where do you host Odoo?_: There are 3 hosting types: Cloud hosting, on-premises, and [Odoo.sh platform](https://www.odoo.sh/). The first two options add no extra costs. You will pay by yourself to Cloud provider (AWS, IBM Cloud, etc.) or server costs. For the third option, the [Odoo.sh platform](https://www.odoo.sh/), you can find a simulation below with a 50-employee company, using 50GB of data every month, 1 staging environment, and they will pay about 207.20 dollars monthly.
I follow the rule-of-thumb as discussed [here](https://www.odoo.com/forum/help-1/how-many-workers-do-i-need-with-odoo-sh-145771).
1 worker would be equal to 25 users, then for 50 employees, we would like to have 3 workers.

![](/assets/img/odo.sh-pricing.png)
*Source: [https://www.odoo.sh/pricing](https://www.odoo.sh/pricing)*

* _How do you implement Odoo?_: After purchasing license to Odoo Enterprise, you can implement by 3 ways: by yourself, by using [Odoo Success Packs](https://www.odoo.com/pricing-packs), or by asking help from a partner company. The first option cost you nothing. The second will be available only if Odoo has some branches in your neighborhood. It will cost at least 975 dollars (after a 15% discount for new customers). The final option is to check the list of Odoo partner company in your area, and asking them for installation and maintenance supports. Except the first option (implementing by yourself), every options to install and maintain a distribution of Odoo Enterprise require at least 1000$/year. If you put Odoo Enterprise in your own server, Odoo Success Packs are not applied.

Let's get some example of cost model for Odoo Enterprise in a medium-sized company:

*Example 1*: Company A has 50 employees but only 15 users (HRs, accountants and sales) use Odoo.
They use 37 apps (excluding CRM) and [Odoo.sh platform](https://www.odoo.sh/) with [Odoo Success Packs](https://www.odoo.com/pricing-packs) Standard.
It requires 1 Odoo Cloud Worker, with 100GB data storage and 1 staging enviroment.
This costs A 92 dollars per month.

| **Item** | **Quantity** | **Price** | **Cost ($)** |
| === | === | === | === |
| Employees usage | 15 | 8$/user | 120 |
| Discount on employees usage | 12 | -2$/user | -30|
| App usage | 37 apps | 5$/app | 304 |
| Hosting (Odoo.sh) | 1 | 92 | 92 |
| Implementation (Success Packs Standard) | 1 | 333.33 | 333.33 |
| Discount on Success Packs Standard | 1 | -50 | -50 |
| === | === | === | === |
| **Total** | | | **769.33/month** |

![](/assets/img/odo.sh-pricing-2.png)
*Source: [https://www.odoo.sh/pricing](https://www.odoo.sh/pricing)*

*Example 2:* Company B has 50 employees but only 15 users (HRs, accountants and sales) use Odoo.
They use 37 apps (excluding CRM). 
They choose to buy the Enterprise pack but buy no Odoo.sh or Success Packs. They will implement by themselves.

| **Item** | **Quantity** | **Price** | **Cost ($)** |
| === | === | === | === |
| Employees usage | 15 | 8$/user | 120 |
| Discount on employees usage | 15 | -2$/user | -30|
| App usage | 37 apps | 5$/app | 304 |
| Hosting (Odoo.sh) | 0 | 207.20 | 0 |
| Implementation (Success Packs) | 0 | 333.33 | 0 |
| Discount on Success Packs | 0 | -50 | 0 |
| Customer hosting service | 1 | 200 | 200 |
| Development and maintenance | 1 | 200 | 200 |
| === | === | === | === |
| **Total** | | | **794.00/month** |

![](/assets/img/odo.sh-pricing-3.png)
*Source: [https://www.odoo.sh/pricing](https://www.odoo.sh/pricing)*

The development and maintenance which company B pay for is to the developers who implement and maintain the Odoo distribution in the company.
In normal cases, there will be one or two person in charge for this stuff.
Note that, this is the lowest prices the author found.
Comparing to example 1, company B pay a little bit in total, and the processes will rely more on human, and will be more **prone to human errors**. 

**_Huh, ready-to-use solution is cheaper than self-service solution, right?_**

### [Odoo Community](https://www.odoo.com/page/community)

The pricing model will become simpler, but you will have to implement and find hosting services yourself.
Then, a sufficient background on Odoo Community edition and deployments will be required.
**You only pay for hosting services and people who implement Odoo on your business.**
Note that, although the community edition does not come with some custom apps, but there is a third-party community which provide many alternatives for free and paid: [https://apps.odoo.com/](https://apps.odoo.com/).
Furthermore, when the app you need isn't in the given third-party community, you can start adding such idea to the community since the development of Odoo is completely open source. (However, it might be better to have ready-to-use solutions).
**The process will be highly dependent on human, and will be prone to human errors.**
Comparing to example 2, this solution will cost less, but the customer hosting price and Development/Maintenance costs might not be changed.
So will similar quality, it only reduces about 60% in the part of costs for Odoo apps.
And because you will need specialized personnel to implement custom Odoo apps, the cost for Development/Maintenance can increase.


# Deploying Odoo to Amazon Web Service (AWS)

After understanding the pricing model and the merits and demerits of each editions, we will go to the deployment with [Odoo Community](https://www.odoo.com/page/community) to AWS EC2, Aurora for better understanding.

## Setup VPC in a defense-in-depth style

## Setup SSH Bastion server for further investigation

## Setup Aurora instance

## Deploy Odoo 14.0

# Conclusion

In the first section, we compare available solution for deployment of Odoo (both paid and free editions).
Surprisingly, we found that paid solution, the **Odoo Enterprise can be cheaper than using the free solutions if we count all development and maintenance fees**.
And because this is a reliable and stable solution, **Odoo Enterprise with full support from Odoo Cloud Platform** is definitely more advantageous with less effort (you and your people can sleep well).
From the view of business, the winner is determined.

In the second part, although using the community edition does not offer any real benefit in business, we still explored the way to deploy by ourselves to AWS.

In conclusion, ready-to-use solutions like Odoo Enterprise with Odoo Cloud seem to be the winner.