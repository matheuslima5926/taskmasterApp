# require 'rails_helper'
# RSpec.describe 'Api::V1::ApiController', type: :request do
#     let!(:user) { FactoryBot.create(:user) }
#     let(:authorization) { request.headers['Authorization']}
#     let(:headers) { 
#         {   'Authorization' => authorization,
#             'Content-Type' => 'application/json'
#         }
#     }
#     byebug
#     before do
#         body = {  "user": { "email": user.email, "password": user.password } }
#         post "/login", params: body, headers: {'Content-Type' => 'application/json'}
#         authorization = request.headers['Authorization']
#     end

#     describe 'GET /test' do
#         byebug
#         get '/test', headers: headers
#         it (expect(response).to have_http_status(200))
#     end

# end

require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
    let!(:user) { FactoryBot.create(:user) }
    let(:authorization) { response.headers['Authorization']}
    let(:headers) do
        {   'Authorization' => authorization,
            'Content-Type' => 'application/json'
        }
    end
    
    describe "GET /test" do
        context "when the users has been authenticated" do
            before do
                user_params = { user: { email: user.email, password: user.password } }
                post '/login', params: user_params
            end
            it "returns status 200" do
                get '/test', headers: headers
                expect(response).to have_http_status(200)
            end
            it "returns authenticated user email" do
                get '/test', headers: headers
                response_body = JSON.parse(response.body, symbolize_names: true)
                expect(response_body[:email]).to eql(user.email)
            end
        end
        context "when the users has not been authenticated" do
            it "returns status 401" do
                get '/test', headers: nil
                expect(response).to have_http_status(401)
            end
        end
    end
end
