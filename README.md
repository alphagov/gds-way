# Technical Documentation

## Contributing

### Making documentation changes

To make changes edit the source files in the `source` folder.

Although a single page of HTML is generated the markdown is spread across
multiple files to make it easier to manage. They can be found in
`source/documentation`.

A new markdown file is not automatically included in the generated output. If we
add a new markdown file at the location `source/documentation/agile/scrum.md`,
the following snippet in `source/index.html.md.erb`, includes it in the
generated output.

```
<%= partial 'documentation/agile/scrum' %>
```

Including files manually like this lets us specify the position they appear in
the page.

### Raising and merging PRs to this repo

To submit changes to this repo, raise a PR in the usual way and these will be regularly reviewed by The GDS Way forum group that meets once a month.  Reviewing and merging PRs at any time is fine, the forum will also review merged PRs as part of its regular meeting.

Any open non-draft PRs that have been more than 1 month without further comments, suggestions or alterations will be merged by the forum group unless there is an explicit "DO NOT MERGE" somewhere in the title or description.

There is a GDS Slack channel `#gds-way` where these are discussed.

### Making functional changes

The GDS Way is built from the [Tech Docs Template](https://github.com/alphagov/tech-docs-template)
repository. Any functional changes and bug fixes should be made to that project first, then follow the
instructions [here](https://github.com/alphagov/tech-docs-template#updating-a-project-to-use-the-latest-template)
to update the GDS Way.

## Running Locally

### Getting started

To preview or build the website, we need to use the terminal.

Install Ruby with Rubygems, preferably with a [Ruby version manager][rvm],
and the [Bundler gem][bundler].

In the application folder type the following to install the required gems:

```
bundle install
```

### Preview

Whilst writing documentation we can run a middleman server to preview how the
published version will look in the browser. After saving a change the preview in
the browser will automatically refresh.

The preview is only available on our own computer. Others will not be able to
access it if they are given the link.

Type the following to start the server:

```
bundle exec middleman server
```

If all goes well something like the following output will be displayed:

```
== The Middleman is loading
== LiveReload accepting connections from ws://192.168.0.8:35729
== View your site at "http://Laptop.local:4567", "http://192.168.0.8:4567"
== Inspect your site configuration at "http://Laptop.local:4567/__middleman", "http://192.168.0.8:4567/__middleman"
```

You should now be able to view a live preview at http://localhost:4567.

### Build

If you want to publish the website without using a build script you may need to
build the static HTML files.

Type the following to build the HTML:

```
bundle exec middleman build
```

This will create a `build` subfolder in the application folder which contains
the HTML and asset files ready to be published.

## Deploy

This repo is continuously deployed from the `main` branch by GitHub Actions, using the workflow defined in [`/.github/workflows/bundle_and_release.yml`](/.github/workflows/bundle_and_release.yml).

## Licence

Unless stated otherwise, the codebase is released under [the MIT License][mit].
This covers both the codebase and any sample code in the documentation.

The documentation is [© Crown copyright][copyright] and available under the terms
of the [Open Government 3.0][ogl] licence.

[rvm]: https://www.ruby-lang.org/en/documentation/installation/#managers
[bundler]: http://bundler.io/
[mit]: LICENCE
[copyright]: http://www.nationalarchives.gov.uk/information-management/re-using-public-sector-information/uk-government-licensing-framework/crown-copyright/
[ogl]: http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/
