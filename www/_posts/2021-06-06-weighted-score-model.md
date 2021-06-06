---
layout: post
title: "Weighted Score Models"
excerpt_separator: "<!--more-->"
categories:
  - pm
tags:
  - project management
  - pmi
  - startup
  - finance
  - weighted score model
  - project selection models
toc: true
---
![](https://cdn.vietnambiz.vn/thumb_w/685/2020/1/15/photo-1579086844831-15790868448431355134475-crop-1579086898177619343716.jpg)
_Source: VietnamBiz_

In an attempt to overcome some of the disadvantages of profitability models, with one example, the [Discounted Cash Flow](/pm/2021/06/01/discounted-cash-flow.html) we have discussed last time, which particularly their focus on a single decision criterion, a number of evaluation/selection models that use **multiple criteria** to evaluate a project has been developed. 
Such models vary widely in their complexity and information requirements.
**Weighted Factor Scoring Model** is such one flexible method we discuss today.
<!--more-->

## Weighted Score Model (WSM)

The main disadvantage of a profitability model like the DCF is the limitation to a single decision criterion at a time.
A simple solution to integrate multiple criteria into the selection process is to make a project evaluation form, in which each row presents a different criterion of the project with a specific score.
A project council is established with experts to give a score on each criterion.

**Unweighted Binary Factor Model** gives 0-1 score $b_i\in\{0,1\}$ to the project for each criterion.
**Unweighted Score Factor Model** gives a numeric score $s_i\in\mathbb{R}$ with normally at a scale of 5 for each criterion.
The total score of a project is given by
$S=\sum_{i=1}^ns_i,$
where $n$ is the number of criteria.
A sample evaluation form can be as follows (taken from [1]).

> Project _________________________________________________________________________
>
> Rater ____________________________________ Date _________________________________

| Criterion | Qualifies | Does Not Qualify |
| --- | --- | --- |
| No increase in energy requirements | x | |
| Potential market size, dollars |x||
| Potential market share, percent |x||
| No new facility required |x||
| No new technical expertise required ||x|
| No decrease in quality of final product |x||
| Ability to manage the project with current personnel ||x|
| No requirement for reorganization |x||
| Impact on workforce safety |x||
| Impact on environmental standards |x||
| Profitability |||
| Rate of return more than 15% aftertax |x||
| Estimated annual profits more than $250,000 |x||
| Time-to-break-even less than 3 years |x||
| Need for external consultants ||x|
| Consistency with the current line of business ||x|
| Impact on company image |||
|   With customers |x||
|   With our industry ||x|
| Totals |  12 | 5 |

A project with more qualified points is more likely to be accepted.

And the **Weighted Score Factor Model**, each criterion is associated with a weight value $w_i\in (0,1)$ such that the sum of weights is 1.
The final score for a project is then

$S_w = \sum_{i=1}^nw_is_i,~\sum_{i=1}^nw_i=1.$

This model gives flexibility to the evaluation method because the importance of each criterion is modeled by $w_i$ and then differently.
## Problem and Discussion

The following problem is taken from the PM text [1]:

> Use a weighted score model to choose between three methods $(A, B, C)$ of financing the acquisition of a major competitor.
> The relative weights for each criterion are shown in the following table as the scores for each location on each criterion.
> A score of 1 represents unfavorable, 2 satisfactory, and 3 favorable.

In practice, MS Excel is enough to get this done, but we usually use some statistical tools like the Oracle Crystal Ball software [2].
## References

{% bibliography --file pm %}