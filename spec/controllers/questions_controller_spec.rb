require 'rails_helper'

RSpec.describe QuestionsController, :type => :controller do
  before :each do
    Question.destroy_all
    session.clear
    @user = User.create(first_name:'Steven',last_name:'Harms',username:'steven',email:'steven@devbootcamp.com',password:'sharms')
    @question = Question.create(title:'Test Title',body:'Test body text here',user_id:@user.id)
  end

  context 'index' do
    it 'should show the index page' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  context 'show' do
    it 'should show the question page' do
      get :show, id:@question.id
      expect(response.status).to eq(200)
    end
  end

  context 'new' do
    it 'should show the new question page' do
      get :new
      expect(response.status).to eq(200)
    end
  end

  context 'create' do
    before :each do
      session[:user] = @user.id
    end

    it 'should redirect for successful creation of question' do
      post :create, question: FactoryGirl.attributes_for(:question), user_id:@user.id
      expect(response.status).to eq(302)
    end

    it 'should add a question to the database' do
      expect{post :create, question: {title:'Test Title 2', body:'Test body text 2'}, user_id:@user.id}.to change{Question.count}.by(1)
    end

    it 'should not add a question to the database without a title' do
      expect{post :create, question: {body:'Test body text 2'}, user_id:@user.id}.to_not change{Question.count}
    end

    it 'should not add a question to the database without a body' do
      expect{post :create, question: {title:'Test Title 2'}, user_id:@user.id}.to_not change{Question.count}
    end

    it 'should not add a question to the database without a user' do
      session.clear
      expect{post :create, question: FactoryGirl.attributes_for(:question)}.to_not change{Question.count}
    end

    it 'should add a question to user question list' do
      expect{post :create, question: {title:'Test Title 3', body:'Test body text 3'}, user_id:@user.id}.to change{@user.questions.count}.by(1)
      expect(@user.questions.last.title).to eq('Test Title 3')
    end
  end

  context 'destroy' do
    it 'should remove a question from database' do
      question_id = @question.id
      expect{delete :destroy, id:question_id}.to change{Question.count}.by(-1)
      expect(Question.exists?(question_id)).to be(false)
    end
  end

  context 'edit' do
    it 'should show the edit page' do
      session[:user] = @user.id
      get :edit, id:@question.id
      expect(response.status).to eq(200)
    end

    it 'should redirect without a session' do
      session.clear
      get :edit, id:@question.id
      expect(response.status).to eq(302)
    end
  end

  context 'update' do
    it 'should update the question body' do
      patch :update, question:{body:'Test body text change'},id:@question.id
      expect(Question.find(@question.id).body).to eq('Test body text change')
    end

    it 'should not update if new body is empty' do
      patch :update, question:{body:''},id:@question.id
      expect(Question.find(@question.id).body).to_not eq('')
    end
  end
end
