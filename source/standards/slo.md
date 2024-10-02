---
title: Make data-driven decisions with service level objectives
eleventyNavigation:
  parent: Logging, monitoring and alerting
last_reviewed_on: 2022-07-26
review_in: 6 months
permalink: standards/slo.html
---

Service level objectives (SLOs) set out a target level for your service’s reliability. Using SLOs helps you make data-driven decisions about the [opportunity cost](https://www.investopedia.com/terms/o/opportunitycost.asp) of reliability work.

You can use SLOs and error budgets alongside [service level indicators](/standards/slis.html) (SLIs) to help you make better decisions.

SLOs help you decide how to prioritise reliability work, such as bug fixes and architectural improvements, by stating the problem in a user-centric way. For example, ‘this bug affects 10% of users’ or ‘this will provide a faster experience for the users by 500ms’.

## What you’ll need to know before setting your SLOs

### Current SLI levels

Current performance based on SLIs is usually a good place to start, especially if you do not have any other information. It also helps to set a baseline that you can improve to reflect service objectives.

### Your dependencies

You’ll need to know the SLOs for services your service relies on. For example, your [hosting provider](/standards/hosting.html) or any other components that are important to your users’ experience.

### User satisfaction

You’ll need to be aware of current user satisfaction levels. SLOs give users an expectation about the level of reliability they can expect from your service. Users are more likely to complain or stop using the service if it drops below the target level.

If your users are happy with the availability and latency of your service you can set your SLOs based on your current SLIs.

In other cases, your user expectations will lead to a set of SLOs the service’s current architecture may not achieve. You can reduce the gap between expectations and your SLOs by using techniques like [ratcheting](https://martinfowler.com/articles/useOfMetrics.html#MetricsAsARatchet).

## Setting your first SLOs

### Use the SLIs as a reference

Your SLIs will give you a good idea of how your current platform is doing and give you a baseline reference.


### Choose a time window

You should report SLOs over a set period of time. For most purposes, a 4-week rolling window works well.

A shorter time window lets you make decisions and iterate development more quickly, such as prioritising bug fixes. You could also set your time window over a longer period of time. This can be better for more strategic decisions and can align with your business calendar.

### Choose a SLO Target

You should consider setting an SLO target with technical, product and business implications.

Although your current performance (SLIs) should be taken into account, you should not set an SLO target based on the current performance to lock you into supporting the system with overachieving goals. Balance the SLO target with your product and business objectives.

### Create error budgets

Error budgets help you know when to prioritise reliability work and when to prioritise new features. They provide an absolute value to a process and help determine when you need to take action.

You can work out the error budgets from your SLOs. For example, if your SLO on availability is 99.9%, your error budget is 0.1% of the request volume. For example, if your service had 1 million requests, your error budget will be 1,000. This works out at 40 minutes of outage in your 4-week rolling window.

An error budget is usually expressed as a percentage rather than an absolute value. This can help you to focus on what the error means to your users. For example, if your service has 435 errors during the SLO period, it would have used up:

435/1000x100% = 43.5%

of its error budget.

If your error rate, which is the number of bad requests in this case, is less than 1,000 you’ve met your error budget.


### SLO burn rate and alerts

SLO burn rate is how fast, relative to the SLO, the service consumes the error budget.  An alerting window is defined to capture errors accumulated within this period before alerting.

Team should capture both sudden, fast SLO burn, which may be caused by an incident or bug; and gradual, slow SLO burn, which may be caused by system degradation and scalability issues.

### Using error budgets to create policy

You can use error budgets to create policies, which are the actions you need to take when your service has used up, or nearly used up, its error budget for the period.

For example, your policy could state that you:

*   stop launching features until the SLO is met again
*   devote 80% of developer time to reliability-related bug fixing

SLO and error budgets can also help data-driven decision making.

This table is an example of how you can use a combination of your SLO and user satisfaction to decide what action to take.

<table>
  <tr>
   <td>SLOs
   </td>
   <td>Toil
   </td>
   <td>Customer satisfaction
   </td>
   <td>Action
   </td>
  </tr>
  <tr>
   <td>Met
   </td>
   <td>Low
   </td>
   <td>High
   </td>
   <td>Choose to (a) relax release and deployment processes and increase velocity, or (b) step back from the engagement and focus engineering time on services that need more reliability
   </td>
  </tr>
  <tr>
   <td>Met
   </td>
   <td>Low
   </td>
   <td>Low
   </td>
   <td>Tighten SLO
   </td>
  </tr>
  <tr>
   <td>Met
   </td>
   <td>High
   </td>
   <td>High
   </td>
   <td>If alerting is generating false positives, reduce sensitivity. Otherwise, temporarily loosen the SLOs (or offload toil) and fix product and/or improve automated fault mitigation
   </td>
  </tr>
  <tr>
   <td>Met
   </td>
   <td>High
   </td>
   <td>Low
   </td>
   <td>Tighten SLO
   </td>
  </tr>
  <tr>
   <td>Missed
   </td>
   <td>Low
   </td>
   <td>High
   </td>
   <td>Loosen SLO
   </td>
  </tr>
  <tr>
   <td>Missed
   </td>
   <td>Low
   </td>
   <td>Low
   </td>
   <td>Increase alerting sensitivity
   </td>
  </tr>
  <tr>
   <td>Missed
   </td>
   <td>High
   </td>
   <td>High
   </td>
   <td>Loosen SLO
   </td>
  </tr>
  <tr>
   <td>Missed
   </td>
   <td>High
   </td>
   <td>Low
   </td>
   <td>Offload toil and fix product and/or improve automated fault mitigation
   </td>
  </tr>
</table>

Table credit: [https://sre.google/books/](https://sre.google/books/)

Your team should agree on the SLOs and error budget policies. It’s useful to get agreement from the:

* product manager
* delivery manager
* technical architect
* developers
* site reliability engineers

### Continuous improvement of SLOs

You can use your user research and outage records to improve your SLOs. Eventually you’ll be able to set your SLOs by user experience. For example, if your users are happy with the service’s performance, you can experiment with relaxing your SLOs and measure the resulting user satisfaction.

## Further reading

* [Service Level Objectives](https://sre.google/sre-book/service-level-objectives/) - chapter 4 of the [Google SRE handbook](https://sre.google/books/)
* [Alerting on SLOs](https://sre.google/workbook/alerting-on-slos/) - chapter 5 of the [Google SRE handbook](https://sre.google/books/)
* [Liz Fong-Jones - Adopting SRE and Error Budgets](https://www.youtube.com/watch?v=7VeU6LnOUms)
