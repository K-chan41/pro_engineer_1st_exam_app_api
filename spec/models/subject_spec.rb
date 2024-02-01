require 'rails_helper'

describe Subject do
  it "subject-factoryが有効であること" do
    expect(FactoryBot.build(:subject)).to be_valid
  end

  describe '関連付け' do
    it 'questionに関連付いている' do
      assoc = Subject.reflect_on_association(:questions)
      expect(assoc.macro).to eq :has_many
    end
  end
end
