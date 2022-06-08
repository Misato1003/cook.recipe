class Cook < ApplicationRecord
  # 料理モデルと画像を紐付けた
  mount_uploader :image, ImageUploader
end
