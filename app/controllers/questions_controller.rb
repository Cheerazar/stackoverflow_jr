class QuestionsController < ActionController

  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(:title => params[:title], :body => params[:body])
    @user = User.find(session[:user])
    @user.question << @question
    if @question.save
      redirect_to question_path(@question)  #user/:id/question/:id
      ## if every question is unique, then the path can be questions/:id, this would be a show controller method
    else
      render :new
    end
  end

   def destroy
    question=Question.find params[:id]
    question.destroy
  end


  private

  def question_params
    params.require(:question).permit(:title, :body)
  end







end
