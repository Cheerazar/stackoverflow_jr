class AnswerCommentsController < ApplicationController

  def create
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:answer_id])
    @answer_comment = AnswerComment.new(answer_comments_params)
    @user = User.find(session[:user])
    @answer.answer_comments << @answer_comment
    @user.answer_comments << @answer_comment
    if @answer_comment.save
      redirect_to question_path(@question)
    else
      render "questions/show"
    end
  end


  def edit
    @answer_comment = AnswerComment.find(params[:id])
    if session[:user] == @answer_comment.user_id
      @answer_comment = AnswerComment.find(params[:id])
    else
      redirect_to question_path(Answer.find(@answer_comment.answer_id).question_id)
    end
  end

  def update
    @answer_comment = AnswerComment.find(params[:id])
    @question = Question.find(params[:question_id])
    if @answer_comment.update_attributes(answer_comments_params)
      redirect_to question_path(@question)
    else
      render "questions/show"
    end
  end

   def destroy
    answer_vote=AnswerVote.find params[:id]
    answer_vote.destroy
  end

  private

  def answer_votes_params
    params.require(:answer_votes).permit(:upvote, :downvote)
  end



end
