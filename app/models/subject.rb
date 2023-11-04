class Subject < ApplicationRecord
  enum exam_subject: { basic_subject:0, aptitude_subject:1 }
  has_many :questions
end
