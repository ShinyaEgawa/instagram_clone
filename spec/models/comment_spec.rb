require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { FactoryBot.build(:comment) }
  def setup
    @user = User.new(
      name: "Archer Mike",
      user_name: "Archer",
      email: "archer@example.com",
      password: "foobar",
      password_confirmation: "foobar"
    )

    @other_user = User.create(
      name: "OtherUser",
      user_name: "Other",
      email: "other@example.com",
      password: "foobar",
      password_confirmation: "foobar"
    )

    @micropost = @other_user.microposts.create(
      content_name: "test",
      created_at: Time.zone.now
    )

    @comment = @micropost.comments.build(
      content = "hi!",
      user_id = @user.id,
      created_at: Time.zone.now
    )
  end
end
