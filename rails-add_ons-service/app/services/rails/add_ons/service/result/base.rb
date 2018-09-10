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

        module Mailable
          def notify_now(recipient = nil)
            recipient ||= default_notification_recipient
            sender    ||= default_notification_sender
            ::Rails::AddOns::Service::NotificationMailer.with(result: self, environment: notification_environment, sender: sender, recipient: recipient).result_email.deliver_now
          end

          def default_notification_sender
            ::Rails::AddOns::Service::Configuration.default_notification_sender
          end

          def default_notification_recipient
            ::Rails::AddOns::Service::Configuration.default_notification_recipient
          end

          def notification_environment
            ::Rails::AddOns::Service::Configuration.notification_environment.call(self)
          end
            
        end

        include Mailable
      end
    end
  end
end
