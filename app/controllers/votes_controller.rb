class VotesController < ApplicationController
  before_action :authenticate_user!
  #todo build and enfore permissions for the actions in this controller

  # {
  #   "_method": "post",
  #   "authenticity_token": "o3GBiNvaqF8G1lcCVrXSTsxDV2B4PB2QMUSaAozxGjmJS53tJYza5ET3dkmVUxLHe44Rnx+sXEouJ3ZujrpQPA==",
  #   "is_up": "true",
  #   "controller": "votes",
  #   "action": "create",
  #   "question_id": "182"
  # }


  def create
    question = Question.find params[:question_id]
    vote = Vote.new is_up: params[:is_up],
                    user: current_user,
                    question: question

    if vote.save
    # using `redirec_to question` is the same as doing:
    # redirec_to question_path(question)
    redirect_to question, notice: 'Voted!'
    else
    redirect_to question, alert: vote.errors.full_messages.join(',')
    end
  end


  def destroy
    vote = Vote.find(params[:id])
    if vote.destroy
      redirect_to question_path(vote.question), notice: 'un-voted quesiton'
    else
      redirect_to question_path(vote.question), alert:
      vote.errors.full_messages.join(', ')
    end
  end


  def update
    vote = Vote.find params[:id]
    vote.is_up = params[:is_up]
    if vote.save
      redirect_to vote.question, notice: 'Vote changed'
    else
      redirect_to vote.question, alert: vote.errors.full_messages.join(', ')
    end

  end




end
