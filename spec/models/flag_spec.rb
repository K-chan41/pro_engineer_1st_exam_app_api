require 'rails_helper'

RSpec.describe Flag, type: :model do
  it "flag-factoryが有効であること" do
    expect(FactoryBot.build(:flag)).to be_valid
  end

  describe '関連付け' do
    it 'userに関連付いている' do
      assoc = Flag.reflect_on_association(:user)
      expect(assoc.macro).to eq(:belongs_to)
    end

    it 'questionに関連付いている' do
      assoc = Flag.reflect_on_association(:question)
      expect(assoc.macro).to eq(:belongs_to)
    end
  end
end
