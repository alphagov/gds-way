---
title: Threat Modelling
eleventyNavigation:
  parent: Software development
last_reviewed_on: 2024-06-27
review_in: 6 months
permalink: standards/threat-modelling.html
---

## What's a threat?

A threat is an action that causes denial, alteration or disclosure of your
assets that you are trying to protect. It could be a user database, a deployment
pipeline or the integrity of web form submissions.

## What's threat modelling?

Threat modelling aims at identifying, prioritising and mitigating threats to a service. 

Threat modelling will help you:

* Understand threats that are unique to your service, helping you to adopt security conscious behaviours during its design, development and operation
* Focus mitigation efforts on the threats that matter – that is, threats that pose the greatest risk to the normal operation of your service
* Ensure the right security controls are in place to match the threats your service faces
* Adopt secure by design approach to your service throughout the service's lifecycle

The best time to perform threat modelling activities is during the design phase;
however, it can be done anytime and should become a continuous process in your
service team.

Within the Cabinet Office, the [Cyber Security Team](https://sites.google.com/cabinetoffice.gov.uk/cybersecurity/our-services/threat-modelling) can support you with threat modelling your service, as well as advising you should you decide to carry it out yourself or through a third party. 

Within the Cabinet Office and GDS, we follow the [Threat Modeling Manifesto][]'s
four questions:

1. What are we working on?
2. What can go wrong?
3. What are we going to do about it?
4. Did we do a good enough job?

We answer most of the above over three sessions, with time between sessions
allowing for asynchronous input.

### 1. Threat Discovery

Threat discovery aims to answer the “What are we working on?” and part of
the “What can go wrong?” question.

We use an interactive exercise to talk through and explain the system or
architecture. Someone who is comfortable with explaining the system from the
service team will need to lead this part. Try to keep the scope small; it may be
more effective to break a service down and perform multiple threat modelling
activities.

The group of people involved typically includes the development team, cyber
security and information assurance colleagues; however, working with other
people, such as user researchers and product managers, often provides more
varied perspectives.

As part of the interactive exercise, we surface hypothetical threats or
vulnerabilities in a service. We use [STRIDE][] to help us look at different
aspects and make sure we get a rounded view of all threats.

#### 1.1 Interactive Exercise

The purpose of this exercise is to talk through the service, architecture or the
user journey with the people in the session, allowing for questions and answers.

Remotely, digital whiteboard software, such as [Jamboard][], [Mural][],
can be used to add virtual post-its on top of the digital diagrams.
Make sure the tools are accessible so all colleagues can participate and ensure
access control is sufficient as the diagrams will likely be at least
OFFICIAL-SENSITIVE when complete.

Another useful tool you could use is [diagrams.net][] with its [threat
modelling library][diagrams.net threat modelling].

In person, which may be more appropriate for some teams and systems, diagrams
are typically drawn up on a whiteboard, followed by questions and post-its of
potential threats stuck at relevant points.

### 2. Threat Analysis

Threat analysis aims to finalise the answer to the “What can go wrong?”
question. We use a scoring methodology to determine if a threat is valid and
prioritise threats against each other.

#### 2.1 Scoring

After the discovery stage, you can make a copy of the
[Threat Modelling Scoring template][] to use for noting down threats, the most
likely actor, scoring, and tracking mitigation.

Scoring is useful as it helps prioritise what's valid and what you should look into
first.

The difficulty is a rating between 0 (very easy) to 5 (hard); it should take
into account how hard it would be to gain access and any costs associated with
performing the attack.

The reward is a rating between 0 (low) to 5 (high); it’s how valuable the
outcome is to the threat actor.

The final score equals reward minus difficulty, so a high score is worse than a
low one.

### 3. Threat Response

Threat response aims to answer the “What are we going to do about it?”
question.

It may be helpful to add the outputs to your bug or ticket tracking system.

There are three typical responses to threats:

#### 3.1 Mitigate
Implementing a preventive control, such as an architectural change, eliminates
the vulnerability or blocks the threat.

#### 3.2 Monitor
Monitoring is a reactive control to detect if a threat occurs; it controls a
situation and limits damage or loss by detecting an attack early.

#### 3.3 Acknowledge the risk
Acknowledging the risk but not planning any immediate action can help with
resourcing any future mitigation or deciding to accept a risk because the cost
of the mitigation outweighs the maximum cost of a threat.

### 4. Did we do a good enough job?

After completing the threat modelling activity sessions, you should set aside
some time to review the threat modelling outputs regularly. This is to see
whether you are improving the security and taking the mitigations forward; it’s
also important to consider any new threats.

A recommendation is to perform this review within your service team every two
months; the time you need may vary depending on the scope of your threat
modelling, but 90 minutes is usually sufficient.

You should consider running the threat modelling sessions every year or when
there are significant architectural changes planned.

## Why's it necessary?

Adam Shostack has produced an informative short video on this:
[Why Threat Model?][]

Adam explains that we threat model to anticipate problems when it's inexpensive
to deal with them.

How do you know what a problem is? Information and computer security is
often broken up into three main pillars, known as the CIA triad:

### Confidentiality
- Information accessible to authorised people

### Integrity
- Information that's correct

### Availability
- Information available when needed

Abuse or neglect of one or more of these pillars could lead to a security
incident.

The opposite of the CIA triad is sometimes known as the DAD triad:

- If confidentiality is affected, disclosure occurs.
- If integrity is affected, alteration occurs.
- If availability is affected, denial occurs.

Here is a fun, alternative look at the
[CIA and DAD triads, explained with Lord of the Rings references][].

## STRIDE

STRIDE is a model of threats developed by Microsoft.

It's a helpful tool for thinking about different potential attacks or
vulnerabilities. If you're finding it hard coming up with potential
attacks, you can use STRIDE to help stimulate ideas.

Note that STRIDE is *not* useful as a taxonomy.  Some attacks don't
neatly fit into "spoofing" versus "tampering" versus "elevation of
privilege".  That doesn't matter: the important thing is to come up
with threats and write them down, not to ensure they are "correctly"
categorised.


|Threat|Security Control|
|-|-|
|Spoofing|Authenticity|
|Tampering|Integrity|
|Repudiation|Non-repudiability|
|Information Disclosure|Confidentiality|
|Denial of Service|Availability|
|Elevation of Privilege|Authorisation|

### Spoofing
Spoofing occurs where malicious actors use another person's user credentials without
their knowledge.

It also includes attacks where systems mimic or disguise themselves as other systems, such
as IP address spoofing in DNS amplification attacks.

The desired property is authenticity, meaning an event or action is trustworthy
and genuine.

### Tampering
Only authorised users should be able to modify a system or the data it uses.

The desired property is integrity, meaning an event or action is valid and
correct.

### Repudiation
Repudiation means an action or event cannot be associated with what triggered it,
whether that is a person or another system component.

The desired property is non-repudiation, which means an action or event is
difficult to deny by a person or system.

### Information Disclosure
Data such as passwords or personal information is made available to those who
should not have access to it.

The desired property is confidentiality, where data is only available to those
who are authorised to view or alter it.

### Denial of Service (DoS)
Data is unavailable for its intended audience.

The desired property is availability, where data is always available when those
authorised to view or alter it expect it to be.

Distributed Denial of Service (DDoS) is a form of DoS where multiple entities
are responsible for inappropriate traffic leading to overwhelmed services.

### Elevation of Privilege
Data is available to unintended or unauthenticated users.

The desired property is authorisation, where data is only available to those
expected to view or alter it.

## Examples

Looking at the GOV.UK Pay service as an example; Pay is likely to attract attention from organised criminal groups and lower-level hackers/script kiddies who have financial motivations. Organised criminal groups are capable of a level of attack sophistication that would mean zero-day exploits, and more advanced techniques like replay attacks, and would be willing to use supply chain attacks as a route for access. State actors are likely to be less interested in Pay, except for disruptive actions to render the service unavailable.

Applying this threat model, Pay requires a good level of cyber security (in addition to it's PCI-DSS requirements) and regular scanning/penetration testing is necessary to ensure that both basic cyber hygience and more advanced attacks are accounted for.

This would contrast with a service like GOV.UK, where the threat is likely to be state sponsored or affiliated threats and lower-level hackers/script kiddies using common toolsets/bots with political/reputational motivations.

## Additional tools and links

- [OWASP Application Threat Modelling][]
- [Mario Areias - Threat Modelling the Death Star][] YouTube video example


[Why Threat Model?]: https://www.youtube.com/watch?v=YP4mNRXGcks
[Threat Modeling Manifesto]: https://www.threatmodelingmanifesto.org/
[Threat Modelling Scoring template]: https://docs.google.com/spreadsheets/d/1u22W_bUEPESvbMde-Q4syJLTen1OKIcE4ILk7wyaydM/edit#gid=0
[STRIDE]: #stride
[Threat modelling Google Slides introduction]: https://docs.google.com/presentation/d/1wwnPaVq9zryJFhHP9DIKEMrMh6Ts37d7_ApHnt5EFpE
[Jamboard]: https://jamboard.google.com/
[Mural]: https://www.mural.co/
[diagrams.net]: https://www.diagrams.net/
[diagrams.net threat modelling]: https://michenriksen.com/blog/drawio-for-threat-modeling/
[CIA and DAD triads, explained with Lord of the Rings references]: https://squirreltb.wordpress.com/2015/11/17/the-cia-and-dad-triad/
[OWASP Application Threat Modelling]: https://owasp.org/www-community/Threat_Modeling
[Mario Areias - Threat Modelling the Death Star]: https://www.youtube.com/watch?v=ivmfZ6vGkEs&feature=youtu.be
