require 'rails_helper'

describe Choice do
  it "choice-factoryが有効であること" do
    expect(FactoryBot.build(:choice)).to be_valid
  end
  
  describe '関連付け' do
    it 'questionに関連付いている' do
      assoc = Choice.reflect_on_association(:question)
      expect(assoc.macro).to eq :belongs_to
    end
  end
end
