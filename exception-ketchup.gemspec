VERSION=File.read('VERSION').chomp

Gem::Specification.new do |s|
  s.name          = "exception-ketchup"
  s.version       = VERSION
  s.authors       = ["Daniel Schmidt", "Lars Müller", "Gwen Glaser"]
  s.email         = "dsci@code79.net"
  s.summary       = "Rails exception handling happens with ActionController extension and Mongoid support."
  s.description   = "Rails exception handling happens with ActionController extension and Mongoid support."
  s.homepage      = "https://github.com/datenspiel/exception-ketchup"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")

  s.licenses      = ["MIT"]
  s.require_paths = ["lib"]

  s.add_dependency "rails"
  s.add_dependency "mongoid"
end

