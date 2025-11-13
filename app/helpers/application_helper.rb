module ApplicationHelper
  # TailwindCSSはフラッシュメッセージスタイル用意していないため定義
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

  # タイトル動的表示
  def page_title(title = "")
    base_title = "SkyPhotos"
    title.present? ? "#{title}" : ""
  end

  # メタタグ,動的OGP
  def default_meta_tags
    base_title = "SkyPhotos"
    title = content_for?(:title) ? content_for(:title) : ""
    description = "ふと見上げた空を共有しよう。空の写真を投稿できるアプリ「Skyphotos」"
    {
      site: base_title,
      title: page_title(title),
      reverse: true,
      charset: "utf-8",
      description: description,
      keywords: "空, 写真, エモい, sky, photos, 共有",
      og: {
        site_name: base_title,
        title: page_title(title),
        description: description,
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

  # 動的OGP画像,cloudinaryに保存された画像引っ張ってくる
  def ogp_image_url
    if @post&.id
      public_id = @post.image.key
      cloud_name = Rails.application.credentials.dig(:cloudinary, :cloud_name)
      return "https://res.cloudinary.com/#{cloud_name}/image/upload/#{public_id}.jpeg"
    end
    # デフォルトOGP画像
    image_url("default_sky.png")
  end
end
