class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :flags
  has_many :flagged_questions, through: :flags, source: :question

  has_many :user_question_relations
  has_many :answered_quesions, through: :user_question_relations, source: :question
end
