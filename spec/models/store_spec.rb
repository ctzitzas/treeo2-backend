require 'rails_helper'

RSpec.describe Store, type: :model do
  
  it "has a valid factory" do
    store = build(:store)
    expect(store).to be_valid
  end

  context "validations" do
    before(:each) do
      @store = build(:store)
    end

    it "is invalid without a name" do
      store = build(:store, name: nil)
      expect(store).to_not be_valid
    end

    it "is invalid without an address" do
      store = build(:store, address: nil)
      expect(store).to_not be_valid
    end

    it "is invalid without a suburb" do
      store = build(:store, suburb: nil)
      expect(store).to_not be_valid
    end
    
    it "is invalid without a state" do
      store = build(:store, state: nil)
      expect(store).to_not be_valid
    end

    it "is invalid with only 2 letters" do
      store = build(:store, state: 'vi')
      expect(store).to_not be_valid
    end

    it "is invalid without a postcode" do
      store = build(:store, postcode: nil)
      expect(store).to_not be_valid
    end

  end

end