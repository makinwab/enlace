require "rails_helper"

RSpec.describe User, type: :model do
  context "name" do
    it { should validate_presence_of :name }
  end

  context "email" do
    it { should validate_presence_of :email }
    it { should allow_value("email@address.com").for(:email) }
    it { should_not allow_value("com").for(:email) }
    it { should_not allow_value("email@address").for(:email) }
    it { should_not allow_value("@.com").for(:email) }
  end

  context "password" do
    it { should validate_presence_of :password }
  end
end
