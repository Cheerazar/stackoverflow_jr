require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  before :each do
    User.destroy_all
  end

  context 'index' do
    it 'should show the index page' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  context 'create' do
    it 'should redirect for successful creation of user account' do
      post :create, user: FactoryGirl.attributes_for(:user)
      expect(response.status).to eq(302)
    end

    it 'should add exactly one user to the database' do
      expect{post :create, user: FactoryGirl.attributes_for(:user)}.to change{User.count}.by(1)
    end

    it 'should not allow multiple users with the same username'

    it 'should not add a user without a username' do
      expect{post :create, user: {first_name:'Steven',last_name:'Harms',email:'steven@devbootcamp.com',password:'sharms'}}.to_not change{User.count}
    end

    it 'should not add a user without a first name' do
      expect{post :create, user: {last_name:'Harms',username:'steven',email:'steven@devbootcamp.com',password:'sharms'}}.to_not change{User.count}
    end

    it 'should not add a user without a last name' do
      expect{post :create, user: {first_name:'Steven',username:'steven',email:'steven@devbootcamp.com',password:'sharms'}}.to_not change{User.count}
    end

    it 'should not add a user without an email' do
      expect{post :create, user: {first_name:'Steven',last_name:'Harms',username:'steven',password:'sharms'}}.to_not change{User.count}
    end

    it 'should not add a user with a short password'

    it 'should not add a user with a long password'
  end

  context 'update' do
    it 'should update password' do
      @user = User.create(first_name:'Steven',last_name:'Harms',username:'steven',email:'steven@devbootcamp.com',password:'sharms')
      expect{put :update, id:@user.id, password: 'blah'}.to change{@user.password_hash}
      expect(response.status).to eq(302)
    end
  end

  context 'show' do
    it 'should show user page' do
      @user = User.create(first_name:'Steven',last_name:'Harms',username:'steven',email:'steven@devbootcamp.com',password:'sharms')
      get :show, id:@user.id
      expect(response.status).to eq(200)
    end
  end

  context 'login' do
    it 'should show the login page' do
      get :login
      expect(response.status).to eq(200)
    end
  end

  context 'new' do
    it 'should show the new user page' do
      get :new
      expect(response.status).to eq(200)
    end
  end

  context 'edit' do
    it 'should show the edit page' do
      @user = User.create(first_name:'Steven',last_name:'Harms',username:'steven',email:'steven@devbootcamp.com',password:'sharms')
      session[:user] = @user.id
      get :edit, id:@user.id
      expect(response.status).to eq(200)
    end
  end

  context 'signin' do
    before :each do
      session.clear
      @user = User.create(first_name:'Steven',last_name:'Harms',username:'steven',email:'steven@devbootcamp.com',password:'sharms')
    end

    it 'should create a user session' do
      post :signin, {username:@user.username,password:'sharms'}
      expect(session[:user]).to_not be_nil
    end

    it 'should not create a session with wrong password' do
      post :signin, {username:@user.username,password:'password'}
      expect(session[:user]).to be_nil
    end

    it 'should not create a session with invalid username' do
      post :signin, {username:'kevin',password:'password'}
      expect(session[:user]).to be_nil
    end
  end

  context 'signout' do
    before :each do
      session.clear
      @user = User.create(first_name:'Steven',last_name:'Harms',username:'steven',email:'steven@devbootcamp.com',password:'sharms')
      post :signin, {username:@user.username,password:'sharms'}
    end

    it 'should redirect to home page' do
      get :signout
      expect(response.status).to eq(302)
    end

    it 'should end user session' do
      get :signout
      expect(session[:user]).to be_nil
    end
  end
end
