class ApiController < ApplicationController
    before_action :authenticate_user!

    def test
        render json: {"message": "ok"}, status: 200
    end
end