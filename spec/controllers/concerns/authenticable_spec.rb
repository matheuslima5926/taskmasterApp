require 'rails_helper'
RSpec.describe Authenticable do
    controller(ApplicationController) do
        include Authenticable
    end

    let(:app_controller) { subject }

    describe "#current_user" do
        let(:user) {FactoryBot.create(:user)}

        before do
            req = double(:headers => {'Authorization' => user.auth_token})
            allow(app_controller).to receive(:request).and_return(req)
        end

        it 'return user from authorization header' do
            expect(app_controller.current_user).to eq(user)
        end
    end
    
    describe "#authenticate_with_token!" do
        controller do
            before_action :authenticate_with_token!

            def restricted_action
            end
        end
        context "no user loged" do
            before do
                allow(app_controller).to receive(:current_user).and_return(nil)
                routes.draw { get 'restricted_action' => 'anonymous#restricted_action' }
                get :restricted_action
            end

            it 'returns unauthorized status code 401' do
                expect(response).to have_http_status(401)
            end

            it 'returns errors json' do
                json_body = JSON.parse(response.body, symbolize_names: true)
                expect(json_body).to have_key(:errors)
            end
        end
    end
end