class CommentsController < ApplicationController

  def answer
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:answer_id])
    @comment = Comment.new(:body => params[:body])
    @user = User.find(session[:user])
    @answer.comments << @comment
    @user.comments << @comment
    if @comment.save
      redirect_to question_path(@question)
    else
      render "questions/show"
    end
  end

  def question
    @question = Question.find(params[:question_id])
    @comment = Comment.new(:body => params[:body])
    @user = User.find(session[:user])
    @question.comments << @comment
    @user.comments << @comment
    if @comment.save
      redirect_to question_path(@question)
    else
      render "questions/show"
    end
  end

   def destroy
    comment=Comment.find params[:id]
    comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end



end
