module Rails
  module AddOns
    module Service::Result
      class Base
        extend ActiveModel::Translation
        
        attr_reader :messages, :errors, :service

        def initialize(service)
          @service = service
        end

        def model_name
          @service.model_name
        end

        module Succeedable
          def success?
            !failed?
          end

          def failed?
            @errors.any?
          end

          def ok?
            success?
          end
        end

        include Succeedable
      end
    end
  end
end
