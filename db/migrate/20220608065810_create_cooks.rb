class CreateCooks < ActiveRecord::Migration[6.1]
  def change
    create_table :cooks do |t|
      t.string :name
      t.string :time
      t.string :point
      t.string :image
      t.string :ingredient
      t.string :recipe
      t.string :target_cook

      t.timestamps
    end
  end
end
