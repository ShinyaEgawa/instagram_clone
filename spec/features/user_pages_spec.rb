require 'rails_helper'

RSpec.feature "UserPages", type: :feature do
  describe "signup page" do
    before do
      visit signup_path
    end

    it "新規登録ページに'Sign up'と表示されていること" do
      expect(page).to have_content "Sign up"
    end
  end
end
