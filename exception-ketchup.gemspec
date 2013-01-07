# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "exception-ketchup"
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Daniel Schmidt", "Lars M\u{fc}ller"]
  s.date = "2013-01-07"
  s.description = "Rails exception handling happens with ActionController extension and Mongoid support."
  s.email = "dsci@code79.net"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".document",
    ".rspec",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "exception-ketchup.gemspec",
    "lib/exception-ketchup.rb",
    "lib/rails/controller.rb",
    "lib/rails/error.rb",
    "lib/rails/mailer.rb",
    "lib/util/handler.rb",
    "lib/util/support.rb",
    "spec/dummy/README.rdoc",
    "spec/dummy/Rakefile",
    "spec/dummy/app/assets/javascripts/application.js",
    "spec/dummy/app/assets/stylesheets/application.css",
    "spec/dummy/app/controllers/application_controller.rb",
    "spec/dummy/app/helpers/application_helper.rb",
    "spec/dummy/app/mailers/.gitkeep",
    "spec/dummy/app/models/.gitkeep",
    "spec/dummy/app/views/layouts/application.html.erb",
    "spec/dummy/app/views/notifications/exception.html.erb",
    "spec/dummy/config.ru",
    "spec/dummy/config/application.rb",
    "spec/dummy/config/boot.rb",
    "spec/dummy/config/environment.rb",
    "spec/dummy/config/environments/development.rb",
    "spec/dummy/config/environments/production.rb",
    "spec/dummy/config/environments/test.rb",
    "spec/dummy/config/i18n-js.yml",
    "spec/dummy/config/initializers/backtrace_silencers.rb",
    "spec/dummy/config/initializers/inflections.rb",
    "spec/dummy/config/initializers/mime_types.rb",
    "spec/dummy/config/initializers/secret_token.rb",
    "spec/dummy/config/initializers/session_store.rb",
    "spec/dummy/config/initializers/wrap_parameters.rb",
    "spec/dummy/config/locales/en.yml",
    "spec/dummy/config/mongoid.yml",
    "spec/dummy/config/routes.rb",
    "spec/dummy/lib/assets/.gitkeep",
    "spec/dummy/public/404.html",
    "spec/dummy/public/422.html",
    "spec/dummy/public/500.html",
    "spec/dummy/public/favicon.ico",
    "spec/dummy/script/rails",
    "spec/lib/controller_spec.rb",
    "spec/lib/error_spec.rb",
    "spec/lib/exception-ketchup_spec.rb",
    "spec/lib/mailer_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = "http://github.com/datenspiel/exception-ketchup"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "Rails exception handling happens with ActionController extension and Mongoid support."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, [">= 0"])
      s.add_runtime_dependency(%q<mongoid>, [">= 0"])
      s.add_runtime_dependency(%q<bson_ext>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.8.0"])
      s.add_development_dependency(%q<rspec-rails>, [">= 0"])
      s.add_development_dependency(%q<database_cleaner>, [">= 0"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.8.4"])
      s.add_development_dependency(%q<fuubar>, [">= 0"])
    else
      s.add_dependency(%q<rails>, [">= 0"])
      s.add_dependency(%q<mongoid>, [">= 0"])
      s.add_dependency(%q<bson_ext>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 2.8.0"])
      s.add_dependency(%q<rspec-rails>, [">= 0"])
      s.add_dependency(%q<database_cleaner>, [">= 0"])
      s.add_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<jeweler>, ["~> 1.8.4"])
      s.add_dependency(%q<fuubar>, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>, [">= 0"])
    s.add_dependency(%q<mongoid>, [">= 0"])
    s.add_dependency(%q<bson_ext>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 2.8.0"])
    s.add_dependency(%q<rspec-rails>, [">= 0"])
    s.add_dependency(%q<database_cleaner>, [">= 0"])
    s.add_dependency(%q<rdoc>, ["~> 3.12"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<jeweler>, ["~> 1.8.4"])
    s.add_dependency(%q<fuubar>, [">= 0"])
  end
end

