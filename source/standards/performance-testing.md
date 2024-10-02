---
title: Performance Testing
eleventyNavigation:
  parent: Operating a service
last_reviewed_on: 2023-04-23
review_in: 6 months
permalink: standards/performance-testing.html
---

Make sure your service performs the way users need it to. If your service does not perform as expected under extra load it will impact your users.

You should run performance tests to check how your service performs in certain situations. For example, during a [denial-of-service attack (DoS attack)](https://www.ncsc.gov.uk/collection/denial-service-dos-guidance-collection).

The Service Manual has more information about why you need to [test your service’s performance](https://www.gov.uk/service-manual/technology/test-your-services-performance) and how to start capacity planning and running performance tests.

## Plan your tests

Plan and scope your test. Are you testing the entire service or specific user journeys? Which downstream services will the test impact?

### Estimate costs

Estimate any additional infrastructure costs your tests will incur and share them with your service owner or product manager for approval.

### Plan user journeys

Test complete journeys that are representative of how your service is used in production. For example, if a user has to sign in or register, plan tests where some users sign in and others register.

### Plan test scenarios

A scenario is a hypothetical event when your service will be under heavy load. For example, every year the [G-Cloud framework on the Digital Marketplace](https://www.gov.uk/guidance/buying-and-selling-on-the-digital-marketplace#buy-services-through-the-digital-marketplace) opens for applications from suppliers for several weeks. This activity increases load on the [Digital Marketplace](https://www.digitalmarketplace.service.gov.uk/) up to the deadline.

When most of its application infrastructure moved to the [GOV.UK PaaS](https://www.cloud.service.gov.uk/) the Digital Marketplace service needed to retest the service. Its developers and performance analysts queried historical logs and Google Analytics for popular journeys, modelling normal and peak capacity needs for the previous year’s G-Cloud framework application period.

This helped the team calculate figures for the largest number of concurrent user sessions and Requests Per Second (RPS) Digital Marketplace was able to support. This made sure the new platform could still cope with its expected network traffic.

### Inform people

Inform people affected by your test. For example, tell developers or content specialists planning to use the test environment of your test’s date, time and duration. Make sure everyone involved in the test agrees to its conditions.

### Build your test

You do not need to fully hand code your tests because most load testing tools like [Gatling](https://gatling.io/), include scenario recorders. Some test scenarios may still need manual preparation, for example, providing lists of test users or specific search terms.

Gatling is a popular load testing tool used by many teams in GDS and CDIO including [GOV.UK](https://www.gov.uk/), [GOV.UK Pay](https://www.payments.service.gov.uk/), and [GOV.UK Notify](https://www.notifications.service.gov.uk/).

The SPOT Team on Digital Identity have had success using [K6](https://www.k6.io), a performance testing framework built in Go and scripted in Javascript.

When testing APIs or very simple web applications, [`vegeta`](https://github.com/tsenart/vegeta) is a tool used by [GOV.UK Notify](https:///www.notifications.service.gov.uk), and [GOV.UK PaaS](https://www.cloud.service.gov.uk), for automated performance testing. It can also be used interactively with [`angle-grinder`](https://github.com/rcoh/angle-grinder), or [`jaggr`](https://github.com/rs/jaggr) and [`jplot`](https://github.com/rs/jplot).

## Configure your test environment

Test environments must resemble your production environment as far as possible so tests are accurate. Isolate test environments to stop them affecting your production environment.

Consider how to [monitor service performance](/standards/monitoring.html) during the load test. Your service will likely already have dashboards and graphs set up for common metrics such as CPU and memory utilization. Decide if your current metrics are sufficient or if you need to turn on additional logging or configure profiling traces.

Perform practice runs of your tests to make sure they work as expected. You may need to disable [Cross-Site Request Forgery (CSRF)](https://owasp.org/www-community/attacks/csrf) tokens and rate limiting in your test environment.

## Run your tests

Start with a low level of concurrent users and increase them to your anticipated maximum. If there are no problems, increase the amount of traffic until you reach a breaking point in your system.

### Running your tests locally

While designing and scripting your performance tests, you may be tempted to run them locally in order to develop them faster. 
This is fine for development and small-scale testing, however, it is generally not a good idea to do this for larger-scale testing as you won't get accurate results.

Any and all of these things could negatively impact the results of your performance test:

- The speed, quality or capacity of your local network connection (Wi-Fi, VPN, etc.)
- The technical specification of your computer and resources available
- The round trip time (RTT) between your computer and the environment being tested

For these reasons, you should run your tests on a more dedicated platform, such as on an EC2 Instance or ECS Container.

### Running your tests on dedicated infrastructure

Running your performance tests on dedicated infrastructure is usually the better option. If you are a public sector organisation (such as GDS), you will likely already have access to a cloud compute supplier such as AWS, Azure or Google Cloud and can run your tests on a compute instance, or as a container on an orchestration platform like ECS or Kubernetes.

### Running your tests on Software-as-a-Service (SaaS)

There are some providers out there offering performance testing as a paid-for service. Depending on the scale of your testing, this may be a consideration for you. However, you will have additional considerations, including:

- Security implications using an external provider
- Ingress/Egress to/from your testing environment
- Costs associated with paying a third party to run your tests

If you are working for a public sector organisation, you may also be required to undertake a procurement process before you are able to select and use an external supplier to run performance tests on your behalf.

## Document and share your results

When testing your service, record:

- the load when the service broke
- how the service broke and what went wrong
- the changes introduced to improve performance

If your service meets your capacity requirements, document its upper limits and communicate them to the service owner.

## Analyse your results

Testing tools should record the number of concurrent users, RPS, HTTP response codes and timings. These reports help determine your service’s maximum supported capacity. If your service cannot meet your requirements or you find problems, you’ll need to diagnose them.

You can fix common problems like inefficient database queries by introducing lazy loading and adding or altering indexes. If your web server stops or is slow to respond, it may be running out of available workers. This is a common issue when you're sending lots of requests to APIs and the workers become blocked awaiting a response. Adjusting web server configuration can help depending on your specific application and technology.

Problems with your infrastructure can be harder to resolve. For example, if your service is read-heavy you can introduce additional caching to improve performance.

You can scale infrastructure vertically by adding more power, for example upgrading CPUs, memory or storage. You can also scale horizontally by adding additional instances of your service’s components. You can only do this if your service supports this type of scaling.

[The Twelve-Factor App](https://12factor.net/) provides more information on how to scale your infrastructure and build SaaS.

Make sure you rerun your performance tests after any changes to confirm everything works as expected and you have not introduced any new problems to your service.

## Performance testing for auto-scaling environments

Test auto-scaling infrastructures to make sure they scale up and down as expected and are cost-efficient. For example, if infrastructure scales at the correct thresholds, check if servers become stressed and response times slow down before scaling takes effect.

Performance testing helps determine if you’re using the correct machine instance types for your workload. For example, more expensive larger specification machines may be capable of handling more traffic cheaper than adding additional smaller instances to your auto-scaling group. Depending on your service requirements the reverse may be true.

## Performance testing for serverless environments

Testing can help you tune serverless components’ performance. For example, Amazon prices [AWS Lambda](https://aws.amazon.com/lambda/) on the number of function executions, allocated memory and estimated execution time. The [AWS Lambda Power Tuning tool](https://github.com/alexcasalboni/aws-lambda-power-tuning) provides performance data at different Lambda configurations and can help you right-size your functions.

Performance testing will help determine if a function is taking longer to execute because it does not have enough memory allocated, or is over-provisioned with memory and costing more than necessary.

### Measuring and getting results from serverless architecture

Serverless architecture can sometimes mean that a journey is asynchronous and does not result in a round journey that can be measured or recorded by a testing tool or framework.  

**HTTP and API Gateway**  
If your serverless application completes its journey in one or a small series of HTTP requests, you may be able to measure the results of your performance using only the performance framework.

**SQS Queues, Step Functions and EventBridge**  
Some serverless applications do not use HTTP Requests to start or trigger a serverless journey, but rather, rely on SQS Queues, Step Functions or an Amazon EventBridge event to invoke one or more Lambda Functions.

If your serverless architecture uses one of these, you may have a harder time capturing the full journey within a testing framework - therefore, you might use a framework to simulate the traffic for your performance test and collect the results using another tool such as Splunk or CloudWatch.

If you can, you should try and annotate your requests with a testing identifier to make it easier to collate your results.

## Testing strategies

Some testing frameworks support the execution of different kinds of testing strategies, enabling you to perform different types of testing such as:

- Smoke tests (To test a journey from start to finish)
- Soak tests (To test whether your application can handle a sustained load)
- Spike tests (To test whether your application can handle an unexpected surge or "spike" in load)
- Stress tests (To find breaking points or bottlenecks in your application or infrastructure)

Some testing frameworks may also allow you to simulate different patterns and stepping of traffic, such as choosing between a constant or ramping (exponential) arrival rate.

## Further reading

To find our more about performance testing read:

- the Service Manual about [testing your service’s performance](https://www.gov.uk/service-manual/technology/test-your-services-performance)
- [The Twelve-Factor App](https://12factor.net/) a methodology for building software-as-a-service apps
- [Gatling product documentation](https://gatling.io/docs/gatling/reference/current/) about maintainable and high performance load testing
