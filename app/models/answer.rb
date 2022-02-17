# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :question

  belongs_to :author, class_name: 'User'

  validates :body, presence: true

  def best?
    self == question.best_answer
  end
end
