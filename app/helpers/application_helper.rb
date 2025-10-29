module ApplicationHelper
  def flash_message_class(message_type)
    case message_type
    when "success"
      "text-green-800 bg-green-50 border border-green-300"
    when "danger", "alert", "error"
      "text-red-800 bg-red-50 border border-red-300"
    when "warning"
      "text-yellow-800 bg-yellow-50 border border-yellow-300"
    when "notice", "info"
      "text-blue-800 bg-blue-50 border border-blue-300"
    else
      "text-gray-800 bg-gray-50 border border-gray-300"
    end
  end

  def page_title(title = "")
    base_title = "SkyPhotos"
    title.present? ? "#{title} | #{base_title}" : base_title
  end

  def show_meta_tags
    assign_meta_tags if display_meta_tags.blank?
    display_meta_tags
  end

  def default_meta_tags
  {
    site: "SkyPhotos",
    title: "SkyPhotos",
    reverse: true,
    charset: "utf-8",
    description: "ふと見上げた空を共有しよう。空の写真を投稿できるアプリ「Skyphotos」。",
    keywords: "空, 写真, エモい, sky, photos, 共有",
    og: {
      site_name: :site,
      title: :title,
      description: :description,
      type: "website",
      url: request.original_url,
      image: ogp_image_url,
      locale: "ja-JP"
    },
    twitter: {
      card: "summary_large_image",
      image: ogp_image_url
    }
  }
  end

  def ogp_image_url
    if @post&.id
      public_id = @post.image.key
      cloud_name = Rails.application.credentials.dig(:cloudinary, :cloud_name)
      return "https://res.cloudinary.com/#{cloud_name}/image/upload/#{public_id}.jpeg"
    end
    # デフォルトOGP画像
    image_url("place_holder.png")
  end
end
