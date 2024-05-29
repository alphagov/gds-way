# Technical Documentation

## Contributing

### Making documentation changes (using the Github interface)

At the bottom of each page of the [hosted GDS Way](https://gds-way.digital.cabinet-office.gov.uk/) there is a `View source` link. This link will take you to to the corresponding [Github](https://github.com/alphagov/gds-way) page where you can use the pencil icon (:pencil:) in the interface to propose edits to a page.

Once you have made your changes you can write a description, click the green `Propose changes` button, and on the following page clickj the green `Create pull request` button.

### Making documentation changes (locally)

To make changes edit the source files in the [source](source) folder.

The bulk of the documentaion that makes up the GDS Way can be found in files located in the `source/standards` and `source/manuals` directories.

### Adding documentation

You can add a new file to the source folder (or an appropriate sub-folder) to create a new page.

It is probably easiest to copy an existing file and change the name if you are new to writing text in [markdown](https://www.markdownguide.org/).

You then need to manually add your new page to one of the menu files in [source/partials/_nav...](source/partials/_nav...) for it to appear in one of the menus.

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

You can use the Dockerfile provided:

```
docker build . -t gds-way
docker run --rm -p 4567:4567 -p 35729:35729 -v $(pwd):/usr/src/docs -it gds-way
```

Otherwise, the following steps will get Middleman running locally.

#### Install Ruby and Bundler

Install Ruby with Rubygems, preferably with a [Ruby version manager][rvm],
and the [Bundler gem][bundler].

A [.ruby-version](./.ruby-version) file is provided for use with [rbenv][].
If you update it, please update the [Dockerfile](./Dockerfile).

#### Clone the repository

Clone the repository using:

```
git clone https://github.com/alphagov/gds-way.git
cd gds-way
```

#### Additional commands for Apple silicon

If you are using a Mac with Apple silicon (such as an M1 chip), you must run additional commands.

> **Note**
> If you are using an Intel Mac, skip this and go to the ‘Install the required gems’ step.

Tell Bundler to use libraries relating to the Apple silicon architecture:

```
 bundle lock --add-platform arm64-darwin-21
 bundle config --local specific_platform true
 bundle config --local build.ffi --enable-libffi-alloc
```

We need to make sure the EventMachine gem is built with OpenSSL from [Homebrew](https://brew.sh/) and not the default macOS version of OpenSSL.

First, install OpenSSL 1.1:

```
brew install openssl@1.1
```

Do not worry if Homebrew says OpenSSL 1.1 is already installed.

Then tell your Mac to use the Homebrew installation of OpenSSL 1.1 when looking for packages (this will last until you end your terminal session):

```
export PKG_CONFIG_PATH=$(brew --prefix openssl@1.1)/lib/pkgconfig
```

#### Install the required gems
Then in the application folder type the following to install the required gems:

```
bundle config set path 'vendor/bundle'
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

### Check external links

If you want to verify that all of the external links in every page work (i.e.
do not return an HTTP error code), use the `check_links.rb` script.

```
bundle exec ruby check_links.rb
```

This script is automatically run as part of CI, but skipped on the main branch
(so that the main branch can always be deployed).

## Deploy

This repo is continuously deployed from the `main` branch by GitHub Actions, using the workflow defined in [`/.github/workflows/bundle_and_release.yml`](/.github/workflows/bundle_and_release.yml).

## Licence

Unless stated otherwise, the codebase is released under [the MIT License][mit].
This covers both the codebase and any sample code in the documentation.

The documentation is [© Crown copyright][copyright] and available under the terms
of the [Open Government 3.0][ogl] licence.

[rvm]: https://www.ruby-lang.org/en/documentation/installation/#managers
[rbenv]: https://github.com/rbenv/rbenv
[bundler]: https://bundler.io/
[mit]: LICENCE
[copyright]: https://www.nationalarchives.gov.uk/information-management/re-using-public-sector-information/uk-government-licensing-framework/crown-copyright/
[ogl]: https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/
