---
title: Service Level Indicators
last_reviewed_on: 2018-09-17
review_in: 6 months
---

## Service Level Indicators

A **Service Level Indicator**, or SLI, is “A carefully defined quantitative
measure of some aspect of the level of service that is provided” (*Site Reliability Engineering*,
[Chapter 4](https://landing.google.com/sre/book/chapters/service-level-objectives.html#indicators-o8seIAcZ)).
In other words, it is a specific instance of a metric you care about in your
service.

Common examples are measures like:

* request latency
* error rate
* service availability

A related concept is the **Service Level Objective**. This defines the target
value for the SLO. For example, using the SLIs above, the SLOs might be:

* 95% of requests served within .5 second
* 0.1% error rate
* 99.99% service availability

Some services may also have a **Service Level Agreement**, which is an official
contract with the users and often includes consequences if the targets are not
met.

The **error budget** is related to the SLO and represents the amount the service
is allowed to deviate from 100% performance over a certain time period. For
example, a service that has a target of 99.9% successful requests, and which
serves 1 million requests a month, would have an error budget permitting 1000
errors in that period.

SLIs and SLOs can be a useful way of prioritising what needs to be worked on
next. Comparing the actual values of the SLIs to the SLOs can determine whether
action is needed in a particular area and how urgent it is.

### Choosing SLIs for your product

It is important to frame the discussion about which SLIs to choose in terms of
the users. What do the users care about? What promises are you trying to uphold?
When would users stop using the service because it's not reliable enough?

Be careful not to choose too many SLIs; the Google SRE book recommends "a
handful of representative indicators".

Think about how users interact with the system, and what would need to be
measured for each indicator. How would you collect the data?

For each SLI, you can then go on to choose the specific value you want to hit
as the SLO. It is fine to iterate on these values; better to pick a broader
target which can be tightened than to pick a target which is impossible to
achieve because it is too strict.

An SLI can have multiple thresholds. For instance, you might specify that 90% of
requests are faster than 100 ms, and 99% of requests are faster than 400 ms.

Document the rationale behind the chosen values - even if the choice is
arbitrary to begin with, record that so that the team knows it is acceptable
to iterate on them.

It may be helpful to set a standardised format for recording SLIs, SLOs and the
rationale, including the code or pseudocode for measuring them. One example is
as follows:

<div style="height:1px;font-size:1px;">&nbsp;</div>
> ### Service Name
> Prometheus
> ### Service Overview
> Prometheus is the monitoring and alerting system operated by Reliability
> Engineering. It scrapes metrics from applications, allows viewing of
> dashboards in Grafana, and sends alerts via PagerDuty.
> ### SLIs and SLOs
> Category | SLI | SLO |
> ----- | --- | --- |
> **Alerts**<br>Latency | The proportion of pages successfully delivered to PagerDuty, as measured by alertmanager<br>`sum without (instance) (rate(alertmanager_notifications_failed_total{integration="pagerduty"}[5m])) / sum without(instance) (rate(alertmanager_notifications_total{integration="pagerduty"}[5m]))` | 99%
> Availability | The proportion of uptime as measured by the `up` metric for alertmanager - at least one alertmanager is up.<br>`number of scrapes with at least one alertmanager / total number of scrapes` | 99.99% |
> ### Rationale
> This is an initial attempt at setting SLOs, and the values have been picked
> based on best judgement.
<div style="height:1px;font-size:1px;">&nbsp;</div>
