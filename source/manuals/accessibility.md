---
title: Building accessible services
eleventyNavigation:
  parent: Software development
last_reviewed_on: 2024-05-09
review_in: 6 months
owner_slack: "#accessibility-community"
permalink: manuals/accessibility.html
---

Government services must be accessible to everyone. This includes anyone with a visual, hearing, speech, motor, learning or cognitive impairment. This also includes anyone with a temporary or situational disability, such as a person with a broken arm or working in a loud environment.

Building a service with accessibility in mind not only allows those with access needs to use your service, it also improves the service for everyone else. An accessibility problem with a website can be something that affects everyone, not just people who can only access the web with a keyboard or screen reader.

Government services are legally required to be accessible. This means services must comply with the international WCAG 2.2 AA accessibility standard. This requirement applies to all new and existing public sector websites and mobile applications.

Further reading:

- [legal accessibility requirements for government services](https://www.gov.uk/guidance/accessibility-requirements-for-public-sector-websites-and-apps)
- [the equality act](https://www.gov.uk/guidance/equality-act-2010-guidance)
- [understanding WCAG 2.2](https://www.gov.uk/service-manual/helping-people-to-use-your-service/understanding-wcag)

## How to make your service accessible

When looking to make a service accessible, the [GOV.UK Service Manual’s general guidance on testing for accessibility](https://www.gov.uk/service-manual/helping-people-to-use-your-service/testing-for-accessibility) is a great introductory resource.

### Consider accessibility from the start

You cannot achieve accessibility by adding some final touches - it must be considered at all stages of a project. You should review designs for possible issues, write and run tests throughout development, and test services with accessibility in mind.

### Understand that not everyone reads content the same way

A sighted user might navigate a page from top to bottom, perhaps skim reading through headings and paragraphs to find the content they want.

Non sighted users can also skim read a page. Screen readers can announce content by element type, such as headings, paragraphs or links. For example, if a screen reader user expects a page to contain data in a table element, such as a train timetable, they might start by reading through all the tables on a page.

This is why [semantic markup](https://html.com/semantic-markup/) and good heading structure are important when building accessible services.

### Automated testing

Automated accessibility testing tools are useful for finding issues, but [automated testing can only find around 30% of likely accessibility problems](https://alphagov.github.io/accessibility-tool-audit/). Automated testing shouldn’t be the only accessibility testing carried out on a service, it should also be tested with real users.

Popular tools for automated accessibility testing include:

- [Axe](https://www.deque.com/axe/)
- [Lighthouse](https://developers.google.com/web/tools/lighthouse/) (which uses Axe for its accessibility tests, and can be run from Chrome Devtools without the need for additional installation)
- [WAVE](https://wave.webaim.org/)
- [ARC Toolkit](https://www.tpgi.com/arc-platform/arc-toolkit/)

You may find it useful to include automated accessibility testing as part of your [continuous delivery](/standards/continuous-delivery.html) workflow.

### Testing with assistive technologies

Test your service with assistive technologies throughout development, especially when you introduce a significant feature or make any major change. You should test in [the assistive technology and browser combinations listed in the Service Manual](https://www.gov.uk/service-manual/technology/testing-with-assistive-technologies).

WebAIM have some useful articles that explain how to test with some screen readers:

- [Testing with screen readers](https://webaim.org/articles/screenreader_testing/)
- [Using JAWS (Windows)](https://webaim.org/articles/jaws/)
- [Using NVDA (Windows)](https://webaim.org/articles/nvda/)
- [Using VoiceOver (macOS)](https://webaim.org/articles/voiceover/)
- [Using VoiceOver (iOS)](https://webaim.org/articles/voiceover/mobile)
- [Using TalkBack (Android)](https://webaim.org/articles/talkback/)

You can run VoiceOver training on macOS by going to System Preferences > Accessibility > VoiceOver > Open VoiceOver Training…

#### Manual accessibility testing guide

The Government Digital Service’s accessibility monitoring team has a publicly-available [accessibility testing guide](https://github.com/alphagov/wcag-primer/wiki). The guide is currently labelled as a ‘work in progress’, and was published in 2022.

The guide outlines some approaches for testing websites and applications against the [Web Content Accessibility Guidelines (WCAG)](https://www.w3.org/TR/WCAG/).

#### Using Assistiv Labs to test with assistive technologies

You can use [Assistiv Labs](https://assistivlabs.com/) to test your service with JAWS and NVDA.

Contact the [Engineering Enablement team](https://sites.google.com/a/digital.cabinet-office.gov.uk/gds/directorates-and-groups/cto-and-ciso-office/engineering-enablement#h.f8vfqmbkqtgf) to request an account.

We have been assured by Assistiv Labs that the Virtual Machine (VM) is deleted when you exit, however in the interests of security and to make sure we do not leak any personal data or sensitive material:

- treat the VM you are using as if it was a shared device – like using a public computer in an internet cafe or library
- do not use it to test any confidential or secret service, or services containing content that is considered sensitive
- do not use any credentials from live systems with access to "real data" during your testing
- do not sign in to any accounts, unless those accounts are used solely for the purposes of testing (for example, a test account in an integration or staging environment)
- make configuration changes to the system through your own device rather than the VM

You should also make sure you understand how using Assistiv Labs affects any other requirements for your service, such as PCI (Payment Card Industry) compliance, and assess any additional risks. You can speak to your service’s information assurance lead or the GDS Privacy Team for specific guidance.

#### Testing in an accessibility lab

You can test your service using an [accessibility lab](https://gds.blog.gov.uk/2018/06/20/creating-the-uk-governments-accessibility-empathy-lab/), such as the one in the GDS London office. The lab contains devices with assistive technologies installed for testing, including Dragon, which is not available through Assistiv Labs. It also provides some simulations of using the web with accessibility issues, so developers can better understand what this is like.

### Test content served by third party systems

If a service is built using an existing or third party system, such as a content management system or JavaScript framework, it should be tested for accessibility. Accessibility compliance cannot be guaranteed by any system, as even small changes can introduce accessibility barriers.

### Testing with real users

Services should be tested by real users to evaluate how accessible they are. This can be with members of the public as well as specialist organisations who provide accessibility testing services.

Testing with real users can be a time consuming process. It is recommended that this is done only after other accessibility testing takes place.

### Use the GOV.UK Design System

The [GOV.UK Design System](https://design-system.service.gov.uk/) is a collection of website styles, components and patterns designed to be used to build government services. It provides pre-built website markup that has been developed specifically to be accessible. Using it will also save development time and provide a look and feel consistent with other government services.

While it may not have a full set of components for every service, it provides a solid foundation to work from that can be expanded to suit a service’s individual needs.

You can also use the [GOV.UK Prototype Kit](https://prototype-kit.service.gov.uk) to create working prototypes, share ideas with people and conduct user research.

## Specific guidance

There is a common misconception that accessibility is difficult, time consuming and costly. This is not true, however the range of possible issues that could occur is too wide to detail here. Having said that, here are some common accessibility issues many websites have, why they’re a problem and how to avoid them.

### Non semantic HTML

Semantic HTML means using the appropriate element for the element being described. A common example of this is not using a button element for a button, but relying on JavaScript to provide the correct action when the element is used.

This is a problem because non-semantic HTML is difficult for technologies such as screen readers to understand. This means that some users will not be able to operate or interact with these elements, potentially rendering a service unusable.

### Poor in-page navigation

As websites become increasingly large it is common to have navigation sections at the top of the page containing lots of links to other parts of the site. It is important to provide a mechanism for skipping past these elements to the main content for keyboard users, such as a skip link.

You should build pages using landmarks in order to allow users to navigate more easily between them. For example, an email application might have one landmark for the email folder pane (inbox, drafts and so on) and another for the email list pane.

### Improper heading structure

Screen reader users can rely heavily on correct heading structure within a page in order to navigate and understand its content. The page title should be presented within an H1 element, and all other headings should follow a logical ordering, for example `H1`, `H2`, `H3`, not `H1`, `H3`, `H2`.

### Form controls not associated with a label

All form controls should have a label associated with them that describes what the form control should be used for. [Placeholder text](https://html.spec.whatwg.org/multipage/input.html#the-placeholder-attribute) is not an acceptable alternative.

Labels should provide a short but clear explanation of a form control. Further detail can be provided using a separate element. This should also be associated with the form control by using an attribute such as aria-describedby.

### Meaningless or duplicated link text

The text of a link should describe what that link points to. It should not rely on the surrounding text for context. Users of assistive technology can navigate pages by element type, which means that link text such as ‘click here’ or ‘read more’ does not help a user understand where the link goes.

### Poor colour contrast

Users can have a range of sight issues, including colour blindness or situational disabilities such as screen glare. Text on a web page should always be clear and readable and background images behind text should generally be avoided.

WCAG 2.2 level AA requires a contrast ratio of at least 4.5:1 for normal text and 3:1 for large text. Contrast checking tools such as [WebAIM’s contrast checker](https://webaim.org/resources/contrastchecker/) can provide a quick way to test if text is readable.

### Poor keyboard navigation

Keyboard users rely on focus states to know where they are on a page. This means that elements such as links and form controls must have a clear focus state set in CSS to indicate when those elements have keyboard focus.

This issue relates back to the use of semantic HTML. The use of inappropriate elements can remove the ability for keyboard users to access controls on a page, making the service unusable.

### Inflexibility

Services should have a responsive layout in order to work on any screen size. In addition, consideration and testing should be included for users who apply customisations to their web browsing, either through web browser controls or specific tools. Examples of these customisations include increasing the font size or applying a custom stylesheet, such as a high contrast theme.

### Complex interactive pages

Pages that provide detailed interaction for the user must be built with accessibility in mind. If page elements are updated dynamically using JavaScript you should use attributes such as aria-controls and aria-live so screen reader users are informed when page content changes.

### Image alt text and captions

Images should be described using words for people that cannot see them, either using the `alt` attribute or in the accompanying body text.

Captions using the `figcaption` element are sometimes not read aloud by screenreaders when the image has a blank `alt` text. Do not use the caption to describe your image - the description should be put in the body text.

The GOV.UK Design System provides [guidance on using alt text](https://design-system.service.gov.uk/styles/images/#alt-text).