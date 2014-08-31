class AnswersController < ApplicationController



  def create
    @answer = Answer.new(answer_params)
    @user = User.find(session[:user])
    @question = Question.find(params[:question_id])
    @question.answers << @answer
    @user.answers << @answer
    if @answer.save
      #put them on the question page
      redirect_to question_path(@question)  #user/:id/question/:id
      ## if every question is unique, then the path can be questions/:id, this would be a show controller method
    else
      render "questions/show"  #put them on the question page,
    end
  end

  def edit
    @answer = Answer.find(params[:id])
    @question = Question.find(params[:question_id])
    if @answer.update_attribute :body, params[:body]
      redirect_to question_path(@question)
    else
      render "questions/show"
    end
  end

  def destroy
    answer=Answer.find params[:id]
    answer.destroy
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

end
