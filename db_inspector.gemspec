$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "db_inspector/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "db_inspector"
  s.version     = DbInspector::VERSION
  s.authors     = ["xiaohui"]
  s.email       = ["xiaohui@tanmer.com"]
  s.homepage    = "http://github.com/tanmer"
  s.summary     = "Inspect Database."
  s.description = "Inspect Database."
  s.license     = "MIT"

  s.files = Dir["{lib}/**/*", "MIT-LICENSE", "README.md"]

  s.add_dependency "rails", ">= 4.8"

  s.add_development_dependency "sqlite3"
end
