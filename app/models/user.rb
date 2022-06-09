class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :image, ImageUploader # userモデルと画像を紐づける

  has_many :cooks
  has_many :likes
  has_many :posts

  def liked_by?(cook_id)
    likes.where(cook_id: cook_id).exists?
  end
end
