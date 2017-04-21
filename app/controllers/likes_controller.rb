class LikesController < ApplicationController
  before_action :authenticate_user!

  def index
    user = User.find(params[:user_id])
    @questions = user.liked_question

    render 'questions/index'
  end





  def create

    question = Question.find(params[:question_id])
    if cannot? :like, question
      redirect_to(
      question_path(question),
      alert: 'can not like your own question'
      )
      return #early return to prevent execution of anything after the redirect above
    end

    like = Like.new(user: current_user, question: question)


    if like.save
      redirect_to question_path(question), notice: 'Question liked!'
    else
      redirect_to question_path(question), alert: like.errors.full_messages.join(', ')
    end
  end

  def destroy
    like = Like.find(params[:id])
    if cannot? :like, like.question
      redirect_to(
      question_path(like.question),
      alert: 'can not like your own question'
      )
      return #early return to prevent execution of anything after the redirect above
    end

    if like.destroy
      redirect_to question_path(like.question), notice: 'un-liked question'
    else
      redirect_to question_path(like.question), alert:
      like.errors.full_messages.join(', ')
    end
  end


end
