require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  let!(:user) { create(:user) }
  let(:user_id) { user.id }
  let(:header) do
    {
      'Accept' => 'application/vnd.taskmanager.v1',
      'Content-Type' => Mime[:json].to_s
    }
  end

  before { host! 'api.taskmanager.dev' }

  describe 'GET users/:id' do
    before do
      get "/users/#{user_id}", params: {}, headers: headers
    end

    context 'when the user exists' do
      it 'returns the user' do
        expect(json_body[:id]).to eq(user_id)
      end

      it 'return status 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the user does not exist' do
      let(:user_id) { 10 }
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'POST /users' do
    before do
      post '/users/', params: { user: user_params, headers: headers }
    end

    context 'when the request params are valid' do
      let(:user_params) { attributes_for(:user) }

      it 'returns json data' do
        expect(json_body[:email]).to eq(user_params[:email])
      end

      it 'return status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request params are invalid' do
      let(:user_params) { attributes_for(:user, email: 'invalid_email@') }

      it 'returns status code 404' do
        expect(response).to have_http_status(422)
      end

      it 'returns json data errors' do
        expect(json_body).to have_key(:email)
      end
    end
  end

  describe 'PUT /users/:id' do
    before do
      put "/users/#{user.id}", params: { user: user_params }, headers: headers
    end

    context 'when the request params are valid' do
      let(:user_params) { { email: 'new@email.com' } }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the json data for the updated user' do
        expect(json_body[:email]).to eq(user_params[:email])
      end
    end

    context 'when the request params are invalid' do
      let(:user_params) { { email: 'invalid.email@', name: '' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns json data for the errors' do
        expect(json_body).to have_key(:email)
      end
    end
  end

  describe 'DELETE /users/:id' do
    before do
      delete "/users/#{user_id}", params: {}, headers: headers
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end

    it 'removes the user from database' do
      expect(User.find_by(id: user_id)).to eq(nil)
    end
  end
end

