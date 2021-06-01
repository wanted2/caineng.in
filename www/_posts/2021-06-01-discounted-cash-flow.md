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

In the winter of 20xx, a professor was asked to evaluate a postdoc profile for hiring.
The offer is about 4.2 million per year (currency is not revealed).
An average postdoc lifetime is about 5 years (and then moving towards tenure or perish).
The inflation rate is about 3% per year.
The sponsors of the professor's project can give 50 million for five years.
__What is the hurdle rate__ that makes the profile (together with the project) is acceptable?
<!--more-->

## Assumptions

* Assume that the profile is trusted that the holder can produce sufficient works in one year which worths 4.2M.

* Although 50M will flow to the project, many other stuffs also need money and the professor himself also need to be paid. Then let's say about 21M will be secured for paying the postdoc.

## Discounted Cash Flow

Also referred to as the net present value (NPV) method, the discounted cash fl ow method determines the net present value of all cash fl ows by discounting them by the required rate of return (also known as the __hurdle rate__, cutoff rate, and similar terms) as follows:

$\mbox{DCF} = I_0 + \sum_{t=1}^T\frac{F_0}{(1+h+p)^t},$
where, 
* $I_0<0$ is the initial investment, and in this case, $I_0=-21$M, which is a negative value
* $T=5$ is the total number of periods.
* $F_0$ is the net cash flow in period $t$
* $h$ is the hurdle rate, i.e., the percentage of gross income which must be returned to the investors (project's sponsors not the professor himself)
* $p=0.03$ is the inflation rate.

Now, by substitution in to this case,

$\mbox{DCF} = -21 + \sum_{t=1}^5\frac{F_0}{(1+h+0.03)^t}$.

If the DCF is non-negative then the postdoc is deemed acceptable, else rejected.


## When $h=15$% then how much the postdoc must produce every year?

Let's say the sponsors require 15% of the gross income made by the work of the postdoc.
Then which $F_0$ must be to make the DCF non-negative?

We would solve the equation:

$DCF =-21 + F_0\sum_{t=1}^5\frac{1}{(1+0.15+0.03)^t} \geq 0$
or,
$-21+F_0\times 3.127 \geq 0$

Then the value the postdoc is expected to make each year in next 5 years is $F_0\geq \frac{21}{3.217}=6.7$M.
In another word, if the sponsor require 15% of gross income, the postdoc must make more 2.5M than the cash he is paid.
