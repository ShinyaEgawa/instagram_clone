require 'rails_helper'

RSpec.feature "SignUps", type: :feature do
  include ActiveJob::TestHelper

  scenario "ユーザーはサインアップに成功する" do
    visit root_path
    click_link "Sign up now!"

    perform_enqueued_jobs do
      expect {
        fill_in "user[name]",                   with: "Example user"
        fill_in "user[user_name]",              with: "Example"
        fill_in "user[email]",                  with: "test@example.com"
        fill_in "user[password]",               with: "test123"
        fill_in "user[password_confirmation]",  with: "test123"
        click_button "Create my account"
      }.to change(User, :count).by(1)

      expect(current_path).to eq "/" #メールでの有効化がまだであるため,"/"へ移行
    end

# 以下メール有効化のテスト

    #mail = ActionMailer::Base.deliveries.last


  # aggregate_failures do
  #   expect(mail.to).to eq ["test@example.com"]
  #   expect(mail.from).to eq ["noreply@example.com"]
  #   expect(mail.subject).to eq "Account activation"
  # end
  end
end
