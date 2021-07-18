require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /index" do

    before(:each) do
      get '/users'
    end

    it "should respond with 200 ok" do
      expect(response).to have_http_status(200)
    end

    it "should respond with json" do
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end


  end

  describe "GET /users/:id" do

    before(:all) do
      create(:user)
    end

    before(:each) do
      build(:user)
    end

    context "when going to a valid id" do
      before(:each) do
        get '/users/1'
      end

      it "should respond with 200 ok" do
        expect(response).to have_http_status(200)
      end
  
      it "should respond with json" do
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end

    context "when going to an invalid id" do
      before(:each) do
        get "/users/999"
      end

      it "should respond with 404 not found" do
        expect(response).to have_http_status(404)
      end

      it "should respond with a 'Page not found' " do
        expect(response.body).to include("Page not found")
      end
    end
  end
end
