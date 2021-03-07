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
  - AWS
  - ec2
  - aurora
  - PostgreSQL
  - SQL
  - CRM
  - odoo
---
![Odoo perf](https://odoocdn.com/openerp_website/static/src/img/2020/home/market_position_update.svg)
*Source: [Odoo website](https://odoocdn.com/openerp_website/static/src/img/2020/home/market_position_update.svg)*

# Introduction

## What is Odoo?
[Odoo](https://www.odoo.com/) is an open-source software platform and eco-system for business apps that cover all your company needs: CRM, e-commerce, accounting, inventory, point-of-sale, project management, so on.
The suite of open source apps is very easy-to-use and fully integrated: the customers deploy the base Odoo distribution in the Odoo cloud with few clicks or their on-premises server/cloud, and integration of the apps is without pains.
Because every app needed for business as CRM and point-of-sale are available in the eco-system, installing can be done in some single steps.

<!--more-->

## Which Odoo edition should I use?

### Comparisons
Odoo has two different editions: [Odoo Enterprise and Community](https://www.odoo.com/page/editions).
The enterprise edition provides better support and a richer set of features.
With community edition, the company pays less for a usable solution but with lack of some useful features:

* No mobile app.
* No integration to commercial platforms like Amazon and eBay.
* No digital sign, subscription, gift programs, VoIP supports.
* No custom supports such as field services, AI/IoT solutions, payroll OCR, scheduling, maintenance.
* No social and marketing automation.

### Odoo Enterprise
There are several aspects to care about the pricing of Odoo Enterprise to your organization:

* _The number of users_: Odoo license is applied to the number of employees. Note, employees who report their timesheets are counted as users. New customers obtain a 15% discount for each user at the time of this post.
* _The number of apps_: Only CRM app is coming with the base Odoo Enterprise. The price of each additional app ranges from 4 to 8 dollars.
* _Where do you host Odoo?_: There are 3 hosting types: Cloud hosting, on-premises, and [Odoo.sh platform](https://www.odoo.sh/). The first two options add no extra costs. You pay by yourself to the Cloud provider (AWS, IBM Cloud) or server costs. For the third option, the [Odoo.sh platform](https://www.odoo.sh/), you can find a simulation below with a 50-employee company, using 50GB of data every month, 1 staging environment, and they pay about 207.20 dollars monthly.
I follow the rule-of-thumb as discussed [here](https://www.odoo.com/forum/help-1/how-many-workers-do-i-need-with-odoo-sh-145771).
1 worker would be equal to 25 users.
Therefore with 50 employees, we would like to have 3 workers.

![](/assets/img/odo.sh-pricing.png)
*Source: [https://www.odoo.sh/pricing](https://www.odoo.sh/pricing)*

* _How do you implement Odoo?_: After purchasing the license to Odoo Enterprise, you can implement it in 3 ways: by yourself, using [Odoo Success Packs](https://www.odoo.com/pricing-packs), or by asking help from a partner company. The first option charges you nothing. The second one is available only if Odoo has some branches in your neighborhood. It charges at least 975 dollars (after a 15% discount for new customers). The final option is to check the list of Odoo partner companies in your region and asking them for installation and maintenance supports. 
Every option to install and maintain a distribution of Odoo Enterprise requires at least 1000$/year, except the first one. 
If you put Odoo Enterprise in your server, Odoo Success Packs are not applied.

Let's get some example of pricing model for Odoo Enterprise in a medium-sized company:

*Example 1*: Company A has 50 employees with only 15 users (Human Resource teams, accountants, sales) use Odoo.
They use 37 apps (excluding CRM) and [Odoo.sh platform](https://www.odoo.sh/) with [Odoo Success Packs](https://www.odoo.com/pricing-packs) Standard.
It requires 1 Odoo Cloud Worker, with 100GB data storage and 1 staging environment.
This plan costs A 92 dollars per month.

| **Item** | **Quantity** | **Price** | **Cost ($)** |
| === | === | === | === |
| Employees usage | 15 | 8$/user | 120 |
| Discount on employees usage | 12 | -2$/user | -30|
| App usage | 37 apps | 8.22$/app | 304 |
| Hosting (Odoo.sh) | 1 | 92 | 92 |
| Implementation (Success Packs Standard) | 1 | 333.33 | 333.33 |
| Discount on Success Packs Standard | 1 | -50 | -50 |
| === | === | === | === |
| **Total** | | | **769.33/month** |

![](/assets/img/odo.sh-pricing-2.png)
*Source: [https://www.odoo.sh/pricing](https://www.odoo.sh/pricing)*

*Example 2:* Company B has 50 employees with only 15 users (Human Resource teams, accountants, sales) use Odoo.
They use 37 apps (excluding CRM). 
They choose to buy the Enterprise pack but buy no Odoo.sh or Success Packs.

| **Item** | **Quantity** | **Price** | **Cost ($)** |
| === | === | === | === |
| Employees usage | 15 | 8$/user | 120 |
| Discount on employees usage | 15 | -2$/user | -30|
| App usage | 37 apps | 8.22$/app | 304 |
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
In usual cases, there are one or two people in charge of this stuff.
Note, this is the lowest price the author found.
Comparing to example 1, company B pays a little bit in total, and the processes rely more on human workers and are more **prone to human errors**. 

**_Huh, a ready-to-use solution is cheaper than a self-service solution, right?_**

### [Odoo Community](https://www.odoo.com/page/community)

The pricing model becomes affordable, but you have to implement and find hosting services yourself.
Then, a sufficient background on the Odoo Community edition and deployments are required.
**You only pay for hosting services and people who implement Odoo on your business.**
Note that, although the community edition does not come with some custom apps, there is a third-party community with many alternatives for free and paid: [https://apps.odoo.com/](https://apps.odoo.com/).
Furthermore, when the app you need in the given third-party community, you can start adding an idea to the community since the development of Odoo is fully open-source. (However, it might be better to have ready-to-use solutions).
**The process is highly dependent on human and is prone to human errors.**
Compared to the second example, this solution costs less, but the customer hosting price and Development/Maintenance costs might not be changed.
So will similar quality, it only reduces about 60% for Odoo apps.
And because you need specialized personnel to implement custom Odoo apps, the cost for Development/Maintenance can increase.


# Deploying Odoo to Amazon Web Service (AWS)

After understanding the pricing model and the merits and demerits of each edition, we go to the deployment with [Odoo Community](https://www.odoo.com/page/community) to AWS EC2, Aurora for better understanding.

## Setup VPC in a defense-in-depth style

## Setup SSH Bastion server for further investigation

## Setup Aurora instance

## Deploy Odoo 14.0

# Conclusion

In the first section, we compare available solutions for deployments of Odoo (both paid and free editions).
Surprisingly, we found that paid solution, the **Odoo Enterprise can be cheaper than using the free solutions if we count all development and maintenance fees**.
And because this is a reliable and stable solution, **Odoo Enterprise with full support from Odoo Cloud Platform** is more advantageous with less effort (you and your people can sleep well).
From the view of business, the winner is determined.

In the second part, although using the community edition does not offer any real benefit in business, we still explored the way to deploy by ourselves to AWS.

In conclusion, ready-to-use solutions like Odoo Enterprise with Odoo Cloud seem to be the winner.