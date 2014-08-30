require 'rails_helper'

RSpec.describe User, :type => :model do
  before :each do
    User.destroy_all
  end

  it 'should not store an unecrypted password'
end
