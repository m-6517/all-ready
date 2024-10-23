module ApplicationHelper
  def flash_background_color(type)
    case type.to_sym
    when :notice then "bg-sky-100 text-sky-700"
    when :alert then "bg-sky-100 text-sky-700"
    end
  end
end
