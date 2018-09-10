module Rails
  module AddOns
    module Service
      module Configuration
        def configure
          yield self
        end

        mattr_accessor(:default_notification_sender)    { 'john.doe@domain.local' }
        mattr_accessor(:default_notification_recipient) { 'john.doe@domain.local' }
        mattr_accessor(:notification_environment)       { ::Rails.env }
      end
    end
  end
end