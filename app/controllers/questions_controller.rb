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

  def upvote
    @question = Question.find params[:question_id]
    @user = User.find params[:user_id]
    previous_vote = @user.question_votes.where(:question_id => @question.id, user_id: @user.id).first
    if previous_vote == nil
      @question_vote = QuestionVote.create( :upvote => true )
    else
      QuestionVote.find(previous_vote.id).destroy
      @question_vote = QuestionVote.create( :upvote => true, :downvote => false )
    end
    @user.question_votes << @question_vote
    @question.question_votes << @question_vote
    redirect_to question_path(@question)
  end

  def downvote
    @question = Question.find params[:question_id]
    @user = User.find params[:user_id]
    previous_vote = @user.question_votes.where(:question_id => @question.id, user_id: @user.id).first
    if previous_vote == nil
      @question_vote = QuestionVote.create( :downvote => true )
    else
      QuestionVote.find(previous_vote.id).destroy
      @question_vote = QuestionVote.create( :upvote =>  false, :downvote => true )
    end
    @user.question_votes << @question_vote
    @question.question_votes << @question_vote
    redirect_to question_path(@question)
  end


  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

end
