class QuestionsController < ApplicationController

before_action :authenticate_user!, except: [:show, :index]
# the `before_action` method registers another method in this case it's the `find_question method which will be executed just before the actions you specify in the `only` array. keep in mind that the method that gets executed as a `before_Action` happens whithin the same request/response cycle so if you defind an instance variable you can use it whithin the action / views

before_action :find_question, only: [:show, :edit, :update, :destroy]

  def new
    # we instaniate a new `Question` object because it will help us in
    # generating the form in `views/new.html.erb`. We have to make it an
    # instance variable so we can access it in the view file.
    @question = Question.new
  end

#
#   {
#   "utf8": "✓",
#   "authenticity_token": "lMy+UK6t9mCCxaMg+8Z9ez93C1d7TzxHD5DjR5CGG+yodGZpobOQpBZZBcZkkCg3qwbZMvmZJXiOqh37tcktSQ==",
#   "question": {
#     "title": "question1",
#     "body": "this is questions1"
#   },
#   "commit": "Create Question",
#   "controller": "questions",
#   "action": "create"
# }
def create
    # the line below is what's called "Strong Parameters" feautre that was added
    # to Rails starting with version 4 to help developer be more explicit about
    # the parameters that they want to allow the user to submit

    @question = Question.new question_params
    @question.user = current_user
    if @question.save
      RemindQuestionOwnerJob.set(wait:5.days).perform_later(@question.id)
      # redirect_to question_path({id: @question.id})
      # redirect_to question_path(@question.id)
      # Rails gives us access to `flash` object which looks like a Hash. flash
      # utilizes cookies to store a bit of information that we can access in the
      # next request. Flash will automatically be deleted when it's displayed.
      flash[:notice] = 'Question created!'


      redirect_to question_path(@question)
    else
      #render 'questions/new'

      # if you want to show a flash message when you're doing `render` instead
      # of `redirect` meaning that you want to show he flash message within the
      # same request/response cycle, then you will need to use flash.now
      flash[:alert] = 'Please fix errors below'
      render :new
      # render plain: "Eroors: #{question.errors.full_messages.join(', ')}"

    end
    # Rails.logger.info '>>>>>>>>>>>>>>>>>>>'
    # Rails.logger.info question.errors.full_messages
    # Rails.logger.info '>>>>>>>>>>>>>>>>>>>'
    # render json: params
  end



  #   {
  #   "controller": "questions",
  #   "action": "show",
  #   "id": "4"
  # }

  def show
    @answer = Answer.new
    #render 'questions/show'

    #'respond_to' method allows us to render differnt outcomes depending on the format of th erequests. remember that the defualt format for any request is Rails application is HTML.

    respond_to do |format|
      #the below means that if the format of the request is HTML. then we will render the `show` template (questions/show.html.erb)
      format.html {render :show}
      # this ð will render `json` if the format of the request is JSON.
    # ActiveRecord has a built-in feature to generate JSON from any object of
    # ActiveRecord.
    format.json  { render json: @question }
    end
  end

  def index
    @questions = Question.last(20)

  end


  def edit
    # can? is a helper thod that came from cancancan which helps us enforce permission rules in the controllers and views.
    redirect_to root_path, alert: 'access denited' unless can? :edit, @question
    #no neee to check if the user is signe in cuz the before action said the user has to be authentiated to reach edit stp
  end

  def update
      if !(can? :edit, @question)
        redirect_to root_path, alert: 'access denied'
      elsif @question.update(question_params.merge({ slug: nil }))
        redirect_to question_path(@question), notice: 'Question updated'
      else
        render :edit
      end
    end

  def destroy
    if can? :destroy, @question
     @question.destroy
     redirect_to questions_path, notice: 'Question delete'
   else
     redirect_to root_path, alert: 'Access denied'
   end
 end

   private

   def find_question
    @question = Question.find params[:id]
  end

  def question_params
    # the line below is what's called "Strong Parameters" feautre that was added
    # to Rails starting with version 4 to help developer be more explicit about
    # the parameters that they want to allow the user to submit
    params.require(:question).permit([:title, :body, { tag_ids: [] } ])
  end


end
