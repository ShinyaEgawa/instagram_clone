require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }

  describe User do
    it "有効なファクトリを持つこと" do
      expect(user).to be_valid
    end
  end

  # Shoulda Matchers を使用
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_length_of(:name).is_at_most(50) }
  it { is_expected.to validate_presence_of :email }
  #it { is_expected.to validate_uniqueness_of(:email).case_insensitive } ・・・(*)
  it { is_expected.to validate_length_of(:email).is_at_most(255) }
  it { is_expected.to validate_presence_of :password }
  it { is_expected.to validate_length_of(:password).is_at_least(6) }

  it "重複したメールアドレスなら無効な状態であること" do
    FactoryBot.create(:user, email: "aaron@example.com")
    user = FactoryBot.build(:user, email: "Aaron@example.com")
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end

  describe "メールアドレスの有効性" do
    it "無効なメールアドレスの場合" do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                            foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
        user.email = invalid_address
        expect(user).to_not be_valid
      end
    end

    it "有効なメールアドレスの場合" do
      valid_addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      valid_addresses.each do |valid_address|
        user.email = valid_address
        expect(user).to be_valid
      end
    end
  end

  describe "パスワード確認が一致すること" do
    it "一致する場合" do
      user = FactoryBot.build(:user, password: "password", password_confirmation: "password")
      expect(user).to be_valid
    end

    it "一致しない場合" do
      user = FactoryBot.build(:user, password: "password", password_confirmation: "different")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end
  end

=begin

  # 2つのバグのテスト,その2
  # こちらの記述ではエラーが発生するため、users_login_apiにて別方法で記述
  describe "ダイジェストが存在しない場合のauthenticated?のテスト" do
    it "remember_digestがない場合無効になるか" do
      expect(user.authenticated?(:remember, '')).to eq false
    end
  end

=end

end
