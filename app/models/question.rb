class Question < ApplicationRecord
  belongs_to :subject
  belongs_to :label, optional: true 
  has_many :choices

  has_many :flags
  has_many :flagging_users, through: :flags, source: :user

  has_many :user_question_relations
  has_many :answering_users, through: :user_question_relations, source: :user
end
