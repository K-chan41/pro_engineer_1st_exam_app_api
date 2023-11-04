require 'csv'

# Subjects
csv_text = File.read(Rails.root.join('db', 'csv_data', 'subjects.csv'))
csv = CSV.parse(csv_text, headers: true, encoding: 'UTF-8')
csv.each do |row|
  Subject.create!({
    year: row['year'].to_i,
    exam_subject: row['exam_subject'].to_i
  })
end
puts "Imported #{csv.size} rows to Subjects"

# Labels
csv_text = File.read(Rails.root.join('db', 'csv_data', 'labels.csv'))
csv = CSV.parse(csv_text, headers: true, encoding: 'UTF-8')
csv.each do |row|
  Label.create!({
    number: row['number'].to_i,
    title: row['title']
  })
end
puts "Imported #{csv.size} rows to Labels"

# Questions
csv_text = File.read(Rails.root.join('db', 'csv_data', 'questions.csv'))
csv = CSV.parse(csv_text, headers: true, encoding: 'UTF-8')
csv.each do |row|
  # SubjectとLabelを検索
  subject = Subject.find(row['subject_id'].to_i)
  label = Label.find_by(id: row['label_id'].to_i)
  Question.create!({
    subject_id: subject.id,
    label_id: label&.id,
    number: row['number'].to_i,
    content: row['content'],
    question_img_src: row['question_img_src'],
    correct_answer_no: row['correct_answer_no'].to_i,
    commentary: row['commentary'],
    answer_img_src: row['answer_img_src']
  })
end
puts "Imported #{csv.size} rows to Questions"

# Choices
csv_text = File.read(Rails.root.join('db', 'csv_data', 'choices.csv'))
csv = CSV.parse(csv_text, headers: true, encoding: 'UTF-8')
csv.each do |row|
  # Questionを検索
  question = Question.find_by(id: row['question_id'].to_i)
  Choice.create!({
    question_id: question.id,
    content: row['content'],
    order: row['order'].to_i
  })
end
puts "Imported #{csv.size} rows to Choices"
