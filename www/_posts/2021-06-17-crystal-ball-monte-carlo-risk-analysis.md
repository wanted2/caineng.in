---
layout: post
title: "Using Oracle CrystalBall for Monte Carlo Simulation based Risk Analysis"
excerpt_separator: "<!--more-->"
categories:
  - pm
tags:
  - project management
  - pmi
  - startup
  - finance
  - project manager
  - risk analysis
  - monte carlo
  - microsoft excel
  - microsoft office 365
  - microsoft office
toc: true
---
![](/assets/img/cb02.PNG)
__Uncertainty__ is everywhere in the lifecycle of a project.
The duration of activities, resources to assign to actions, and schedules are all uncertain.
Project managers can manage to reduce the risks associated with uncertainties, but they cannot be eliminated.
__Risk analysis__ helps to identify and sometimes visualize the risks, not to remove risks from projects.
__Oracle CrystalBall (OCB)__ is a simulation software for risk management.
It utilizes Monte Carlo Simulation to consider every possibility that can happen when calculating and predicting the outcomes of their occurrences, thereby giving you the critical part of your model in which to concentrate.

<!--more-->

# Introduction

## Risk Analysis and Monte Carlo Simulation

__Uncertainty__ is everywhere in the lifecycle of a project.
The duration of activities, resources to assign to actions, and schedules are all uncertain.
Project managers can manage to reduce the risks associated with uncertainties, but they cannot be eliminated.
__Risk analysis__ helps to identify and sometimes visualize the risks, not to remove risks from projects.
To apply risk analysis, one must make assumptions about the probability distributions that characterize key parameters and variables associated with a decision and then use these to estimate the risk profiles or probability distributions of the outcomes of the decision.

__Monte Carlo Simulation (MCS)__ works upon an established assumption about distributions of risks and evaluating the risks by computing the values of multiple samples.
Under statistical analysis, a range of values of interests can be selected with confidence.
For example, let's see when we have to estimate _the duration of a task_, which follows normal distributions with the mean is 5 days, and the standard deviation is about 1 day.
Then MCS generates a set of 1,000 samples following the assumptions.
We can find the worst cases and the best cases from simulated results, as the minimum values and the maximum values out of 1,000 samples.

## Oracle CrystalBall

__Oracle CrystalBall (OCB)__ is a simulation software for risk management.
It utilizes Monte Carlo Simulation to consider every possibility that can happen when calculating and predicting the outcomes of their occurrences, thereby giving you the critical part of your model in which to concentrate.
With the Monte Carlo Simulation, your working processes are simplified, including the statistics and the necessary information at its side in split-view format.
The software is an Excel add-in and useful for Excel professionals.

### Get a trial version

Because a license of OCB costs nearly [$1,000](https://shop.oracle.com/apex/product?p1=oraclecrystalball&p2=&p3=&p4=&p5=&sc=ocom_crystalball), we experience the trial version.
Please visit [here](https://www.oracle.com/middleware/technologies/crystalball/downloads.html#) and follow the instruction to download trial versions.
To see the download link, you may need to register for an Oracle account.
Oracle reviews your download request.
In my case, it took less than 24 hours.
Thanks to Oracle!
The download came after the approval.
That download content was:
![](/assets/img/cb03.PNG)

### Installation

Read the guides and then double-click on __crystalballsetup-x64.exe__ and follow the instructions for installation.
The CrystalBall [add-in](https://docs.microsoft.com/en-us/office/dev/add-ins/excel/excel-add-ins-overview) is installed inside Excel and is available for every workbook.
![](/assets/img/cb04.PNG)

# Examples

## Project Selection

Somewhere in the past, we have [discussed](/pm/2021/06/01/discounted-cash-flow.html) about Discounted Cash Flow (or Net-Present Value).

### Problem
A company has been planning to develop a new product.
The project has a hurdle rate $K=0.12$ and prospective inflation rate $p=0.03$.
The __most likely__ cash flows in ten years are as follows.
![](/assets/img/cb05.PNG)
Recall that the _Discounted factor of $t$-th year_ is $d_t=\frac{1}{(1+K+p)^t}$.
Note that the above table is the most likely number.

Now let us assume that the expenditures in this example are fixed by contract with an 
outside vendor.
Thus, there is no uncertainty about the outflows, but there are, uncertainties about the inflows. 
Assume that the estimated inflows are as shown in the below table and include a most likely estimate, a minimum (pessimistic) estimate, and a maximum (optimistic) estimate.
Both the beta and the triangular statistical distributions are well suited for modeling variables with these three parameters, but fitting a beta distribution is complicated and not particularly intuitive. 
Therefore, we will assume that the triangular distribution will give us a reasonably good fit for the inflow variables.

|Year |Minimum Inflow |Most Likely Inflow |Maximum Inflow|
|---|---|---|---|
|2008 |\$35,000 |\$50,000 |\$60,000|
|2009 |95,000 |120,000 |136,000|
|2010 |100,000 |115,000 |125,000|
|2011 |88,000 |105,000 |116,000|
|2012 |80,000 |97,000 |108,000|
|2013 |75,000 |90,000 |100,000|
|2014 |67,000 |82,000 |91,000|
|2015 |51,000 |65,000 |73,000|
|2016 |30,000 |35,000 |38,000|
|---|---|---|---|
|Total |$621,000 |$759,000 |$847,000|

### Register assumption and forecast variables
To do Monte Carlo simulation, we must register our assumptions on the uncertainties of inflows.
Select cell __B5__, and then select the __Define Assumption__ button from the ribbon menu of CrystalBall.
Note that the project was assumed that the project generates no profit in the first three years.
Therefore, we start from 2008 (or cell __B5__).
Then choose the __three-point estimates__.
![](/assets/img/cb06.PNG)
Adjust the parameters of the triangular distribution according to the table in the previous section.
Then click __OK(O)__.
![](/assets/img/cb07.PNG)
Repeat the process for cells __B6:B13__.

To run the simulation, we still need to select a forecasting goal: the total DCF the project will generate after 10 years, or the value of cell __F15__.
Select cell __F15__ and the button __Define Forecast__ from the ribbon menu.
Input the name and the unit as follows.
![](/assets/img/cb08.PNG)
### Simulation
Click button __Start__ in the ribbon menu of CrystalBall to start MCS.
The default number of simulations is 1,000.
After done the simulation, we observe some results like:
![](/assets/img/cb09.PNG)

To find a robust estimation, we can see the __median__: 10,869 USD after 10 years is the expected DCF the project will generate.
Not so much!

# References

{% bibliography --file pm %}