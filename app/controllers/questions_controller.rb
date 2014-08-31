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
    if session[:user].nil?
      redirect_to root_path
    else
      @user = User.find(session[:user])
      @user.questions << @question
      if @question.save
        redirect_to question_path(@question)  #user/:id/question/:id
        ## if every question is unique, then the path can be questions/:id, this would be a show controller method
      else
        render :new
      end
    end
  end

  def destroy
    @question=Question.find params[:id]
    user = User.find(@question.user_id)
    @question.destroy
    @user
    redirect_to user_path(user)
  end

  def edit
    @question = Question.find(params[:id])
    if session[:user] == @question.user_id
      @question = Question.find(params[:id])
    else
      redirect_to question_path(@question)
    end
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
