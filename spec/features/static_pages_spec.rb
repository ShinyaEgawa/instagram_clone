require 'rails_helper'

RSpec.feature "StaticPages", type: :feature do
  describe "Home page" do
    before do
      visit root_path
    end

    it "タイトルが正しく表示されていること" do
      expect(page).to have_title full_title('')
    end
  end
end
