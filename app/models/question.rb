class Question < ApplicationRecord
  belongs_to :subject
  belongs_to :label, optional: true 
  has_many :choices
end
