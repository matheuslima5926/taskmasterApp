class ApiController < ApplicationController
    before_action :authenticate_user!

    def test
        render json: current_user, status: 200
    end
end