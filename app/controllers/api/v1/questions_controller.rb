class Api::V1::QuestionsController < Api::BaseController


  def index
    @questions = Question.order(created_at: :DESC)
  end

  def show
    @question = Question.find params[:id]

    # if the format is JSON and we're using jbuilder as our templating system
    # what file will be rendered?
    # /views/api/v1/questions/show.json.jbuilder

# using `render` with `json: @question` will use the serializer for the question model
    # render json: @question
#using `render :show` or no render at all will ue the corresponding view for the specifed format (e.g. jbuilder for json)
  render :show
  end
  def create
      question_params = params.require(:question).permit(:title, :body)
      question = Question.new question_params
      question.user = @user

      if  question.save
        head :ok
      else
        render json: {error: question.errors.full_messages.join(', ')}
      end
    end





end
