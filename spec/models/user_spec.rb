require 'rails_helper'

RSpec.describe User, :type => :model do
  before :each do
    User.destroy_all
  end

  it 'should not store an unecrypted password' do
    password = 'password'
    user = build(:user)
    user.password = password
    hash = user.password_hash
    expect(hash).should_not eq('password')
  end

end
