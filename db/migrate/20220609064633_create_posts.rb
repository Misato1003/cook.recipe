class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :content
      t.string :nickname
      t.references :user, foreign_key: true
      t.references :cook, foreign_key: true

      t.timestamps
    end
  end
end
