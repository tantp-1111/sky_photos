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

  def assign_meta_tags(options = {})
    defaults = default_meta_tags # 定義しているデフォルト設定
    options.reverse_merge!(defaults)

    image = options[:image].presence || ( request.base_url + image_path('place_holder.png') )

    meta_config = {
      site: options[:site],
      title: options[:title],
      description: options[:body],
      keywords: options[:keywords],
      canonical: request.original_url,
      reverse: true,
      separator: '|',
      og: {
        title: options[:title].presence || options[:site],
        body: options[:body],
        url: request.original_url,
        image:,
        site_name: options[:site],
        type: 'website'
      },
      twitter: {
        card: 'summary_large_image',
        site: options[:site],
        image:
      }
    }

    set_meta_tags(meta_config)
  end

  # default_meta_tagsメソッド
  def default_meta_tags
    {
      site: 'Skyphotos',
      title: '空の写真を共有するエモいアプリ',
      body: 'ふと見上げた空を共有しよう。空の写真を投稿できるアプリ「Skyphotos」',
      keywords: '空, 写真, エモい, sky, photos, 共有'
    }
  end
end
