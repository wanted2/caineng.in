---
layout: post
title: "Planning Waterfall Project Schedule and Resources with Microsoft Project 2019"
excerpt_separator: "<!--more-->"
categories:
  - pm
tags:
  - project management
  - pmi
  - startup
  - finance
  - project manager
  - schedule
  - microsoft project
  - gantt chart
  - critical path model
  - pert analysis
  - waterfall
toc: true
---
![](/assets/img/msp7.png)

Scheduling is the conversion of a project action plan to actionable timetables.
Resource utilization and availability are needed to keep the schedule on time and sometimes help to shorten the runs.
Networks techniques such as Activity-on-Arrow (PERT analysis) and Activity-on-Node (Critical Path Model, or CPM) help establish the schedule.
Resource allocation considers labor, material, facilities, and equipment to achieve the action plan.
Resource allocation requires adjusting the loading and leveling, while constrained planning can be solved using heuristic methods or optimization methods such as linear programming.
While computer-aided scheduling and resource allocation are popular, __Microsoft Project__ is among the best choices for project management software because it supports all the above techniques.
<!--more-->

## Introduction

<img src="/assets/img/msp5.png" style="float: right; margin-left: 20px; margin-bottom: 10px; margin-top: 10px;" width="70%"/>

### Scheduling

Given a Work-Breakdown Structure (WBS), project scheduling concerns the timeline of all activities and events that must be speculated to ensure the delivery to customers is on time and with high quality.
Formal methods for this task establish a network of activities and events, which also highlights the critical events in the network.
The critical activities and events delay the completion of a project if they are delayed.
The order of tasks and dependencies between tasks can be seen in the schedule.
The probability of various completion dates can be estimated then the schedule can be re-evaluated and reworked.

<img src="/assets/img/msp6.png" style="float: left; margin-right: 20px; margin-bottom: 10px; margin-top: 10px;" width="50%"/>
A simple form of the network is the Gantt charts which can be seen in the above figure.
The Gantt chart shows planned and actual progress for a number of tasks displayed as bars against a horizontal time scale.
Program Evaluation and Review Technique (PERT) and Critical Path Model (CPM) are two different networking methods for estimate a project schedule.
With preliminary knowledge from WBS, CPM constructs an Activity-on-Node (AON) network where each node represents an action.
From a start node, with source nodes are predecessors, and target nodes are given tasks, we can construct a graph of tasks.
Each task is assigned an expected time $t_e$.
The longest path $\mathcal{L}$ in the network (with sum of time $T_e=\sum_{e\in\mathcal{L}} t_e$) show the shortest time needed to complete the project.
$\mathcal{L}$ is the _critical path_ and $T_e$ is the _critical time_ of a project.
The right-hand-side figure shows the CPM of 5 tasks with assigned resources (workers and equipment).

Each activity can have some uncertainty in estimating durations; therefore, a stable predictor can be made using a three-point analysis: _optimistic estimates ($a$), pessimistic estimates ($b$), and most likely estimates ($m$)_.
The expected time can be estimated as follows.

$t_e=\frac{a+4m+b}{6}$

The estimates $a,b,m$ can be found when the distribution of duration for an activity is known as a priori.
Then the most likely time $m$ is the mode of the distribution.
PMs select $a$ at the actual time required by the activity will be $a$ or greater about 99 percent of the time.
Similarly, PMs select $b$ at the actual time required is $b$ or less for 99% of the time.
The standard deviation of $t_e$ can be estimated as $\sigma_e=\frac{b-a}{6}$.
For an activity, the slack is the difference between the latest possible start date (LS) and the earliest possible start date (ES), i. e., slack = LS - ES.

With these statistics, the PM can determine the uncertainty of the completion date.
For example, the PM promised that a project finishes in $D$ days.
Then we model the uncertainty by a normal distribution

$Z=\frac{D-T_e}{\sigma_e}\sim \mathcal{N}(0, 1)$

For example, $D=50$ days, $T_e=39$ days, and $\sigma_e=6.15$ days, then the likelihood that the PM can keep the promise is

$\mathcal{N}^{-1}(Z)=\mathcal{N}^{-1}\left(\frac{50-39}{6.15}\right)=\mathcal{N}^{-1}(1.79)\approx 96\%$

In other words, the probability of lateness is only 4%.
The risk assessment, another aspect of the schedules, will be addressed in another article.

### Resource allocation
CPM can be used for resources as well.
However, to accelerate the speed, introducing more resources (or crashing with resources) can be useful.
It is equal to trading time with cost, and this is the essence of __resource allocation problem__.
Resource loading is the amount of a specific resource to finish an activity in a period.
For example, to finish a task, we need 2 labor-hour, then that is the resource loading.
In reality, the resource loading can be uneven during the project lifetime.
Resource leveling concerns making the loading even throughout the project time.
It is done by shifting the tasks within their slack allowances.
In other words, leveling helps to __stabilize the workloads__ over time.

One concern for the PMs is how many workers should be hired for a given workload?
If the workload is uneven, then the number of workers and other resources must be sufficient to handle the peak.
In other periods, when the workload is much lower than the peak workload, the worker pool size can be adjusted to avoid waste.

### Microsoft Project

MSP is a multi-scale project management software that handles from small projects to large ones.
It supports multiple views such as grid view and board view for better reporting.
Statistical analyses like CPM and PERT are supported.
Gantt charts are supported in both cloud and desktop solutions.

In this practice, we use MSP for scheduling and resource allocation with analytics.
We use the priority rule of __As Soon as Possible (ASAP)__.

## Preparation

### Sample data

In this practice, we use the sample project WBS is from a typical software development project. Please download the data from the following resource.

* Software development project WBS (from University of Ohio): [download](http://regents.ohio.gov/obrpmcop/forms/examples/ex_wbs_sd.doc)

The sample project consists of 6 phases:

* Phase 1: Requirements Definition
* Phase 2: Logical Design
* Phase 3: Physical Design
* Phase 4: Programming and Unit Testing
* Phase 5: System Testing
* Phase 6: Installation

For simplicity, we only take a subset for example:

```
1	Requirements Definition (Phase 1)
  1.01	Requirements funding
    1.01.01	Review project request
    1.01.02	Establish preliminary justification
    1.01.03	Fund Phase 1
    1.01.04	Prioritize project
    1.01.05	Establish project team

```
### Register for an evaluation version of Project
Unfortunately, Microsoft Project is non-free.
Price for monthly users starts from 10\$/user.
Fortunately, they provide us an evaluation version for 30 days.

Please visit [https://www.microsoft.com/en-us/evalcenter/evaluate-project](https://www.microsoft.com/en-us/evalcenter/evaluate-project) and choose __Project Plan 3__ and click __Continue__ button.

![](/assets/img/msp1.png)

Follow the step-by-step instructions to have an account set up.
Visit [https://portal.office.com/account/?ref=MeControl#subscriptions](https://portal.office.com/account/?ref=MeControl#subscriptions) you can see as follows.

![](/assets/img/msp2.png)

Visit [https://portal.office.com/account/?ref=MeControl#installs](https://portal.office.com/account/?ref=MeControl#installs) and click __Install Project__ button to get the download file.
After downloading, please double-click and follow the guides to install.
After installation, you may need to log in to your Microsoft account registered in the previous steps.

![](/assets/img/msp3.png)
## Execution

From the __Start screen__ of MSP, please select __Waterfall project__.
Although __Sprint project__ is available, we will explain it in another article.

![](/assets/img/msp7.png)

### Register tasks

In the Waterfall project, the default view is the __Gantt chart__.
Now, we need to input by hands the WBS tasks.
Note that the default unit for Waterfall projects works is days. 
Then workers will be awarded daily.
__Is this a good cost performance?__

<img src="/assets/img/msp8.png" style="float: left; margin-right: 20px; margin-bottom: 10px; margin-top: 10px;" width="50%"/>

In reality, it is better to make payrolls by precisely to hours and even by minutes.
For example, worker A registers a task S for 1 working day.
But in fact, nobody spends all 8 working hours just for work!
A study has shown that about 12% of working hours have been spent on other things like visiting toilets, .etc. or _personal time_.
Estimating task durations by minutes or hours helps to reduce such uncertainty.
MSP supports measurements by minutes, but of course, hourly payment is good enough.
Select __Options > Schedule > Input worktime unit__ to __minutes__.

To view the state of distributed tasks, you can switch the view

![](/assets/img/msp9.png)

Assigned workers and resources can be shown, too.

### Register resources

Please switch to __Resource Sheet__ view.

![](/assets/img/msp10.png)

There are two kinds of resources: noncurrent assets like equipment which price is fixed with one-time payments, and other resources which must be paid by hourly or monthly payments such as labors of office rental fees.
Of course, office rental fees aren't counted in many cases, especially for remote workers.

In this case, we have one worker and one PC (laptop) that are assigned to the tasks.
For this case, we assign the price of 2,000 JPY per hour (tax included) to the payment.
Overtime is paid by 2,500 JPY per hour.
__Note that when the tasks of the same person are executed parallel, the total time is a sum!__
Then the working time is doubled, and any hours exceed 8 hours per day will be counted as overtime.

To avoid payments for such __concurrency caused overtime__, the PMs should:

* __Break down the tasks smaller and make them executed sequentially within the 8-hour frame__.
* Pay by hours or minutes for non-contract workers. 

<img src="/assets/img/msp6.png" style="float: right; margin-left: 20px; margin-bottom: 10px; margin-top: 10px;" width="50%"/>
__If they are contract workers, PMs don't need to care about the units but need to break down tasks__.
After registering the resources, switch back to the __Gantt chart__ view, and assign the resources to tasks.

Under the __Report__ tab, there are many other views that are useful.
Readers are recommended to explore by themselves.

![](/assets/img/msp4.png)

### View Critical Paths
<img src="/assets/img/msp11.png" style="float: left; margin-right: 20px; margin-bottom: 10px; margin-top: 10px;" width="50%"/>
Switch to the __Gantt chart__ view, and from the __View__ tab in the ribbon, choose __Critical__ as the filter.
We will observe the Critical Paths automatically as follows.

![](/assets/img/msp12.png)
### PERT Analysis

We use the macro from [https://github.com/flametron/MSProject-2019-PERT](https://github.com/flametron/MSProject-2019-PERT).
With the weight combinations $(1,4,1)$ we have the estimates of __Duration__:

![](/assets/img/msp13.png)

## Conclusion

We explained several concepts in project scheduling and resource allocations.
We also experienced with the Microsoft Project 2019 to handle scheduling problems and resource assignments.
We applied some tips to reduce project costs.

## References

{% bibliography --file pm %}