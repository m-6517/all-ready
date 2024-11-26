class User < ApplicationRecord
  has_many :recommends, dependent: :destroy
  has_many :item_lists, dependent: :destroy
  has_many :original_items, dependent: :destroy
  has_many :bag_contents, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true
  validates :encrypted_password, presence: true
  validates :uid, uniqueness: { scope: :provider }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  mount_uploader :avatar, AvatarUploader

  def own?(object)
    id == object&.user_id
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.name = auth.info.name
      user.password = Devise.friendly_token[0, 20]
      user.avatar = auth.info.image
    end
  end
end
