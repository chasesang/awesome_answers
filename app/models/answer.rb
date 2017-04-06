class Answer < ApplicationRecord
  belongs_to :question


#belongs_to :question addes the following instance methods to this model, Answer:

  # question
  # question=(associate)
  # build_question(attributes = {})
  # create_questionattributes = {})
  # create_question!(attributes = {})
 validates :body, presence: true
end
