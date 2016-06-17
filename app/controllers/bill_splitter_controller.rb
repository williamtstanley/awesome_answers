class BillSplitterController < ApplicationController
    def index
    end
    def split
        @bill_total = params[:bill_total].to_f
        @tip = params[:tip].to_i
        @tax = params[:tax].to_i
        @number_of_people = params[:number_of_people].to_i

        @output = '%.2f' % ((@bill_total * (1 + (@tip/100 + @tax/100))) / @number_of_people)

        render :index
    end
end

