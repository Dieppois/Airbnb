module ApplicationHelper
  def field_error_messages(resource, field)
    return unless resource.errors[field].any?

    content_tag(:div, class: "text-red-600 text-sm mt-1") do
      resource.errors[field].map do |msg|
        content_tag(:div, msg)
      end.join.html_safe
    end
  end
end
