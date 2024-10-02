---
title: How to arrange and manage penetration tests
eleventyNavigation:
  parent: Operating a service
last_reviewed_on: 2024-06-27
review_in: 6 months
permalink: standards/how-to-do-penetration-tests.html
---

You should aim to run [penetration tests](https://www.gov.uk/service-manual/technology/vulnerability-and-penetration-testing) on your service at least every 12 months. You must discuss all significant changes with the GDS [Information Security][] team. You must agree with the [Information Security][] team when you will test and the scope of the tests. They will also assist with the procurement of external tests through an approved third party through the [National Cyber Security Centre (NCSC) CHECK scheme]. Alternatively, with the agreement of the Info Sec team, a member of the [COD Cyber] Team can carry them out internally, depending on the requirements.

Information Security are working on a GDS-level contract for ITHC services, which should make obtaining an ITHC for your service a more streamlined process.

You may need to schedule additional testing if you make significant changes to your service. You should meet with the Info Sec team regularly to discuss ongoing changes.

A significant change could be when you:

A significant change could be when you:
change a cloud service provider
change stored data, for example if you introduce new data which can be classified as personal data under [GDPR]
add a third-party partner, for example, a database processor or email provider (especially if the third-party partner is processing personal data)
implement significant application changes or new features


## Scope your test

An IT Health Check or security review can include:

* application penetration tests
* external network penetration tests
* firewall rulebase/ruleset reviews
* server build reviews
* networking and networking device [Access Control List (ACL)][ACL] reviews
* code reviews
* infrastructure-as-code reviews
* AWS configuration reviews
* red team engagements
* vulnerability scans

Before testing, you should define and agree:

* the beginning and end test dates. This will be an agreement between the team and the tester(s) based on the size of the project, rather than dictated to them
* the areas you want the tester to target, for example, bypassing authentication
* what you should exclude, for example, third-party managed infrastructure
* exploits that are out of scope, such as DoS attacks
* any specific technical capabilities to allow third-party testers to complete testing, for example, experience working with AWS security groups
* the specific technical scope of the test including IP addresses, URLs and GitHub repositories
* what technical documentation and tools are needed to facilitate testing and understanding of the application. For example, design documents, network architecture diagrams and technical configurations e.g.  Swagger/Postman documentation for API tests

 
## Schedule a test

To schedule a test, [Information Security][] team.

If you plan to test any application, you must contact the Info Sec team at least 3 months in advance so they can organise the procurement (or call-off against the existing framework) for you.

If you are planning to ask the [COD Cyber] team to perform a test, you will need to enter the information listed in the [scope your test section](#scope-your-test) and the [prepare for your test section](#prepare-for-your-test) into a Rules of Engagement document, where a scope can be agreed and signed off by both parties. As with an external company, you should give at least 3 months' notice to make sure you can schedule the test at a time that suits project timelines.

## Prepare for your test

Before the test, you will be expected to share documentation with the testers, for example, up-to-date architecture diagrams. The documentation could also include information about the individual components of each device and application being tested.

You should run the tests on a separate test environment which replicates the behaviour of your live service.

To prepare your test environment you should:

* give the tester all the credentials, certificates and authentication they need to start immediately
* provide a technical person to contact in case the tester has any queries and to assist with any technical issues (e.g. provisioning accounts)
* note down the IP addresses of the testers and if necessary, add those IP addresses to any allow lists, making sure to remove them when testing has finished
* create temporary credentials for testers (testers should provide their own SSH public keys)
* give the tester the privileges required for the test, such as sudo access where appropriate
* notify your service providers in advance, for example by [emailing GOV.UK PaaS Support](mailto:gov-uk-paas-support@digital.cabinet-office.gov.uk) - note that in most cases AWS do not require advance permission for penetration tests on your applications
* give the tester a distribution list of approved report recipients

Prior to the test, it may be beneficial to meet the lead tester and the GDS IA Team to discuss the test and confirm that all the prerequisites and necessary access are in place

## During the Test
The lead tester should draw your attention and that of the [Information Security] IA team to any critical vulnerabilities immediately identified

It is advisable to meet at the end of each day with the lead tester and the IA Team to discuss findings and the progress of the test.

## What to do after testing

After your test, you should meet with the GDS IA team to discuss and triage (risk assess) the test results. You can then prioritise work to mitigate any issues identified in the test and schedule a retest if needed.

Teams should work with the [COD Cyber] team, who can give advice, consult on fixing any issues and take appropriate further action when required.


[COD Cyber]: https://sites.google.com/cabinetoffice.gov.uk/cybersecurity/home
[Information Security]: https://sites.google.com/a/digital.cabinet-office.gov.uk/gds/directorates-and-groups/cto-and-ciso-office/information-security
[GDPR]: https://commission.europa.eu/law/law-topic/data-protection/reform/what-personal-data_en
[National Cyber Security Centre (NCSC) CHECK scheme]: https://www.ncsc.gov.uk/information/using-check-provider
[ACL]: /standards/secrets-acl.html

