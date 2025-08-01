require 'govuk_tech_docs'

environment = ENV.fetch('APP_ENV', 'local')

GovukTechDocs.configure(self, livereload: environment == 'docker' ? { js_host: 'localhost' } : {})

set :layout, 'custom'
