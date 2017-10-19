require 'haml-rails'
require 'font-awesome-rails'
begin
  require 'twitter_bootstrap_components_rails'
rescue LoadError
  puts "[Rails AddOns]: WARNING - Could not require twitter_bootstrap_components_rails."
end
require 'simple_form'
require 'responders' if Rails::VERSION::MAJOR > 3
require 'rails-i18n'
require 'active_model/model' if Rails::VERSION::MAJOR < 4

require 'rails/add_ons'
