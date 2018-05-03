module ResourcesController
  module SearchFormConcern
    extend ActiveSupport::Concern

    included do
      helper Rails::AddOns::SearchFormHelper
    end
  end
end
