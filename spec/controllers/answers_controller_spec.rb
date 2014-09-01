require 'rails_helper'

RSpec.describe AnswersController, :type => :controller do
  before :each do
    Answer.destroy_all
    session.clear
    @user = User.create(first_name:'Steven',last_name:'Harms',username:'steven',email:'steven@devbootcamp.com',password:'sharms')
    @question = Question.create(title:'Test Title',body:'Test body text here',user_id:@user.id)
    @answer = Answer.create(body:'Test answer body text',user_id:@user.id,question_id:@question.id)
    session[:user] = @user.id
  end

  context 'create' do
    it 'should redirect on successful answer creation' do
      post :create, answer: FactoryGirl.attributes_for(:answer), question_id:@question.id
      expect(response.status).to eq(302)
    end

    it 'should add an answer to the database' do
      expect{post :create, answer: {body:'Test answer body text 2'}, question_id:@question.id}.to change{Answer.count}.by(1)
    end

    it 'should not add an answer to the database without a body' do
      expect{post :create, answer: {body:''}, question_id:@question.id}.to_not change{Answer.count}
    end

    it 'should not add an answer to the database without a user' do
      session.clear
      expect{post :create, answer: {body:'Test answer body text 2'}, question_id:@question.id}.to raise_error
    end

    it 'should not add an answer to the database without a question id' do
      expect{post :create, answer: {body:'Test answer body text 2'}, question_id:nil}.to raise_error
    end
  end

  context 'edit' do
    it 'should show edit page' do
      get :edit, id:@answer.id, question_id:@question.id
      expect(response.status).to eq(200)
    end
  end

  context 'update' do
    it 'should update answer body' do
      put :update, answer: {body:'Test answer text change'}, id:@answer.id, question_id:@question.id
      expect(Answer.find(@answer.id).body).to eq('Test answer text change')
    end

    it 'should not update answer body if empty' do
      expect{put :update, answer: {body:''}, id:@answer.id, question_id:@question.id}.to_not change{Answer.find(@answer.id).body}
    end
  end

  context 'destroy' do
    it 'should remove answer from the database' do
      answer_id = @answer.id
      expect{delete :destroy, id:answer_id, question_id:@question.id}.to change{Answer.count}.by(-1)
      expect(Answer.exists?(answer_id)).to be(false)
    end
  end
end
