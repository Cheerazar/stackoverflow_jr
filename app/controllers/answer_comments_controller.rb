class AnswerCommentsController < ApplicationController

  def create
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:answer_id])
    @answer_comment = AnswerComment.new(answer_comments_params)
    @user = User.find(session[:user])
    @answer.comments << @answer_comment
    @user.comments << @answer_comment
    if @answer_comment.save
      redirect_to question_path(@question)
    else
      render "questions/show"
    end
  end

  # def question
  #   @question = Question.find(params[:question_id])
  #   @comment = Comment.new(comment_params)
  #   @user = User.find(session[:user])
  #   @question.comments << @comment
  #   @user.comments << @comment
  #   if @comment.save
  #     redirect_to question_path(@question)
  #   else
  #     render "questions/show"
  #   end
  # end

   def destroy
    comment=AnswerComment.find params[:id]
    comment.destroy
  end

  private

  def answer_comments_params
    params.require(:comment).permit(:body)
  end



end
