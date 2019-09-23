require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  context "when user is valid" do
    it "値が入っている場合" do
      expect(@user).to be_valid
    end
    it "emailが空白の場合" do
      @user.email = " "
      expect(@user).to be_invalid
    end
  end

  context "when email format is invalid" do
    it "emailのvalidateが正しく機能しているか" do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                          foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
        expect(FactoryBot.build(:user, email: invalid_address)).to be_invalid
      end
    end
  end

  context "when email addresses should be unique" do
    it "一意性が正しく機能しているか" do
      duplicate_user = @user.dup
      duplicate_user.email = @user.email.upcase
      @user.save!
      expect(duplicate_user).to be_invalid
    end
  end
  it "emailを小文字に変換後の値と大文字を混ぜて登録されたアドレスが同じか" do
    @user.email = "Foo@ExAMPle.CoM"
    @user.save!
    expect(@user.reload.email).to eq "foo@example.com"
  end
  it "passwordが空白になっていないか" do
    @user.password = @user.password_confirmation = "a" * 6
    expect(@user).to be_valid
    @user.password = @user.password_confirmation = " " * 6
    expect(@user).to_not be_valid
  end

  describe "password length" do

    context "パスワードが６桁の時" do
      it "正しい" do
        @user = FactoryBot.build(:user, password: "a" * 6,password_confirmation: "a" * 6)
        expect(@user).to be_valid
      end
    end

    context "パスワードが５桁の時" do
      it "正しくない" do
        @user = FactoryBot.build(:user, password: "a" *5, password_confirmation: "a" * 5)
        expect(@user).to be_invalid
      end
    end
  end
end
