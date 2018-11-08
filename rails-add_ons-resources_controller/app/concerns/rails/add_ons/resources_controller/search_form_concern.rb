module Rails
  module AddOns
    module ResourcesController::SearchFormConcern
      extend ActiveSupport::Concern

      included do
        helper Rails::AddOns::SearchFormHelper
      end
    end
  end
end
