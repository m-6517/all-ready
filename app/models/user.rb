class User < ApplicationRecord
  has_many :recommends, primary_key: :uuid, foreign_key: :user_uuid, dependent: :destroy
  has_many :item_lists, primary_key: :uuid, foreign_key: :user_uuid
  has_many :original_items, dependent: :destroy
  has_many :bag_contents, primary_key: :uuid, foreign_key: :user_uuid, dependent: :destroy
  has_many :bookmarks, primary_key: :uuid, foreign_key: :user_uuid, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true
  validates :encrypted_password, presence: true
  validates :uid, presence: true, uniqueness: { scope: :provider }, if: -> { provider == "google_oauth2" }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [ :google_oauth2 ]

  mount_uploader :avatar, AvatarUploader

  def own?(object)
    uuid == object&.user_uuid
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.name = auth.info.name
      user.password = Devise.friendly_token[0, 20]
      user.avatar = auth.info.image
    end
  end

  def bookmark(bookmarkable)
    bookmarks.create!(bookmarkable: bookmarkable, user_uuid: uuid)
  end

  def unbookmark(bookmarkable)
    bookmarks.find_by(bookmarkable: bookmarkable, user_uuid: uuid)&.destroy
  end

  def bookmark?(bookmarkable)
    bookmarks.exists?(bookmarkable: bookmarkable, user_uuid: uuid)
  end
end
