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

  def default_meta_tags
    {
      site: "All Ready",
      title: "All Ready",
      reverse: true,
      charset: "utf-8",
      description: "All Readyは、行き先ごとに持ち物リストを作成・共有できるサービスです。
      さらに、マストアイテムを1つ共有することもできます。
      自分の持ち物を整理し他のユーザーと共有することで、より充実した準備ができるようサポートします。",
      canonical: request.original_url,
      og: {
        site_name: "All Ready",
        title: "All Ready",
        type: "website",
        url: request.original_url,
        image: image_url("ogp.png"),
        local: "ja-JP"
      },
      twitter: {
        card: "summary_large_image",
        site: "@kumateq",
        image: image_url("ogp.png")
      }
    }
  end
end
