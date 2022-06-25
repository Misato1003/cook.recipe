require 'rails_helper'

RSpec.describe Cook, type: :model do
  describe "料理を登録する際、バリデーションが機能しているかどうかの確認" do
    it "料理名、レシピ、材料があれば、有効であること" do
      @cook = Cook.new(
        name: "cookName",
        recipe: "cookRecipe",
        ingredient: "cookIngredient"
      )
      expect(@cook).to be_valid
    end

    it "料理名がなければ無効であること" do
      @cook = Cook.new(name: nil)
      expect(@cook.valid?).to eq(false)
    end

    it "レシピがなければ無効であること" do
      @cook = Cook.new(recipe: nil)
      expect(@cook.valid?).to eq(false)
    end

    it "材料がなければ無効であること" do
      @cook = Cook.new(ingredient: nil)
      expect(@cook.valid?).to eq(false)
    end

    it "nilの場合、無効であること" do
      expect(Cook.new).not_to be_valid
    end
  end
end
