require 'rails_helper'

describe Question do
  it "question-factoryが有効であること" do
    expect(FactoryBot.build(:question)).to be_valid
  end

  describe '関連付け' do
    it 'subjectに関連付いている' do
      assoc = Question.reflect_on_association(:subject)
      expect(assoc.macro).to eq :belongs_to
    end

    it 'choiceに関連付いている' do
      assoc = Question.reflect_on_association(:choices)
      expect(assoc.macro).to eq :has_many
    end

    it 'labelに関連付いている' do
      assoc = Question.reflect_on_association(:label)
      expect(assoc.macro).to eq :belongs_to
    end
  end
end
