---
layout: post
title: "The Design Structure Matrix and Information Flow"
excerpt_separator: "<!--more-->"
categories:
  - pm
tags:
  - project management
  - pmi
  - startup
  - finance
  - project manager
  - information flow
  - design structure matrix
  - integration engineering
  - concurrent engineering
  - planning
  - action planning
  - multidisciplinary teams
toc: true
---
![](https://dsmweborg.files.wordpress.com/2019/04/dsm_tutorial_basic3_9f5f52512b.jpg)
_Source: dsmweb.org_

Tracking the information flow throughout the project is required for planning the coordinating flows.
Traditional tools like the Gantt chart are good at tracking the interdependency between runs of concurrent tasks but fail to describe the causal dependencies between flows.
This problem is magnified when multidisciplinary teams join the stage.
Hence, the problem becomes increasingly serious while handling many domains at once.
To cope with this issue, __Design Structure Matrix (DSM)__, __Domain Mapping Matrix (DMM)__, and __Multiple Domain Matrix (MDM)__ have been proposed.
While DSM tracks the information flows, DMM can be used to show the person-task assignments.
MDM combines both DSM and MDM in multiple domains, i. e., coordination of not only tasks but also people.
It can track all structures of the team, tasks, and assignments at once.

<!--more-->

## Design structure matrix

Integration management is important because it makes the deliverables regarding customer needs but lacks coordination of flows.
For instance, in the below figure, __task 1__ needs to gather information from task 3 before running.
Such information flow does not appear in previous tools like the Gantt chart.
While not aware of such flow, planning tasks, like which task should be done before a particular task, can result in a mess.
With this schedule, then __task 3__ is completed after __task 1__.
However, __task 1__ requires information flow from __task 3__, thus task 1 must be revisited and reworked after task 3's completed.

![](https://dsmweborg.files.wordpress.com/2019/04/dsm_tutorial_basic3_9f5f52512b.jpg)
_Source: dsmweb.org_

## Concurrency

Concurrent engineering helps to enhance the performance but makes the system is hard to design due to the complexity of dependencies and reworks.
Let's see the example.
The PM can plan to let __task 2, task 3, and task 4__ run concurrently.
What happens here is that there are two situations needing reworks.
The first one was already explained in the first section: task 1 must be updated according to information from task 3.
The second one is task 4 that needs information from task 5, but task 5 also completes after task 2 running concurrently with task 4.

Let's see whether we can eliminate the reworks.
The first solution is to move the mark X above the diagonal: for example, let task 5 inputs directly to task 6, and instead of task 3, task 6 inputs to task 1.
The second solution is to add more activities into the concurrency: for example, add task 5 and task 1 to the concurrency, and all first 5 tasks run concurrently.

## Domain Mapping Matrix

![](https://dsmweborg.files.wordpress.com/2019/04/dmm_tutorial_basic_02_ffbdacd849.jpg)

Instead of working in only one domain, sometimes we may need to map two different domains, such as assignments between people and tasks.
Domain Mapping Matrix shows such assignments in a matrix form.
For example, by watching the above DMM, one can find who is the __Person In Charge (PIC)__ of a task in the project.

## Multiple Domain Matrix

Single-class tracking can be done with DSM in a domain like tasks.
Mapping different domains are done using DMM, then attributions of tasks to identities can be done, too.
But when we have multiple classes (domains), the problem becomes complex.
__Multiple Domain Matrix__ helps to solve the multi-class tracking problem.

![](https://dsmweborg.files.wordpress.com/2019/04/mdm_tutorial_basic.jpg)

MDM is helpful here because it can demonstrate all inter-class and intra-class relationships at once.
Not only the hierarchy of the tasks but also of people in the team can be seen.
## References

{% bibliography --file pm %}