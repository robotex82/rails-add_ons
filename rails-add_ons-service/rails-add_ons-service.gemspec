$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require_relative "../lib/rails/add_ons/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails-add_ons-service"
  s.version     = Rails::AddOns::VERSION
  s.authors     = ["Roberto Vasquez Angel"]
  s.email       = ["roberto.vasquez@enermarket.de"]
  s.homepage    = "https://github.com/rails-add_ons"
  s.summary     = "Services for Ruby on Rails."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 3.2.0"
  s.add_dependency "rails-add_ons"

  s.add_development_dependency "sqlite3"
end
