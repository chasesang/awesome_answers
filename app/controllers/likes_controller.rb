class LikesController < ApplicationController
  def create
    question = Question.find(params[:question_id])
    like = Like.new(user: current_user, question: question)


    if like.save
      redirect_to question_path(question), notice: 'Question liked!'
    else
      redirect_to question_path(question), alert: like.errors.full_messages.join(', ')
    end
  end

  def destroy
    like = Like.find(params[:id])

    if like.destroy
      redirect_to question_path(like.question), notice: 'un-liked question'
    else
      redirect_to question_path(like.question), alert:
      like.errors.full_messages.join(', ')
    end
  end


end
