require 'rails_helper'

RSpec.feature "Edit", type: :feature do
  let(:user) { FactoryBot.create(:user) }

  scenario "ユーザーは編集に成功する" do
    valid_login(user)
    visit user_path(user)
    #valid_login(user) フレンドリーフォワーディングのテスト用
    click_link "Settings"

    fill_in "user[name]",                  with: "Rails"
    fill_in "user[email]",                 with: "edit@example.com"
    fill_in "user[password]",              with: "password", match: :first
    fill_in "user[password_confirmation]", with: "password", match: :first
    click_button "Save changes"
    expect(current_path).to eq user_path(user)
    expect(user.reload.email).to eq "edit@example.com"
    expect(user.reload.password).to eq "password"
  end

  scenario "ユーザーは編集に失敗する" do
    valid_login(user)    # spec/support/login_support.rbに定義済み
    visit user_path(user)
    click_link "Settings"

    fill_in "user[email]",                  with: "foo@invalid"
    fill_in "user[password]",              with: "foo", match: :first
    fill_in "user[password_confirmation]", with: "bar"
    click_button "Save changes"

    expect(user.reload.email).to_not eq "foo@invalid"
  end
end
