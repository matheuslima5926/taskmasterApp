require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
    let!(:user) { FactoryBot.create(:user) }
    let(:user_id) { user.id }
    let(:headers) do
        {'Content-Type' => Mime[:json].to_s }
    end

    describe "GET /users/:id" do
        before do
            headers = {"Accept" => "application/json"}
            get "/users/#{user_id}", headers: headers
        end

        context "when the users exists" do
            it "returns the user" do
                user_response = JSON.parse(response.body)
                expect(user_response["id"]).to eq(user_id)
            end

            it "returns status 200" do
                expect(response).to have_http_status(200)
            end
        end

        context "when the users doesn't exists" do
            let(:user_id) { -1 }
            it "return status code 404" do
                expect(response).to have_http_status(404)
            end
        end
    end

    describe 'POST /users' do

        before do
            post '/users', params: {user: user_params}.to_json, headers: headers
        end

        context 'when request params are valid' do
            let(:user_params) { FactoryBot.attributes_for(:user) }
            it 'returns status 201' do
                expect(response).to have_http_status(201)
            end
            it 'returns created user json' do
                user_response = JSON.parse(response.body)
                expect(user_response["email"]).to eq(user_params[:email])
            end
        end

        context 'when request params are invalid' do
            let(:user_params) { attributes_for(:user, email: 'invalid@')}
            it "return status code 422" do
                expect(response).to have_http_status(422)
            end
            
            it "returns JSON with data of the errors" do
                user_response = JSON.parse(response.body)
                expect(user_response).to have_key('errors')
            end
        end
    end

    describe 'PUT /users/:id' do
        before do
            put "/users/#{user_id}", params: {user: user_params}.to_json, headers: headers
        end
        
        context 'when the request params are valid' do
            let(:user_params) { {email: 'new@taskmaster.com'} }

            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end
            it 'returns updated user json data' do
                user_response = JSON.parse(response.body, symbolize_names: true)
                expect(user_response[:email]).to eq(user_params[:email])
            end
        end

        context 'when the request params are invalid' do
            let(:user_params) { {email: 'new@'} }

            it 'returns status code 422' do
                expect(response).to have_http_status(422)
            end
            it 'returns request errors' do
                user_response = JSON.parse(response.body, symbolize_names: true)
                expect(user_response).to have_key(:errors)
            end
        end
    end

    describe 'DELETE /users/:id' do
        before do
            delete "/users/#{user_id}", params: {}.to_json, headers: headers
        end

        it 'returns status code 204' do
            expect(response).to have_http_status(204)
        end

        it 'removes the user from database' do
            expect(User.find_by(id: user_id)).to be_nil
        end

    end
end
