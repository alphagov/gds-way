require 'govuk_tech_docs'

# Check for broken links
require 'html-proofer'

GovukTechDocs.configure(self)

set :layout, 'custom'

after_build do |builder|
  begin
    HTMLProofer.check_directory(config[:build_dir],
      { :assume_extension => true,
        :disable_external => true,
        :allow_hash_href => true,
        :empty_alt_ignore => true,
        :file_ignore => [
            /search/ # Provided by tech-docs gem but has a "broken" link from html-proofer's point of view
        ]
      }).run
  rescue RuntimeError => e
    abort e.to_s
  end
end