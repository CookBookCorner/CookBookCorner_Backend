require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
  include Devise::Test::ControllerHelpers

  let!(:user) { User.create!(email: 'user@example.com', password: 'password', password_confirmation: 'password') }

  describe "GET #index" do
    before do
      Recipe.create!(title: "Test Recipe 1", preparation_time: 10, cooking_time: 20, servings: 2, difficulty: 'easy', instructions: 'Mix ingredients', user: user)
      Recipe.create!(title: "Test Recipe 2", preparation_time: 15, cooking_time: 25, servings: 3, difficulty: 'medium', instructions: 'Mix and bake', user: user)
    end

    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it "loads all of the recipes into @recipes" do
      get :index
      expect(assigns(:recipes).size).to eq(2)
    end
  end

  describe "GET #show" do
    let!(:recipe) { Recipe.create!(title: "Unique Test Recipe", preparation_time: 10, cooking_time: 20, servings: 2, difficulty: 'easy', instructions: 'Sample instructions', user: user )}

    it "responds successfully with an HTTP 200 status code" do
      get :show, params: { id: recipe.id}
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it "loads the correct recipe into @recipe" do
      get :show, params: { id: recipe.id}
      expect(assigns(:recipe)).to eq(recipe)
    end
  end

  describe "POST #create" do
    let(:valid_attributes) {
      { recipe: {
          title: "New Recipe",
          preparation_time: 10,
          cooking_time: 20,
          servings: 2,
          difficulty: 'easy',
          instructions: 'Test instructions',
          user_id: user.id  # Direct reference to user ID
        }
      }
    }
    
    let(:invalid_attributes) {
      { recipe: {
          title: nil,  # Invalid attribute
          preparation_time: 10,
          cooking_time: 20,
          servings: 2,
          difficulty: 'easy',
          instructions: 'Test instructions',
          user_id: user.id
        }
      }
    }

    before do
      sign_in user  # Ensure user is signed in before each test in this context
    end

    context "with valid attributes" do
      it "creates a new recipe" do
        puts "User ID: #{user.id}"
        expect {
          post :create, params: valid_attributes
        }.to change(Recipe, :count).by(1)
      end

      it "returns the created recipe with status code 201" do
        post :create, params: valid_attributes
        expect(response).to have_http_status(:created)
        expect(response.body).to include("New Recipe")
      end
      
    end

    context "with invalid attributes" do
      it "does not create a new recipe" do
        expect {
          post :create, params: invalid_attributes
        }.not_to change(Recipe, :count)
      end

      it "returns unprocessable entity status" do
        post :create, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
