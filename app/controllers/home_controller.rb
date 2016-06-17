class HomeController < ApplicationController
    #methods defined in controller are called actions
    def index
    end

    def about
    end

    def greet
        @name = params[:name]
    end

    def faq
    end


end
