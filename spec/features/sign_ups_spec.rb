require 'rails_helper'

RSpec.feature "SignUps", type: :feature do
  include ActiveJob::TestHelper

  scenario "ユーザーはサインアップに成功する" do
    visit root_path
    click_link "Sign up now!"

    perform_enqueued_jobs do
      expect {
        fill_in "名前",            with: "Example"
        fill_in "メールアドレス",    with: "test@example.com"
        fill_in "パスワード",       with: "test123"
        fill_in "パスワード(確認)",  with: "test123"
        click_button "Sign up"
      }.to change(User, :count).by(1)

      expect(current_path).to eq root_path
    end

    mail = ActionMailer::Base.deliveries.last

   aggregate_failures do
     expect(mail.to).to eq ["test@example.com"]
     expect(mail.from).to eq ["noreply@example.com"]
     expect(mail.subject).to eq "Account activation"
   end
  end
end
