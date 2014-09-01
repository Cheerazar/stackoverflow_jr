Rails.application.routes.draw do

  root 'questions#index'

  get 'questions/index' => 'questions#index', as: :all_questions

  get 'questions/new' => 'questions#new', as: :new_question

  post 'questions/create' => 'questions#create', as: :questions

  get 'questions/:id' => 'questions#show', as: :question

  delete 'questions/:id' => 'questions#destroy'

  get 'questions/:id/edit' => 'questions#edit', as: :edit_question

  patch 'questions/:id' => 'questions#update'

  post 'questions/:question_id/answers/create' => 'answers#create', as: :answer_create

  get 'questions/:question_id/answers/:id/edit' => 'answers#edit', as: :edit_answer

  put 'questions/:question_id/answers/:id' => 'answers#update', as: :update_answer

  delete 'questions/:question_id/answers/:id' => 'answers#destroy', as: :delete_answer

  post 'questions/:question_id/answers/:answer_id/answer_comments/create' => 'answer_comments#create', as: :answer_comment_create

  get 'questions/:question_id/answers/:answer_id/answer_comments/:id/edit' => 'answer_comments#edit', as: :edit_answer_comment

  put 'questions/:question_id/answers/:answer_id/answer_comments/:id' => 'answer_comments#update', as: :update_answer_comment

  post 'questions/:question_id/question_comments/create' => 'question_comments#create', as: :question_comment_create

  get 'questions/:question_id/question_comments/:id/edit' => 'question_comments#edit', as: :edit_question_comment

  put 'questions/:question_id/question_comments/:id' => 'question_comments#update', as: :update_question_comment

  delete 'questions/:question_id/comments/:id' => 'comments#destroy'

  get 'users/login' => 'users#login', as: :login

  post 'users/signin' => 'users#signin'

  get 'users/signout' => 'users#signout', as: :signout

  get 'users/new' => 'users#new', as: :new_user

  post 'users/create' => 'users#create', as: :users

  get 'users/:id/edit' => 'users#edit', as: :edit_user

  put 'users/:id' => 'users#update'

  get 'users/:id' => 'users#show', as: :user

  get 'users' => 'users#index', as: :all_users

  delete 'users/:id' => 'users#destroy'

  post "users/:user_id/answers/:answer_id/answer_votes/upvote" => 'answers#upvote', as: :answer_upvote_create

  post "users/:user_id/answers/:answer_id/answer_votes/downvote" => 'answers#downvote', as: :answer_downvote_create

  post "users/:user_id/questions/:question_id/question_votes/upvote" => 'questions#upvote', as: :question_upvote_create

  post "users/:user_id/questions/:question_id/question_votes/downvote" => 'questions#downvote', as: :question_downvote_create


  put "users/:user_id/answers/:answer_id/answer_votes/:id" => 'answer_votes#update', as: :update_answer_vote

end
