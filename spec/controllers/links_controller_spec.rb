require "rails_helper"

RSpec.describe LinksController, type: :controller do
  describe "GET #show" do
    it "renders template and displays all links" do
      link = create(:link)
      get :show, slug: link.slug

      expect(response.status).to eql 302
      expect(response).to redirect_to link.given_url
    end
  end

  describe "GET #new" do
    context "when a user is logged in" do
      it "renders the new template" do
        user, link = create_links_with_users

        get :new, {}, user_id: user.id

        expect(response).to render_template(:new)
        expect(response.status).to eql 200
        expect(Link.last.user_id).to eql user.id
      end
    end

    context "when no user is logged in" do
      it "renders the new template" do
        link = create(:link)
        post :create, link: { given_url: link.given_url }

        get :new

        expect(response).to render_template(:new)
        expect(response.status).to eql 200
        expect(Link.last.user_id).to eql nil
      end
    end
  end

  describe "GET #edit" do
    it "renders the edit template" do
      link = create(:link)

      get :edit, id: link.id

      expect(response).to render_template(:edit)
      expect(response.status).to eql 200
    end
  end

  describe "POST #create" do
    context "when no user is logged in" do
      it "creates a link" do
        link = create(:link)
        post :create, link: { given_url: link.given_url }

        expect(response.status).to eql 302
        expect(flash[:notice]).to match(/^Short Url is '#{Link.last.display_slug}'/)
      end
    end

    context "when a user is logged in" do
      it "creates a link for the user" do
        user, link = create_links_with_users

        expect(response.status).to eql 302
        expect(Link.last.user_id).to eql user.id
        expect(flash[:notice]).to match(/^Short Url is '#{Link.last.display_slug}'/)
      end
    end
  end

  describe "PUT #update" do
    it "updates a link" do
      user, link = create_links_with_users
      latest_link = Link.last

      put :update, { id: latest_link.id, link: { active: true } }, user_id: user.id

      updated_link = Link.find_by(id: latest_link.id)

      expect(response).to redirect_to "/links/new"
      expect(updated_link[:active]).to eql true
      expect(flash[:notice]).to match(/^Link was successfully updated/)
    end
  end

  describe "DELETE #destroy" do
    it "deletes a link" do
      user, link = create_links_with_users
      latest_link = Link.last

      delete :destroy, id: latest_link.id

      expect(response.status).to eql 302
      expect(Link.find_by(id: latest_link.id)).to eql nil
      expect(flash[:notice]).to match(/^Link was successfully deleted/)
    end
  end
end
