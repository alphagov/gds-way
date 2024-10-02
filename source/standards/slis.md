---
title: Run a Service Level Indicator (SLI) workshop
eleventyNavigation:
  parent: Logging, monitoring and alerting
last_reviewed_on: 2023-06-08
review_in: 6 months
permalink: standards/slis.html
---

Setting SLIs helps you set realistic objectives for your service and avoid over-committing resources on [Site Reliability Engineering (SRE)](https://sre.google/). SLIs benefit your service by:

- defining [Service Level Objectives (SLO)](https://sre.google/sre-book/service-level-objectives/) for your service’s user journeys
- helping prioritise your work and improve your infrastructure
- creating metrics to help [classify incidents (P1-P4)](/standards/incident-management.html)
- measuring how your system performs in the medium to long term

The SLIs you define must be specific to your service users’ experience. Your SLIs should prompt your SLOs and inform your Service Level Agreement (SLA).

Read the [Google Site Reliability Engineering (SRE) manual](https://sre.google/sre-book/table-of-contents/) for more information about service level terminology.

## Run your workshop

Run your workshop with your team including your service’s:

- product manager
- delivery manager
- technical representative(s)

Your first workshop should not last longer than one and half hours and should focus on creating some initial results. Iterate these first SLIs over time and adjust your team’s practices as needed.

Run the workshop as a whiteboard exercise to capture and focus your team’s view on your service. Doing this will generate a discussion about what’s important to your users.

When you run the workshop:

1. [Prioritise your most important user journeys](#1-prioritise-your-most-important-user-journeys).
1. [Map your user journeys](#2-map-your-user-journeys).
1. [Define what good means to users](#3-define-what-good-means-to-users).
1. [Map out high-level system components](#4-map-out-high-level-system-components).
1. [Define your SLIs](#5-define-your-slis).
1. [Create implementation tasks](#6-create-implementation-tasks).
1. [Observe and iterate your SLIs](#7-observe-and-iterate-your-slis).

### 1. Prioritise your most important user journeys

People use your service to complete user journeys to achieve specific outcomes. Define your most important user journeys.

For example, in [Digital MarketPlace](https://www.digitalmarketplace.service.gov.uk/) the most important user journey is where suppliers submit their bids. Your team will surface many user outcomes so prioritise 2 to 3 items to start with.

### 2. Map your user journeys

Your product manager should lead your team in mapping your service’s user journeys, starting with the most important.

### 3. Define what good means to users

Define what “good” looks like for your service from your users perspective.

For example, if you’re hosting a web service, “good” means your web service is “available” and “fast”. If your service provides a type of publishing platform, “good” can mean how fast your service publishes data to live (data freshness).

### 4. Map out high-level system components

A technical person in your team, like a developer or site reliability engineer (SRE), should draw a high-level system diagram for your service.

The diagram should show the major system components for each user journey. This could include only 2 or 3 components, or multiple system-to-system interactions including 3rd party software providers.

### 5. Define your SLIs

Define potential SLIs and identify points in your service where you can measure them. These SLIs must reflect your user’s definition of good.

Technical members of your team should contribute to where, how and what metrics they collect. These metrics will form your SLIs. Mark out your SLIs over a period of time, for example, a moving hourly window where your SLIs show system performance for the previous hour.

### 6. Create implementation tasks

Your team’s product or technical lead(s) seperate down your SLIs into tasks, for example using Trello, [Pivotal Tracker](https://www.pivotaltracker.com/) or [Jira Software](https://www.atlassian.com/software/jira). Some teams create an [Agile epic](https://www.atlassian.com/agile/project-management/epics) to cover every task needed to carry out their SLIs and SLOs.

### 7. Observe and iterate your SLIs

After creating your SLIs, observe them over a period of time (for example 1 week). After this time, iterate your SLIs to better understand your service’s performance and how the SLIs help your team make decisions.

## Case study: Reliability Engineering Observe team

The Observe team organised a workshop in the form of a whiteboard exercise with their product manager, tech lead and technical architect to identify their first set of SLIs.

### Prioritising user journeys

The Observe team identified user journeys for their products. Observe users want to:

- know how their service is doing - by viewing a dashboard
- know if their service degrades
- update an alert
- be paged (alerted) when an issue affects users
- add new metrics
- debug live issues
- receive a ticket when there’s a hazard

The team prioritised the 3 most important user journeys:

- know how their service is doing - by viewing a dashboard
- be paged (alerted) when an issue affects users
- debug live issues

The team developed SLIs for the most important user journey: “Knowing how their service performs (by viewing a dashboard)”.

### Mapping user journeys

The team mapped the user journey for “choose a Grafana dashboard”. Users look at a [Grafana dashboard](https://grafana.com/dashboards) to get a general understanding of system performance and then focus on individual graphs using the time axis to debug live issues.


User journey for choosing a Grafana dashboard:

1. The user chooses a dashboard from a list of dashboards.
2. The user chooses a graph on the dashboard.
3. The user drills down (accesses data at a lower level in the hierarchy of the data structure) to see more details about the graph. 


### Defining what good means

From a user’s perspective “good” in “choose a Grafana dashboard” means the:

- Grafana (web service) is available
- data shown on the graph are near-real-time (live) and accurate
- Grafana response is fast enough

### Mapping out high-level system components

The team mapped out the system components to complete the user journey “choose a Grafana dashboard”:

1. A user views a Grafana dashboard on their computer.
1. The computer fetches data from a Grafana server running on [GOV.UK PaaS](https://www.cloud.service.gov.uk/).
1. The Grafana server fetches data from a [Prometheus database](https://prometheus.io).

#### Choosing a Grafana dashboard: high-level system components


The team defined the SLI over the last hour the service collected metrics, identifying:

- the importance of successful requests
- latency for the users

### Defining the SLIs

The first sets of SLIs are a percentage of:

- successful ([status code is not 5xx](https://en.wikipedia.org/wiki/List_of_HTTP_status_codes#5xx_server_errors)) requests
- requests that the service responds to within 2.5s

You could also represent this relationship using a formula:

The availability per hour of the SLI is the number of total requests minus the number of 5xx requests divided by the number of total requests multiplied by 100%.

The latency per hour of the SLI is the number of requests within 2.5 seconds divided by the number of total requests multiplied by 100%.


#### Choosing a Grafana dashboard: points of measurement

The team looked at the components to figure out the best place to collect data for their SLIs. They looked for the point closest to the end user, so that the metrics would be representative of their experience. For example, if the dashboard was loading slowly for users, the SLI would reflect this accurately. In this case, the team collected data using a component called the PaaS Prometheus Exporter, which was closest to the end user.


### Creating tasks and iterating SLIs

The team created 2 related stories to gather metrics, displaying the SLIs on Grafana dashboards.

The team has since refined the percentage of successful requests responded within 2.5s to better reflect service status.

## Further reading

Find out more about SLIs and how to identify and create metrics by reading:

- The [Google Site Reliability Engineering (SRE)](https://sre.google/sre-book/service-level-objectives/) manual
- [SRE fundamentals: SLIs, SLAs and SLOs](https://cloud.google.com/blog/products/devops-sre/sre-fundamentals-slis-slas-and-slos) - Google Cloud Platform blog
- [The Sysadmin Approach to Service Management](https://sre.google/sre-book/production-environment/) - Site Reliability Engineering by Google
