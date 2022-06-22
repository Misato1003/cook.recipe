class AddUserToCooks < ActiveRecord::Migration[6.1]
  def change
    add_reference :cooks, :user, foreign_key: true
  end
end
