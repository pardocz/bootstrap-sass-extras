module BootstrapFlashHelper
  ALERT_TYPES_MAP = {
    notice: :success,
    alert: :danger,
    error: :danger,
    info: :info,
    warning: :warning
  }.freeze

  def bootstrap_flash(additional_accepted_types={})
    safe_join(flash.each_with_object([]) do |(type, message), messages|
                next if message.blank? || !message.respond_to?(:to_str)
                type = ALERT_TYPES_MAP.merge(additional_accepted_types).fetch(type.to_sym, nil)
                if type
                  messages << flash_container(type, message)
                end
              end, "\n").presence
  end

  def flash_container(type, message)
    content_tag :div, class: "alert alert-#{type} alert-dismissable" do
      button_tag type: "button", class: "close", data: { dismiss: "alert" } do
        "&times;".html_safe
      end.safe_concat(message)
    end
  end
end
