require "rails_helper"

RSpec.describe Link, type: :model do
  let(:link) { build(:link) }

  it { should validate_presence_of :given_url }

  describe "#generate_slug" do
    it "creates/saves a random string with length of 5" do
      link.generate_slug
      expect(link.slug).not_to eql nil
      expect(link.slug.length).to eql 5
    end
  end

  describe "#display_slug" do
    it "returns the shortened url" do
      link.generate_slug
      url = ENV["BASE_URL"] + link.slug
      expect(link.display_slug).to eql url
    end
  end
end