class Question < ApplicationRecord
  belongs_to :subject
  belongs_to :label
end
