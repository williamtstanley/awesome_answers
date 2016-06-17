class TempController < ApplicationController
    def temp
    end
    def convert
        @temp = params[:temp]
        @type = params[:type]
        if @temp.to_i.to_s == @temp
            if @type == "celsius"
                @converted = @temp.to_f * 1.8 + 32
            else
                @converted = (@temp.to_f - 32) / 1.8
            end
        else
            @error = "PLEASE ENTER A NUMBER"
        end
        render :temp
    end
end
