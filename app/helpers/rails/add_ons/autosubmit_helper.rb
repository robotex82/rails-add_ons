module Rails
  module AddOns
    module AutosubmitHelper
      def autosubmit
        if autosubmit_now?
          content_tag(:div, nil, data: { autosubmit: true} ).html_safe
        end
      end
    end
  end
end
