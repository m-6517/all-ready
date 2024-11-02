class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true
  validates :encrypted_password, presence: true

  has_many :recommends, dependent: :destroy
  has_many :item_lists, dependent: :destroy
  has_many :original_items, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def own?(object)
    id == object&.user_id
  end
end
