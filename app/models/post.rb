class Post < ApplicationRecord
  belongs_to :user
  belongs_to :cook

  # バリデーション（nickname,contens)
  validates :nickname, presence: true
  validates :content, presence: true
end
