---
title: Disaster Recovery
eleventyNavigation:
  parent: Operating a service
last_reviewed_on: 2024-07-09
review_in: 6 months
permalink: standards/disaster-recovery.html
---

The [GOV.UK Service Manual](https://www.gov.uk/service-manual) describes how you should [design your service to maximise uptime](https://www.gov.uk/service-manual/technology/uptime-and-availability-keeping-your-service-online).
However, it is inevitable that your service will experience unscheduled downtime at some point, which could have a serious impact on users. You must plan your response for when this happens.

## What is disaster recovery?

In digital services, a disaster is a major, unplanned event that completely prevents you from providing your service to your users.

A disaster may also be an incident. However, whereas an incident will be handled as part of your [incident management process](/standards/incident-management.html), some events may impact your service to such an extent that they need to be planned for in advance to ensure you can continue to provide your service if they occurred.

Examples might be:

- a cloud provider suffering a serious regional outage
- accidental or malicious data loss
- a security compromise resulting in the disclosure of sensitive information

Disaster recovery planning is the process of identifying the kinds of events that might make your service completely unavailable, understanding the likelihood and the impact of them occurring, planning what we would do if they occurred, and testing that our recovery plans work.

### Understand risks and threats to your service

You should work with the [Information Security](https://sites.google.com/a/digital.cabinet-office.gov.uk/gds/directorates-and-groups/cto-and-ciso-office/information-security) and [Cyber Security](https://sites.google.com/cabinetoffice.gov.uk/cybersecurity/home) teams to understand the risks to your service. This will help you build a more resilient and secure digital service.

You should also work with risk and service owners to plan for the worst-case scenarios. This is particularly important for your data, as loss or theft of data is disastrous for most services.

Make sure you consider how [disruption to or unavailability of your dependencies](https://www.gov.uk/service-manual/technology/uptime-and-availability-keeping-your-service-online#issues-that-can-affect-uptime) can affect your service. These dependencies can include obvious systems, such as your hosting provider, but also less obvious systems such as your:

- Domain Name System (DNS) provider
- Content Delivery Network (CDN)
- any Virtual Private Networks (VPNs) your development team might use to access production systems
build pipelines
- external library and container registries (for example, RubyGems, PyPI or Docker Hub)
- secrets management providers

#### Disaster planning workshops

You might find it useful to run a disaster planning workshop to help identify the risks to your service. This should involve important service stakeholders, Information Security and/or Cyber Security colleagues, as well as product and technical members of your delivery team. The more involvement you have from different disciplines the more likely you will be to identify all the risks and understand them.

You should use a whiteboard or an online alternative for the workshop. Start with a technical architecture diagram of your service to help visualise dependencies and important assets, such as data stores. Then, either individually or in small groups, identify as many disaster scenarios as possible, raising sticky notes on the diagram for each one.

Once you have identified the risks to your service, the workshop members should go through each scenario and score each one in terms of the likelihood of them happening and the potential impact on the service if they occurred. A 0-5 scoring system is usually adequate for this. Again, the scoring will be more accurate the more disciplines are involved. An overall score can then be calculated for each scenario by multiplying likelihood and impact.

When all the scenarios have been scored, you will be left with a set of disaster scenarios that can be placed in priority order. You will need to decide what to do about each risk. You may need to draw up a plan for how you would recover if the scenario occurred. Alternatively, you may decide to do some work ahead of time to reduce the likelihood or impact of the event occurring. If the likelihood and impact are very low, you may decide to accept the risk and do nothing.

### Back up your data

You should back up your data. How often you back up will depend on your [Recovery Point Objective (RPO)](https://cloud.google.com/architecture/dr-scenarios-planning-guide#basics_of_dr_planning). An RPO determines what you consider an acceptable loss of data between the last backup and the point of data loss. For example, if you determine that up to 24 hours of data loss is an acceptable risk, you will only need to backup your data once daily. For lower RPOs (minutes or seconds), you should use [continuous backups and point-in-time recovery](https://docs.aws.amazon.com/aws-backup/latest/devguide/point-in-time-recovery.html) services that most modern cloud providers offer.

### Have cold or offline backups

A cold or offline backup is a copy of your backup, isolated from the rest of your production system. Offline backups help protect you from some disaster scenarios. If an attacker gains access to your live database service and your backups, you could experience a ransomware attack, or risk having your entire data estate deleted. You should implement offline backups so that even users with administrative access cannot alter or delete data. 

Offline backups also help protect your data from accidental deletion. For example, copy your backups to a different account with limited access rights. Make sure:

- the backups are encrypted and versioned
- the account you are copying the backups from only has write permissions

### Decide where to store your backups

Where you are storing your backups is also important for disaster recovery. Most cloud storage solutions have durability guarantees. However, an outage could occur in the region containing your live service and backups. If your service has very high availability requirements, you may need copies of your data in a different region, or with a different service provider. Your conversations with Information Security and service owners can help you determine your risk tolerance for these hopefully rare scenarios.

The National Cyber Security Centre (NCSC) article [Offline backups in an online world](https://www.ncsc.gov.uk/blog-post/offline-backups-in-an-online-world) further explains why offline backups are important and suggests some approaches to use in a cloud environment.

### Decide on manual or automatic recovery in the event of a disaster

Setting a [Recovery Time Objective (RTO)](https://cloud.google.com/architecture/dr-scenarios-planning-guide#basics_of_dr_planning) for your service can help you decide your approach to service recovery in the event of a disaster. For example, [Digital Marketplace](https://www.digitalmarketplace.service.gov.uk/) is built to automatically recover in various scenarios, including an outage in an availability zone. It is not built to withstand a serious outage of [GOV.UK Platform as a Service (PaaS)](https://www.cloud.service.gov.uk/) or the [Amazon Web Services (AWS) region](https://aws.amazon.com/about-aws/global-infrastructure/regions_az/) the PaaS depends upon. However, Digital Marketplace can restore its service with another provider and/or in another region manually by redeploying its applications using [infrastructure as code](https://www.gov.uk/service-manual/technology/manage-your-software-configuration#use-infrastructure-as-code) and databases from backups. Therefore, in the event of this hopefully low-risk scenario, it has set its RTO as one week.

In this example, the services Digital Marketplace depends upon can probably restore service in less than one week. Therefore, the RTO is applicable in the worst-case scenario.

An RTO of one week is not likely to be acceptable for services where there would be a serious user impact if they were unavailable. For very low RTOs (for example, under one hour), you will need to architect your service to support automatic disaster recovery. For example, [GovWifi](https://www.wifi.service.gov.uk/) operates in two AWS regions - Dublin and London. In the event of a serious outage in London, essential aspects of the GovWifi service will still operate from the Dublin region.

Your disaster recovery strategy will depend on your specific service requirements. You may need different strategies for different parts of your service. The more immediate and more automatic the strategy, the greater the complexity and the cost of running your service is likely to be. The [Plan for Disaster Recovery article from AWS](https://docs.aws.amazon.com/wellarchitected/latest/reliability-pillar/plan-for-disaster-recovery-dr.html) covers some common recovery patterns.

### Agree your RPOs and RTOs with risk and service owners

Make sure you discuss and agree your RPOs and RTOs with risk and service owners. Not only is their expertise key to decision making, but it's vital they understand what will happen and why in the event of a disaster.

## Test your disaster recovery plans

Disasters rarely happen, meaning that your disaster recovery plans are likely to become ineffective unless you test them regularly.

You must regularly test that you can restore data from your live and offline backups. You must test the procedure for restoring an offline backup so team members are familiar with the procedure for accessing and using the backup. It also serves as useful reassurance that backups are functioning correctly.

You must regularly test your manual or automatic recovery processes so that you are confident they will work in an emergency situation. This also helps team members build familiarity with the relevant procedures.

You should [organise game days](https://technology.blog.gov.uk/2015/02/06/running-a-game-day-for-gov-uk/) to practise [incident management](/standards/incident-management.html) and test disaster recovery procedures. Game days enable you to play out scenarios in a safe environment so you can test and learn from how you respond. These scenarios will help build familiarity and increase confidence that your emergency procedures will work when you most need them to.
You can also practice incidents or recovery from disaster scenarios in a more low-pressure way. The GOV.UK PaaS team regularly spin the [Wheel of Misfortune](https://technology.blog.gov.uk/2021/03/04/wheel-of-misfortune-incident-rehearsal-for-gov-uk-paas/) to help new and existing team members gain experience and confidence working with the platform.

