require 'rails_helper'

RSpec.describe UserQuestionRelation, type: :model do
  it "factoryで作ったデータが正しいか確認" do
    user_question_relation = FactoryBot.create(:user_question_relation)
    puts "this relation is #{user_question_relation.user.inspect}"
    puts "this relation is #{user_question_relation.question.inspect}"
  end
end
