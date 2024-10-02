---
title: Writing release notes
eleventyNavigation:
  parent: Version control and deployments
last_reviewed_on: 2024-05-03
review_in: 6 months
permalink: manuals/release-notes.html
---

When you make changes to code that will affect third parties, you should also publish a release note that clearly explains what’s changed about your service’s functionality, semantics or syntax.

You do not need to publish a release note if your service is used only internally, or used by people rather than through an API, but even in those cases it can be a good way to track changes without reading the commits.

You can publish a release note as either a:

- [GitHub release note](https://docs.github.com/en/github/administering-a-repository/releasing-projects-on-github/managing-releases-in-a-repository)
- markdown file in the root directory of your release

Structure your release note so it has headings for:

- breaking changes - where users must change their code to avoid it breaking after they update
- new features
- deprecated features - where users should change their code ahead of a breaking change in a future release
- bug fixes

Write release notes in the [GOV.UK style](https://www.gov.uk/guidance/content-design/writing-for-gov-uk#writing-to-govuk-style). See [GOV.UK Frontend’s v3.0.0 release note](https://github.com/alphagov/govuk-frontend/releases/tag/v3.0.0) as an example. Be clear and concise, use the active voice and address your users directly. You may want to get help from a technical writer.

Use an active verb-based heading for each change, and to group related changes. For example ‘Update file paths’.

For each change, start by telling your users directly how the change affects them. Start sentences with:

- “You can now...”
- “You can no longer...”
- “You no longer need to...”
- “The API now...” or “The API no longer... ” - if you need to talk about an element directly, for example when you’re describing a bug fix

For breaking changes, start sentences with:

- “You should...”
- “You can change...” - if it’s one of several options
- “Change...” - if it’s the only option
- “You must change...” - if something will go wrong otherwise

You should avoid:

- writing from your team’s perspective - avoid “We’ve fixed...”, “We’ve added” or “Fixed a bug where...”
- links to ‘further guidance’ - your release note should contain all the guidance that’s essential to updating
- in-depth reasons for changes - add a link to a pull request, a blog post or your documentation instead
- the passive voice
- images

You should also [write a README for GDS repositories](/manuals/readme-guidance.html).

## Using code examples

You should only include ‘after’ code, not ‘before’ code. This means it’s easier for users to know which code to copy and paste, and to check if they’ve made the changes correctly.

Lead into a code example with either:

- a colon - if it’s the exact code a user should use:

    In your `assets` path, add `afolder/`:

    ```
    /node_modules/afolder/assets
    ```

- ‘For example’ - if the user’s code may be different to the example:

    Add an `assets-` prefix to data-module attribute values. For example:

    ```
    <div data-module="assets-section">
    ```

## Guidance outside GDS

You can find more information from:

- [learning to love release notes](https://www.writethedocs.org/videos/prague/2018/learning-to-love-release-notes-anne-edwards/) - a talk at the 2018 Write the Docs conference
- the [how to write release notes](https://ffeathers.wordpress.com/2017/08/19/how-to-write-release-notes/) blog - a post by a technical writer at Google
