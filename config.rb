require 'govuk_tech_docs'

# Check for broken links
require 'html-proofer'

GovukTechDocs.configure(self)

set :layout, 'custom'

after_build do |builder|
  begin
    proofer = HTMLProofer.check_directory(config[:build_dir],
      { :assume_extension => true,
        :allow_hash_href => true,
        :empty_alt_ignore => true,
        :file_ignore => [
            /search/ # Provided by tech-docs gem but has a "broken" link from html-proofer's point of view
        ],
        :url_ignore => [
            "https://github.com/alphagov/centralised-security-logging-service"
        ]
      })

      proofer.before_request do |request|
        # We get rate-limited by GitHub so pause between checking GitHub links
        sleep 2 if request.base_url == "https://github.com/"
      end

      proofer.run
  rescue RuntimeError => e
    abort e.to_s
  end
end