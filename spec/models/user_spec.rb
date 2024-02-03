require 'rails_helper'

describe User do
  # 有効なファクトリを持つこと
  it "user-factoryが有効であること" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it "nameが存在しない場合、無効" do
    user = FactoryBot.build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end

  it "emailが存在しない場合、無効" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end  

  it "重複したメールアドレスは無効" do
    FactoryBot.create(:user, email: "tester@example.com")
    user = FactoryBot.build(:user, email: "tester@example.com")
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end

  describe '関連付け' do
    it 'user_quesion_relationsに関連付いている' do
      assoc = User.reflect_on_association(:user_question_relations)
      expect(assoc.macro).to eq :has_many
    end

    it 'flagsに関連付いている' do
      assoc = User.reflect_on_association(:flags)
      expect(assoc.macro).to eq :has_many
    end
  end
end
