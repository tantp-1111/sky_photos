class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :body, length: { maximum: 65_535 }

  belongs_to :user
  has_one_attached :image
  validate :image_content_type
  validate :image_size
  validates :image, presence: true

  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  # アップロード形式のバリデーション
  def image_content_type
    if image.attached? && !image.content_type.in?(%w[image/jpeg image/jpg image/png])
      errors.add(:image, "：JPEG,JPG,PNGをアップロードしてください")
    end
  end
  # 画像サイズのバリデーション
  def image_size
    if image.attached? && image.blob.byte_size > 10.megabytes
      errors.add(:image, "：10MB以下の画像をアップロードしてください")
    end
  end

  # サムネイル表示用メソッド
  def image_as_thumbnail
    return unless image.content_type.in?(%w[image/jpeg image/jpg image/png])
    image.variant(resize_to_limit: [ 400, 400 ]).processed
  end
end
