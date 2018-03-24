module Rails
  module AddOns
    module Configuration
      def configure
        yield self
      end

      mattr_accessor(:table_default_timestamp_format) { :short }
    end
  end
end
