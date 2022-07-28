require 'rails_helper'

RSpec.describe 'Shopping List', type: :request do
  before(:each) do
    @user = User.new(
      name: "Augusto",
      email: "augusto@dev.com",
      password: "123456",
      password_confirmation: "123456",
      confirmed_at: Time.now,
      role: "admin")
    current_user = @user
    @user.skip_confirmation!
    @user.save!
    sign_in @user

    food = Food.create(
      name: "Carrot",
      measurement_unit: "kgs",
      price: 2.5,
      quantity: 1000,
      user_id: @user.id
    )

    recipe = Recipe.create(
      name: "Tasty dish",
      preparation_time: 1.1,
      cooking_time: 2.1,
      description: "Very tasty dish description",
      user_id: @user.id,
      public: true
    )

    recipeFood = RecipeFood.create(
      quantity: 2,
      recipe_id: recipe.id,
      food_id: food.id
    )
  end

  describe 'GET /index' do
    before { get general_shopping_list_index_path }

    it 'returns a 200 status code' do
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      expect(response).to render_template('index')
    end

    it 'should render the correct text' do
      expect(response.body).to include("Amount of food items to buy: 1")
    end
  end
end
