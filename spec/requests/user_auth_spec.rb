# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Authentication', type: :request do
  it 'allows user to register' do
    params = { email: 'test123@example.com', password: 'password123' }
    post '/auth', params: params
    expect(response.status).to eq 200
  end

  context 'registered user' do
    let(:email) { 'test123@example.com' }
    let(:password) { 'password123' }
    let!(:registered_user) { User.create(email: email, password: password) }
    it 'returns auth token on valid sign-in' do
      params = { email: email, password: password }
      post '/auth/sign_in', params: params
      expect(response.headers['access-token']).to be_present
    end

    it 'does not return token on invalid sign-in' do
      params = { email: email, password: 'invalid' }
      post '/auth/sign_in', params: params
      expect(response.headers['access-token']).to_not be_present
    end
  end
end
