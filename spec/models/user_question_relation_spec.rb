require 'rails_helper'

RSpec.describe UserQuestionRelation, type: :model do
  # 必要なデータを作成するためのFactoryBotの定義
  let(:user) { FactoryBot.create(:user) }
  let(:question) { FactoryBot.create(:question) }

  describe 'バリデーションのテスト' do
    it 'userとquestion、answerを与えると有効' do
      relation = UserQuestionRelation.new(user: user, question: question, answer: 1)
      expect(relation).to be_valid
    end

    it 'userがないと無効' do
      relation = UserQuestionRelation.new(user: nil, question: question, answer: 1)
      expect(relation).not_to be_valid
      expect(relation.errors[:user]).to include("must exist")
    end

    it 'questionがないと無効' do
      relation = UserQuestionRelation.new(user: user, question: nil, answer: 1)
      expect(relation).not_to be_valid
      expect(relation.errors[:question]).to include("must exist")
    end

    it 'answerがないと無効' do
      relation = UserQuestionRelation.new(user: user, question: question, answer: nil)
      expect(relation).not_to be_valid
      expect(relation.errors[:answer]).to include("can't be blank")
    end
  end

  describe '関連付け' do
    it 'userに関連付いている' do
      assoc = UserQuestionRelation.reflect_on_association(:user)
      expect(assoc.macro).to eq :belongs_to
    end

    it 'questionに関連付いている' do
      assoc = UserQuestionRelation.reflect_on_association(:question)
      expect(assoc.macro).to eq :belongs_to
    end
  end
end
