class QuestionsController < ApplicationController

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
    @question = Question.new(question_params)
    @user = User.find(session[:user])
    @user.questions << @question
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

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    @question.body = params[:body]
    @user = @question.user_id
     if @question.update(question_params)
      redirect_to user_path(@user)
     else
       redirect_to :edit_question
     end
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

end
