class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :flags
  has_many :flagged_questions, through: :flags, source: :question
  has_many :user_question_relations
  has_many :answered_quesions, through: :user_question_relations, source: :question
  has_many :api_keys

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  def activate_api_key! # 追記
    return api_keys.active.first if api_keys.active.exists?

    api_keys.create
  end
end
