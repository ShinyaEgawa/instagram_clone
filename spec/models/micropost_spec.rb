require 'rails_helper'

RSpec.describe Micropost, type: :model do
  let(:micropost) { FactoryBot.create(:micropost) }

  describe Micropost do
    it "有効なファクトリを持つこと" do
      expect(micropost).to be_valid
    end

    it "有効性のある名前であること" do
      user = FactoryBot.create(:user)
      user = FactoryBot.build(:user, name: " ")
      user.valid?
      expect(user).to_not be_valid
    end

    it "有効性のあるメールアドレスであること" do
      user = FactoryBot.create(:user)
      user = FactoryBot.build(:user, email: " ")
      user.valid?
      expect(user).to_not be_valid
    end

    it "有効性のあるコメントであること" do
      user = FactoryBot.create(:micropost)
      user = FactoryBot.build(:micropost, content: " ")
      user = FactoryBot.build(:micropost, content: "a" * 141)
      user.valid?
      expect(user).to_not be_valid
    end
  end
end
