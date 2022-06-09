class Cook < ApplicationRecord
  # 料理モデルと画像を紐付けた
  mount_uploader :image, ImageUploader

  # バリデーション(料理名、材料、作り方　必須)
  validates :name, presence: true
  validates :ingredient, presence: true
  validates :recipe, presence: true

  belongs_to :user
  has_many :likes
  has_many :posts
end
