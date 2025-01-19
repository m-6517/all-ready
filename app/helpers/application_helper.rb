module ApplicationHelper
  def flash_background_color(type)
    case type.to_sym
    when :notice then "bg-sky-100 text-sky-700"
    when :alert then "bg-white border-accent text-accent"
    end
  end

  def page_title(title = "")
    base_title = "All Ready"
    title.present? ? "#{title} | #{base_title}" : base_title
  end
end
