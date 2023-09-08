require 'govuk_tech_docs'

# Check for broken links
require 'html-proofer'

GovukTechDocs.configure(self)

set :layout, 'custom'
set :relative_links, true
activate :relative_assets

after_build do |builder|
  begin
    proofer = HTMLProofer.check_directory(config[:build_dir],
      { :assume_extension => true,
        :allow_hash_href => true,
        :check_internal_hash => true,
        :empty_alt_ignore => true,
        :file_ignore => [
            /search/ # Provided by tech-docs gem but has a "broken" link from html-proofer's point of view
        ],
        :url_ignore => [
            "https://gdshelpdesk.digital.cabinet-office.gov.uk",
            "https://alphagov.github.io/gds-way/standards/secrets-acl.html",
            /https:\/\/github.com\//
        ]
      })

      proofer.run
  rescue RuntimeError => e
    abort e.to_s
  end
end
