require 'spec_helper'

describe User do
  before do
    DatabaseCleaner.clean
  end
  it 'Creates admin and non-admin users' do
    admin = User.create!(
      email: 'admin@example.com',
      password: 'password1',
      password_confirmation: 'password1',
      admin: true
    )
    expect(User.last).to eq admin
    user = User.create!(
      email: 'user@example.com',
      password: 'password1',
      password_confirmation: 'password1',
      admin: false
    )
    expect(admin.admin?).to eq true
    expect(user.admin?).to eq false
  end

  it 'Only accepts valid email addresses' do
    user = User.new(
      email: 'user1@example,com',
      password: 'password1'
    )
    expect(user.valid?).to eq false
  end

  it 'Email cannot be blank' do
    user = User.new(
      email: '',
      password: 'password1'
    )
    expect(user.valid?).to eq false
  end

  it 'requires email to be unique' do
    user = User.create!(email: 'first_user@example.com', password: 'password1')
    user2 = User.new(email: 'first_user@example.com', password: 'password2')
    expect(user2.valid?).to eq false
  end

  it 'Only accepts valid password' do
    user = User.new(
      email: 'user1@example.com',
      password: 'password'
    )
    expect(user.valid?).to eq false
    expect(user.errors.full_messages).to eq ["Password must be at least 8-12 characters with 1 number"]
  end

  it 'Only accepts passwords with more than 7 characters' do
    user = User.new(
      email: 'user1@example.com',
      password: '1passwo',
      password_confirmation: '1passwo'
    )
    expect(user.valid?).to eq false
  end

  it 'Creates user with valid password and email' do
    user = User.new(
      email: 'user1@example.com',
      password: '1passwor',
    password_confirmation: '1passwor',
    )
    expect(user.valid?).to eq true
  end

  it 'Requires a password confirmation' do
    user = User.new(
      email: 'user1@example.com',
      password: '1password',
      password_confirmation: '',
    )
    expect(user.valid?).to eq false
    expect(user.errors.messages[:password_confirmation]).to eq ["Passwords do not match"]
  end
end


