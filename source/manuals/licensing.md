---
title: Licensing
eleventyNavigation:
  parent: Version control and deployments
last_reviewed_on: 2024-05-29
review_in: 6 months
permalink: manuals/licensing.html
---

Any public repository must include a licence that details the terms under which
the code or documentation is available to be used or modified.

## Language

From [The Guardian and Observer style guide][guardian-style]:

> In British English, licence is the noun and license the verb. So you need a
> licence to run a licensed bar, or you may need to visit the off-licence.

Some examples of this:

* Use the British English spelling of the noun _licence_, not the US English
  spelling of _license_ (for example "you need a licence to drive a car.")
* When talking about the permissions that a licence grants, or the act of using
  a licence, use _license_ (for example "your pet shop needs to be licensed.")
* When using a proper name, use the appropriate spelling for that thing (e.g.
  the [MIT License][mit-license].)

So you would _license_ your software under a particular _licence_, such as the
_MIT License_.

## Guidelines for repositories containing code

### Specifying the licence

Each repository should include a licence file. This should be called `LICENCE`
or `LICENCE.md`.

GitHub's guidance for [including an open source licence in your
repository][gh-licence-guidance] uses the US English spelling of _license_, but
will still show licence details for the British English spelling.

You should specify the licence and link to it in the repository's
[README][readme]. It's typical to include this information at the very end of a
README under a ‘Licence’ heading.

### Use MIT

At GDS we use the [MIT License][mit-license].

Make sure the licence content is included in full, including the title "The MIT
License", so that readers are quickly able to see what licence is being used.

### Copyright notice

The Copyright is Crown Copyright; you can put "Government Digital Service" in
brackets.

For example, `Copyright (c) <%= Time.current.year %> Crown Copyright (Government Digital Service)`.

The year should be the year the code was first published. Where the code is
continually updated with significant changes, you can show the year as a period
from first to most recent update, for example 2015-2019.

For more information on copyright notices, see the [UK Copyright Service fact
sheet][uk-fact-sheet].

### Example

There is a good example of a licence in the [pay-adminusers][pay-licence] repo.

## Guidelines for repositories that are open documentation

Some repositories will produce websites serving documentation. The GDS Way is
an example of this. In addition to the MIT License for the code in the
repository, you should include the [Open Government Licence (OGL)][ogl-licence]
for the documentation.

### Example

The [GDS Way][gds-way] repo is a good example of licensing open documentation.

[mit-license]: https://opensource.org/licenses/MIT
[uk-fact-sheet]: https://copyrightservice.co.uk/copyright/p03_copyright_notices
[pay-licence]: https://github.com/alphagov/pay-adminusers/blob/master/LICENCE
[ogl-licence]: https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/
[gds-way]: https://github.com/alphagov/gds-way
[gh-licence-guidance]: https://docs.github.com/en/communities/setting-up-your-project-for-healthy-contributions/adding-a-license-to-a-repository#including-an-open-source-license-in-your-repository
[readme]: /manuals/readme-guidance.html
[guardian-style]: https://www.theguardian.com/guardian-observer-style-guide-l
