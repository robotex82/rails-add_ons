$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rails/add_ons/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails-add_ons"
  s.version     = Rails::AddOns::VERSION
  s.authors     = ["Roberto Vasquez Angel"]
  s.email       = ["roberto@vasquez-angel.de"]
  s.summary     = "Rails Add Ons."
  s.description = "The missing bits."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 3.2"
end
