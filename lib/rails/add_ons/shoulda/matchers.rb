require 'rails/add_ons/shoulda/matchers/implement_create_action_matcher'
require 'rails/add_ons/shoulda/matchers/implement_show_action_matcher'
require 'rails/add_ons/shoulda/matchers/implement_update_action_matcher'
require 'rails/add_ons/shoulda/matchers/implement_delete_action_matcher'
require 'rails/add_ons/shoulda/matchers/implement_index_action_matcher'

module Rails
  module AddOns
    module Shoulda
      # Adding the matchers to rspec:
      #
      #     # spec/rails_helper or supoprt/rails-add_ons.rb
      #     require 'rails/add_ons/shoulda/matchers'
      #     
      #     RSpec.configure do |config|
      #       config.include Rails::AddOns::Shoulda::Matchers, type: :feature
      #     end
      module Matchers
      end
    end
  end
end
