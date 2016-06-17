class CowsayController < ApplicationController
    def index
    end

    def create
        # render text: params
        @cowsay_string = Cowsay.say params[:sentence]
        
    end
end
