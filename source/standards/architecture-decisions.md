---
title: Documenting architecture decisions
eleventyNavigation:
  parent: Software development
last_reviewed_on: 2024-05-10
review_in: 6 months
permalink: standards/architecture-decisions.html
---

You should record decisions that affect the architecture of your service, in
order to preserve the context of your choices.

As agile projects age, it is sometimes hard to keep track of the reasoning
behind the decisions made. This is especially true as new people join
the projects when those involved in the early stages are no longer around.

It is important to preserve the reasoning so the current team can
include it as context when making their own decisions about changes they need to
make. For example, understanding whether a particular choice was made for the
sake of expediency and can therefore be changed with little impact, or whether
there were external reasons behind that decision that need to be factored in.

## How to document decisions

Architecture decisions should be stored in version control so there is a
record of what was changed, who by, and when. Decisions that affect a specific
application should be in that application's code repository. You may also want
to store larger-scale decisions in a central documentation repository.

A suggested format is the Architecture Decision Record (ADR), proposed by Michael
Nygard in [a blog post](https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions)
and since adopted widely. That post describes the format in full, but as a
summary it consists of the following sections:

* **Title**: a description of the decision (not the problem)
* **Status**: see [lifecycle](#lifecycle-of-an-adr)
* **Context**: the facts behind the need to make the decision
* **Decision**: what the team has decided to do
* **Consequences**: both positive and negative consequences of the decision

Amazon Web Services (AWS) also provide
[useful advice](https://docs.aws.amazon.com/prescriptive-guidance/latest/architectural-decision-records/welcome.html)
about how and why the ADR process should be adopted.

## Lifecycle of an ADR

In a new project or one with a lot of decisions to be made, consider setting up
regular ADR discussion and review meetings. This will give the team time to work
through these decisions.

Each decision goes through the following phases.

### "Proposed" status

Assuming you're using GitHub for version control, there is no need to record a 'status' for
an ADR when it is first proposed.
The status of your ADR's pull request (PR) reflects the status of the decision until it has been
accepted.

Consider using GitHub's "draft PR" feature especially if you have lots of decisions at varying
levels of readiness.

It's important to find the right group of reviewers for your ADR.
Ensure that you have input from all relevant technical disciplines (such as site reliability
engineers, developers, security architects, etc) and from any teams that might be affected.

Some programmes use technical writers to ensure their ADRs meet our quality standards
and are as accessible to the widest audience possible.
Future team members that lack the full context you have for a decision will appreciate your
efforts!

### "Accepted" status

Once an ADR has been accepted then teams may need to know about its existence long into the
future.
Think about how to make your ADRs discoverable, especially if they require more than just a
one-off set of code or infrastructure changes.

Again, the "accepted" status doesn't need to be explicit in your document - it can be assumed that an
ADR in the `main` branch of your GitHub repository is accepted.
Otherwise, teams can get confused about the real status of a decision, as the ADR goes through
the pull request process!

### Implementation

In some cases there will be an implementation phase during which you may discover that the
decision was wrong, or needs to be amended.

If there are clarifications, then updating your existing ADR may be appropriate.

You might find additional consequences to your decision, so consider updating the Consequences section
to reflect your evolving understanding of the problem space.

If a decision was never implemented at all, then as long as your reviewers and other stakeholders
agree then it may be appropriate to update your existing ADR with a new decision.

However, if some implementation of the original decision has occurred, you should write a new ADR
to explain the new decision.

Any ADRs that have not been fully implemented across all the relevant teams should be a topic for
your regular discussion and review meeting.

Consider using your issue tracker to make sure that decisions you've made are followed through
and put into effect.
The work isn't done until the decision is implemented!

### "Superseded" status

If a decision has been superseded by another decision, the old ADR must be clearly marked as "superseded".

A "Status: superseded" line should appear directly under the heading. Add a link to the new ADR as soon as
it's been accepted.

## What an ADR is not

An ADR isn't a complete description of a software system or architecture.

Some teams use requests for comment (RFCs), wikis, team manuals, or other collaboration tools to document
their architecture, and these should be updated whenever a new ADR is accepted.
