require 'rails_helper'

RSpec.describe "HomesApi", type: :request do
  describe "GET path check" do
    it "Homeページのhttpリクエストは正しいか" do
      get root_path
      expect(response).to have_http_status(200)
    end

    it "Aboutページのhttpリクエストは正しいか" do
      get about_path
      expect(response).to have_http_status(200)
    end

    it "Helpページのhttpリクエストは正しいか" do
      get help_path
      expect(response).to have_http_status(200)
    end

    it "Contactページのhttpリクエストは正しいか" do
      get contact_path
      expect(response).to have_http_status(200)
    end

    it "User/newページのhttpリクエストは正しいか" do
      get signup_path
      expect(response).to have_http_status(200)
    end
  end
end
