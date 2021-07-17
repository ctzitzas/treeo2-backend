require 'rails_helper'

RSpec.describe User, type: :model do
  
  it 'has a valid factory' do
    user = build(:user)
    expect(user).to be_valid
  end

  context "validations" do
    before(:each) do
      @user = build(:user)
    end

    it "is invalid without a name" do
      user = build(:user, name: nil)
      expect(user).to_not be_valid
    end

    it "is invalid without an email" do
      user = build(:user, email: nil)
      expect(user).to_not be_valid
    end

    it "is invalid without a password" do
      user = build(:user, password_digest: nil)
      expect(user).to_not be_valid
    end
    
    it "is invalid without a key" do
      user = build(:user, key: nil)
      expect(user).to_not be_valid
    end

    it "is invalid without admin set" do
      user = build(:user, user_type: nil)
      expect(user).to_not be_valid
    end

    it "is invalid with out a proper email" do
      user = build(:user, email: "something")
      expect(user).to_not be_valid
    end

    it "is invalid with a password less than 8 characters" do
      user = build(:user, password_digest: "ga67")
      expect(user).to_not be_valid
    end

  end

end
