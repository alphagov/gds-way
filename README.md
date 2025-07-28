# Technical Documentation

## Contributing

### Making documentation changes (using the Github interface)

At the bottom of each page of the [hosted GDS Way][gds-way] there is a `View source` link. This link will take you to the corresponding [Github][repo] page where you can use the pencil icon (:pencil:) in the interface to propose edits to a page.

Once you have made your changes you can write a description, click the green `Propose changes` button, and on the following page click the green `Create pull request` button.

### Making documentation changes (locally)

To make changes edit the source files in the [source](source) folder.

The bulk of the documentation that makes up the GDS Way can be found in files located in the `source/standards` and `source/manuals` directories.

### Adding documentation

You can add a new file to the source folder (or an appropriate sub-folder) to create a new page.

It is probably easiest to copy an existing file and change the name if you are new to writing text in [markdown][].

You then need to manually add your new page to one of the menu files in [source/partials/\_nav...](source/partials/_nav...) for it to appear in one of the menus.

### Raising and merging PRs to this repo

To submit changes to this repo, raise a PR in the usual way and these will be regularly reviewed by The GDS Way forum group that meets once a month. Reviewing and merging PRs at any time is fine, the forum will also review merged PRs as part of its regular meeting.

Any open non-draft PRs that have been more than 1 month without further comments, suggestions or alterations will be merged by the forum group unless there is an explicit "DO NOT MERGE" somewhere in the title or description.

There is a GDS Slack channel `#gds-way` where these are discussed.

### Making functional changes

The GDS Way is built from the [Tech Docs Template][tech-docs-template] repository. Any functional changes and bug fixes should be made to that project first, then follow the [instructions to update the GDS Way][updating-tech-docs].

## Running Locally

### Getting started

To preview or build the website, we need to use the terminal.

If you have Docker, you can run the website locally using the [startup script](./startup.sh) provided:

```zsh
./startup.sh
```

If you have [Podman](https://podman.io/) you can also use that instead of Docker:

```zsh
podman machine start
./startup-podman.sh
```


Otherwise, the following steps will get Middleman running locally.

#### Install Ruby and Bundler

Install Ruby with Rubygems, preferably with a [Ruby version manager][rvm], and the [Bundler gem][bundler].

A [.ruby-version](./.ruby-version) file is provided for use with [rbenv][]. If you update it, please update the [Dockerfile](./Dockerfile).

#### Clone the repository

Clone the repository using:

```zsh
git clone https://github.com/alphagov/gds-way.git
cd gds-way
```

#### Install the required gems

Then in the application folder type the following to install the required gems:

```zsh
bundle config set path 'vendor/bundle'
bundle install
```

### Preview

Whilst writing documentation we can run a middleman server to preview how the published version will look in the browser. After saving a change the preview in the browser will automatically refresh.

The preview is only available on our own computer. Others will not be able to access it if they are given the link.

Type the following to start the server:

```zsh
bundle exec middleman server
```

If all goes well something like the following output will be displayed:

```zsh
== The Middleman is loading
== LiveReload accepting connections from ws://192.168.0.8:35729
== View your site at "http://Laptop.local:4567", "http://192.168.0.8:4567"
== Inspect your site configuration at "http://Laptop.local:4567/__middleman", "http://192.168.0.8:4567/__middleman"
```

You should now be able to view a live preview at http://localhost:4567.

### Build

If you want to publish the website without using a build script you may need to build the static HTML files.

Type the following to build the HTML:

```zsh
bundle exec middleman build
```

This will create a `build` subfolder in the application folder which contains the HTML and asset files ready to be published.

### Check external links

If you want to verify that all of the external links in every page work (i.e. do not return an HTTP error code), use the `check_links.rb` script.

```zsh
bundle exec ruby check_links.rb
```

This script is automatically run as part of CI, but skipped on the main branch (so that the main branch can always be deployed).

## Deploy

This repo is continuously deployed from the `main` branch by GitHub Actions, using the workflow defined in [`/.github/workflows/deploy-to-pages.yaml`](/.github/workflows/deploy-to-pages.yaml).

## Licence

Unless stated otherwise, the codebase is released under [the MIT License][mit]. This covers both the codebase and any sample code in the documentation.

The documentation is [© Crown copyright][copyright] and available under the terms of the [Open Government 3.0][ogl] licence.

[gds-way]: https://gds-way.digital.cabinet-office.gov.uk/
[repo]: https://github.com/alphagov/gds-way
[markdown]: https://www.markdownguide.org/
[tech-docs-template]: https://github.com/alphagov/tech-docs-template
[updating-tech-docs]: https://github.com/alphagov/tdt-documentation/blob/main/source/maintain_project/use_latest_template/index.html.md.erb
[rvm]: https://www.ruby-lang.org/en/documentation/installation/#managers
[rbenv]: https://github.com/rbenv/rbenv
[bundler]: https://bundler.io/
[mit]: LICENCE
[copyright]: https://www.nationalarchives.gov.uk/information-management/re-using-public-sector-information/uk-government-licensing-framework/crown-copyright/
[ogl]: https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/
