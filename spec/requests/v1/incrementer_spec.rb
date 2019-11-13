# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Incrementer', type: :request do
  let(:email) { 'test123@example.com' }
  let(:password) { 'password123' }
  let!(:user) { User.create(email: email, password: password) }
  let(:auth_header) { user.create_new_auth_token('test') }

  describe 'get current', json_api_headers: true do
    context 'valid access token' do
      describe 'incrementer value' do
        subject { JSON.parse(response.body)['data']['attributes']['incrementer'] }

        it 'returns current incrementer value' do
          user.incrementer = 2
          get '/v1/current', headers: auth_header
          expect(subject).to eq 2
        end
        it 'returns correct Content-Type' do
          get '/v1/current', headers: auth_header
          expect(response.content_type).to include 'application/vnd.api+json'
        end
        it 'returns ok status' do
          get '/v1/current', headers: auth_header
          expect(response.status).to eq 200
        end
      end
    end
    context 'invalid access token' do
      describe 'incrementer value' do
        it 'returns 401' do
          auth_header['access-token'] = 'invalid'
          get '/v1/current', headers: auth_header
          expect(response.status).to eq 401
        end
      end
    end
  end

  describe '#increment', json_api_headers: true do
    context 'valid access token' do
      describe 'incrementer value', json_api_headers: true do
        subject { JSON.parse(response.body)['data']['attributes']['incrementer'] }

        it 'increments and returns new incrementer value' do
          user.incrementer = 2
          patch '/v1/increment', headers: auth_header
          expect(subject).to eq 3
        end
        it 'increments and returns new incrementer value' do
          patch '/v1/increment', headers: auth_header
          expect(response.content_type).to include 'application/vnd.api+json'
        end
        it 'returns ok status' do
          patch '/v1/increment', headers: auth_header
          expect(response.status).to eq 200
        end
      end
    end
    context 'invalid access token' do
      describe 'incrementer value' do
        it 'returns 401' do
          auth_header['access-token'] = 'invalid'
          patch '/v1/increment', headers: auth_header
          expect(response.status).to eq 401
        end
      end
    end
  end

  describe 'set current', json_api_headers: true do
    context 'valid access token' do
      describe 'incrementer value', json_api_headers: true do
        it 'sets incrementer value' do
          params = { data: { type: 'User', id: user.id, attributes: { incrementer: 100 } } }
          patch '/v1/current', headers: auth_header, params: params, as: :json
          actual = JSON.parse(response.body)['data']['attributes']['incrementer']
          expect(actual).to eq 100
        end
        it 'sets incrementer value' do
          params = { data: { type: 'User', id: user.id, attributes: { incrementer: 100 } } }
          patch '/v1/current', headers: auth_header, params: params, as: :json
          expect(response.content_type).to include 'application/vnd.api+json'
        end
        it 'returns ok status' do
          params = { data: { type: 'User', id: user.id, attributes: { incrementer: 100 } } }
          patch '/v1/current', headers: auth_header, params: params, as: :json
          expect(response.status).to eq 200
        end
        it 'returns 422 if incrementer value invalid' do
          params = { data: { type: 'User', id: user.id, attributes: { incrementer: -1 } } }
          patch '/v1/current', headers: auth_header, params: params, as: :json
          expect(response.status).to eq 422
        end
        it 'returns error message if incrementer value invalid' do
          params = { data: { type: 'User', id: user.id, attributes: { incrementer: -1 } } }
          patch '/v1/current', headers: auth_header, params: params, as: :json
          expect(JSON.parse(response.body)['errors'].first['detail'])
            .to include 'incrementer: must be greater than or equal to 0'
        end
        it 'returns 401 if attempt to change incrementer for different user' do
          user1 = User.create(email: 'test@example.com', password: 'password123')
          params = { data: { type: 'User', id: user1.id, attributes: { incrementer: -1 } } }
          patch '/v1/current', headers: auth_header, params: params, as: :json
          expect(response.status).to eq 401
        end
      end
    end
    context 'invalid access token' do
      describe 'incrementer value' do
        it 'returns 401' do
          auth_header['access-token'] = 'invalid'
          patch '/v1/current', headers: auth_header
          expect(response.status).to eq 401
        end
      end
    end
  end

  describe 'unsupported media type' do
    describe '#current' do
      it 'returns unsupported_media_type (415) status' do
        get '/v1/current', headers: auth_header
        expect(response.status).to eq 415
      end
    end
    describe '#increment' do
      it 'returns unsupported_media_type (415) status' do
        patch '/v1/increment', headers: auth_header
        expect(response.status).to eq 415
      end
    end
    describe '#update' do
      it 'returns unsupported_media_type (415) status' do
        patch '/v1/current', headers: auth_header
        expect(response.status).to eq 415
      end
    end
  end
end
