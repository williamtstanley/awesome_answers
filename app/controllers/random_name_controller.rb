class RandomNameController < ApplicationController
    def random
    end
    def randomize
        @names = params[:names]
        @result = params[:names].split(",").shuffle.pop.downcase.capitalize


        render :random
    end
end
