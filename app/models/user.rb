class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }

  has_many :recommends, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
