---
title: Pair Programming
eleventyNavigation:
  parent: Software development
last_reviewed_on: 2024-05-01
review_in: 6 months
permalink: standards/pair-programming.html
---

GDS advocates for agile software development practices because we believe that flexibility and responsiveness-to-change are key to building software that meets the needs of our users.

At the core of agile software development is the understanding that fast feedback loops enhance speed and quality, and one way for developers in the team to get quick feedback on the quality of their software design is the practice of pair programming.

## What is pair programming?

Pair programming is a collaborative method of developing software where two developers work together, as opposed to two developers working in isolation. 
There are many ways a pair might collaborate, such as driver (the person doing the implementation, thinking tactically) and navigator (the person thinking about the bigger picture, thinking strategically).

## Benefits

Studies show that [the reduction in defect rates](https://www.sciencedirect.com/science/article/abs/pii/S0950584909000123) for high-complexity pieces of work when pair programming outweighs the perceived decrease in capacity from having two people work on the same thing.
The continuous discussion and review that pairing introduces, compared to a non-collaborative approach, results in better designs with fewer mistakes.
[Another study](https://collaboration.csc.ncsu.edu/laurie/Papers/XPSardinia.PDF) found that pair programming reduces development and staffing risk, enhances technical skills and improves team communications.

Pair programming is a practical way of building collective code ownership between members of the team.
Distributing the understanding of the service being built means that teams are more resilient to people being ill, on leave, or leaving GDS, and as such are less likely to have delivery hiccups from sudden loss of expertise.

Pairing people of [different levels of expertise](https://www.youtube.com/watch?v=lvs7VEsQzKY&t=317s) is an effective way of mentoring and fostering career development.
For example, pairing someone new to GDS with an experienced developer within the team will benefit both; upskilling the new joiner, and reinforcing the knowledge of the experienced person by teaching them.

## Working effectively as a pair

Pair programming is a development skill in the same way that test-driven development is a skill.
It’s also a social and collaborative way of working and the way a pair works can vary depending on who you are pairing with.
We provide some of the following advice to help pairs work effectively together.

### Rotate pairs regularly
Pairs should rotate regularly at a cadence that makes sense for the team.
This might be after a single piece of work or after a fixed period of time.
Rotating pairs spreads knowledge, increases team resilience, and builds ownership of the codebase.

### Discuss how to pair together
Pairs should agree on the way that they will pair before starting the work itself.
Your pair might favour ping-pong programming (where one person writes a test, the other person makes it pass and then writes the next test) or strong-style pair programming (your ideas need to enter the codebase through the other person’s input).
This also includes agreeing when to take breaks.

### Take breaks
Working together and staying focused for extended periods of time can be tiring.
Pairs should make sure that they take regular breaks and where possible work in small iterative batches rather than large changes.
You might find the Pomodoro technique useful or one of the many pair/mob programming timers available online.
Have a debrief at the end of the day if it would be helpful, and raise any recurring issues at your team’s retrospectives or with your tech lead.

### Pair where appropriate
Pairing is not suitable for every type of work, so use your discretion within the team.
You might choose not to pair on automated refactorings or work that would be described as Clear within the [Cynefin model](https://en.wikipedia.org/wiki/Cynefin_framework).
Remember that developers are people and as such might be unable to pair on any given day for their own personal reasons. Be respectful and understanding if someone is unable to pair.

### Communicate effectively
Pair programming is both a social skill and a technological skill.
It works most effectively in an environment where the pair respect each other's skills and needs, and communicate with openness, empathy, and honesty.
People in teams that have embraced concepts like [psychological safety](https://en.wikipedia.org/wiki/Psychological_safety) and [non-violent communication](https://www.cnvc.org/) are likely to be well-equipped for pair programming.

## Reviewing code as a pair

The standard approach to code review in GDS is that teams should use a pull-request (PR) process to ensure that all code is reviewed by another person.
A pair can approve their own PRs on codebases where changes require an additional review, which is the vast majority of codebases at GDS.

This has several benefits, such as:

- speeding up the flow of work.
- enabling the pair to move on to another task without [context switching](https://blog.ninlabs.com/2013/01/programmer-interrupted/).
- avoiding a third person having to context switch to review the code.

However, teams should adjust their policy on this approach depending on the risk tolerance of the codebase, team, or programme.

## Further reading

- Pairing and code review guidelines for [GOV.UK Pay](https://manual.payments.service.gov.uk/manual/development-processes/pairing-principles.html)
- Code review guidelines in the [GDS Way](https://gds-way.digital.cabinet-office.gov.uk/standards/pull-requests.html#reviewing-a-request)