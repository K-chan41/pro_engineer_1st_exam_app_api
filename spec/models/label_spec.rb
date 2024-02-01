require 'rails_helper'

describe Label do
  it "subject-factoryが有効であること" do
    expect(FactoryBot.build(:label)).to be_valid
  end
  
  describe '関連付け' do
    it 'questionに関連付いている' do
      assoc = Label.reflect_on_association(:questions)
      expect(assoc.macro).to eq :has_many
    end
  end
end
