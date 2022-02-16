# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_answer, only: %i[update destroy]

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.create(answer_params.merge(author: current_user))
  end

  def update
    # if current_user.author_of?(@answer)
    #   if @answer.update(answer_params)
    #     flash[:success] = 'Answer was updated!'
    #   else
    #     flash[:danger] = 'Invalid input!'
    #   end
    # else
    #   flash[:danger] = 'You are not allowed to do this!'
    # end
    #
    # render 'questions/show'
    @answer.update(answer_params)
    @question = @answer.question
  end

  def destroy
    if current_user.author_of?(@answer)
      @answer.destroy
      flash[:success] = 'Answer was destroyed!'
    else
      flash[:danger] = 'You are not allowed to do this!'
    end
    redirect_to @answer.question
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def find_answer
    @answer = Answer.find(params[:id])
  end
end
