require 'rails_helper'

RSpec.describe Category, type: :request do
  include Devise::Test::IntegrationHelpers
  before :each do
    @user = User.create(name: 'John', email: 'john@gmail.com', password: 'admin1234',
                        password_confirmation: 'admin1234')
    @category = Category.create(name: 'Grocery', icon: 'shopping-bag.png', author_id: @user.id)
  end

  describe 'GET /index' do
    before :each do
      sign_in @user
      get categories_path
    end

    it 'returns a successful status' do
      expect(response).to have_http_status(200)
    end

    it 'renders the index page' do
      expect(response).to render_template('index')
    end

    it 'render exact text on page' do
      expect(response.body).to include('Grocery')
    end
  end
end
