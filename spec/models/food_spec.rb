require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @user = User.new(
      name: "Augusto",
      email: "augusto@dev.com",
      password: "123456",
      password_confirmation: "123456",
      confirmed_at: Time.now,
      role: "admin")
    @user.skip_confirmation!
    @user.save!
  end

  describe 'User Model Properties' do
    it 'name should be present' do
      @user.name = nil
      expect(@user).to_not be_valid
    end

    it 'email should be present' do
      @user.email = nil
      expect(@user).to_not be_valid
    end

    it 'password should be present' do
      @user.password = nil
      expect(@user).to_not be_valid
    end

    it 'name should be unique' do
      @duplicate_user = User.new(
        name: "Augusto",
        email: "augusto@gmail.com",
        password: "123456",
        password_confirmation: "123456",
        confirmed_at: Time.now,
        role: "admin")
      @duplicate_user.skip_confirmation!
      expect(@duplicate_user).to_not be_valid
    end
  end
end
