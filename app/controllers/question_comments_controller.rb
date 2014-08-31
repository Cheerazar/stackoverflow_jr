class QuestionCommentsController < ApplicationController

  def create
    @question = Question.find(params[:question_id])
    @question_comment = QuestionComment.new(question_comments_params)
    @user = User.find(session[:user])
    @question.question_comments << @question_comment
    @user.question_comments << @question_comment
    if @question_comment.save
      redirect_to question_path(@question)
    else
      render "questions/show"
    end
  end

  def edit
    @question_comment = QuestionComment.find(params[:id])
    if session[:user] == @question_comment.user_id
      @question_comment = QuestionComment.find(params[:id])
    else
      redirect_to question_path(@question_comment.question_id)
    end
  end

  def update
    @question_comment = QuestionComment.find(params[:id])
    @question = Question.find(params[:question_id])
    if @question_comment.update_attributes(question_comments_params)
      redirect_to question_path(@question)
    else
      render "questions/show"
    end
  end

   def destroy
    comment=QuestionComment.find params[:id]
    comment.destroy
  end

  private

  def question_comments_params
    params.require(:question_comment).permit(:body)
  end



end
