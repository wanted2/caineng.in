---
layout: post
title: "Using Oracle Crystal Ball for Monte Carlo Simulation based Risk Analysis"
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
toc: true
---
![](/assets/img/cb02.PNG)


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
Then MCS generates a set of 1,000 samples following the assumption.
We can find the worst cases and the best cases from simulated results, as the minimum values and the maximum values out of 1,000 samples.

## Oracle Crystal Ball

__Oracle Crystal Ball (OCB)__ is a simulation software for risk management.
It utilizes Monte Carlo Simulation to consider every possibility that can happen when calculating and predicting the outcomes of their occurrences, thereby giving you the critical part of your model in which to concentrate.
With the Monte Carlo Simulation, your working processes are simplified, including the statistics and the necessary information at its side in split-view format.
The software is an Excel add-in and useful for Excel professionals.

### Get a trial version

Although a license of OCB costs nearly [$1,000](https://shop.oracle.com/apex/product?p1=oraclecrystalball&p2=&p3=&p4=&p5=&sc=ocom_crystalball), we experience the trial version.
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
The Crystal Ball add-in is installed inside Excel and is available for every sheet.
![](/assets/img/cb04.PNG)

# Examples

## Project Selection

## Scheduling

# References

{% bibliography --file pm %}