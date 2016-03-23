require "rails_helper"

RSpec.describe UsersController, type: :controller do
  describe "GET #new" do
    it "renders the signup page" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    it "creates user and renders template" do
      user = create(:user)
      post :create, user: {
        name: user.name,
        email: user.email,
        password: user.password
      }

      expect(response.status).to eql 302
      expect(response).to redirect_to "/links/new"
      expect(User.last.email).to eql user.email
    end
  end
end
