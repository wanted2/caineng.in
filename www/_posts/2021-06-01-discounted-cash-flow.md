---
layout: post
title: "Discounted Cash Flow and The Hiring of a Postdoc"
excerpt_separator: "<!--more-->"
categories:
  - pm
tags:
  - project management
  - pmi
  - startup
  - finance
  - cash flow
toc: true
---

![](https://upload.wikimedia.org/wikipedia/commons/2/23/US_one_dollar_bill%2C_obverse%2C_series_2009.jpg)
_Source: Wikipedia_

In the winter of 20xx, a professor was asked to evaluate a postdoc profile for hiring.
The offer is about 4.2 million per year (currency is not revealed).
An average postdoc lifetime is about 5 years (and then moving towards tenure or perish).
The inflation rate is about 3% per year.
The sponsors of the professor's project can give 50 million for five years.
__What is the hurdle rate__ that makes the profile (together with the project) is acceptable?
<!--more-->

## Assumptions

* Assume that the profile is trusted that the holder can produce sufficient works in a year worths 4.2M.

* Although 50M will flow to the project, other stuff also needs money.
Hence, the professor themselves also needs to pay themselves.
Then let's say about 21M will be secured for paying the postdoc.

## Discounted Cash Flow

Also referred to as the net present value (NPV) method, the discounted cash flow method determines the net present value of all cash flows by discounting them by the required rate of return (also known as the __hurdle rate__, cutoff rate, and similar terms) as follows:

$\mbox{DCF} = I_0 + \sum_{t=1}^T\frac{F_0}{(1+h+p)^t},$
where, 
* $I_0<0$ is the initial investment, and in this case, $I_0=-21$M, which is a negative value
* $T=5$ is the total number of phases.
* $F_0$ is the net cash flow in phase $t$
* $h$ is the hurdle rate, i.e., the percentage of gross-income which must be returned to the investors (project's sponsors)
* $p=0.03$ is the inflation rate.

Now, by substitution in to their case,

$\mbox{DCF} = -21 + \sum_{t=1}^5\frac{F_0}{(1+h+0.03)^t}$.

If the DCF is non-negative then the postdoc is deemed acceptable, else rejected.


## When $h=15$% then how much the postdoc must produce every year?

Let's say the sponsors require 15% of the gross-income made by the work of the postdoc.
Then which $F_0$ must be to make the DCF non-negative?

We would solve the equation:

$DCF =-21 + F_0\sum_{t=1}^5\frac{1}{(1+0.15+0.03)^t} \geq 0$
or,
$-21+F_0\times 3.127 \geq 0$

Then the money the postdoc is expected to make each year in the following 5 years is $F_0\geq \frac{21}{3.217}=6.7$M.
In other words, if the sponsors require 15% of gross-income, the postdoc must make more 2.5M than the cash they are paid.


## When $h=5$% then how much the postdoc must produce every year?

We would solve the equation:

$DCF =-21 + F_0\sum_{t=1}^5\frac{1}{(1+0.05+0.03)^t} \geq 0$
or,
$-21+F_0\times 3.993 \geq 0$

Then the money the postdoc is expected to make each year in the following 5 years is $F_0\geq \frac{21}{3.993}=5.2$M.
In other words, if the sponsors require only 5% of gross-income, the postdoc must make 1M than the cash they is paid every year.

## What if the offer is only 3.5M in gross-income and the initial investment is only 17.5M?

In case of hurdle rate is 5%, then the value the postdoc must make is $\frac{17.5}{3.993}=4.4M$.
The expectation is low, and matching the ability of the postdoc (their profile can make 4.2M per year as evaluated), then __lower salary lower duty__, straight life!

In case of hurdle rate is 15%, then the value the postdoc must make is $\frac{17.5}{3.127}=5.6M$.
The expectation is higher than the ability of the postdoc (their profile can make 4.2M per year as evaluated).


## Conclusion: what's the strategy?

The best deal for their postdoc is to negotiate with the professor and the sponsors to have:
* hurdle rate is 5%; and
* annual income is only 3.5 million.

Otherwise, overtime is frequent, and their life will be destroyed.
