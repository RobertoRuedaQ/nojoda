require 'rails_helper'

RSpec.describe "StudentEmailBatches", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/student_email_batches/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/student_email_batches/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/student_email_batches/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/student_email_batches/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/student_email_batches/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/student_email_batches/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
