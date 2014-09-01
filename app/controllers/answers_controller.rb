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
    if session[:user] == @answer.user_id
      @answer = Answer.find(params[:id])
    else
      redirect_to question_path(@answer.question_id)
    end
  end

  def update
    @answer = Answer.find(params[:id])
    @question = Question.find(params[:question_id])
    if @answer.update_attributes(answer_params)
      redirect_to question_path(@question)
    else
      render "questions/show"
    end
  end

  def destroy
    answer=Answer.find params[:id]
    question = Question.find(answer.question_id)
    answer.destroy
    redirect_to question_path(question)
  end

  def upvote
    @answer = Answer.find params[:answer_id]
    @user = User.find params[:user_id]
    # @answer_vote = AnswerVote.find params[:id]

    if defined? AnswerVote.find(params[:id])
      @answer_vote = AnswerVote.find params[:id]
      if defined? @answer_vote.upvote == true
        return
      end
      @answer_vote.update_attributes(:downvote => false, :upvote => true)
    else
      @answer_vote = AnswerVote.create( :upvote => true )
    end
    @user.answer_votes << @answer_vote
    @answer.answer_votes << @answer_vote

  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

end
