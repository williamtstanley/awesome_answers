class VotesController < ApplicationController


  def create
    @vote          = Vote.new(vote_params)
    @vote.user     = current_user
    @vote.question = current_question
    respond_to do |format|
      if @vote.save
        format.html {redirect_to current_question, notice: "Voted!"}
        format.js {render}
      else
        format.html {redirect_to current_question, alert: "An Error has occured!"}
        format.js {render :voting_failure}
      end
    end
  end

  def update
    @vote = Vote.find(params[:id])
    respond_to do |format|
      if @vote
        @vote.update(vote_params)
        format.html {redirect_to current_question, notice: "Vote changed!"}
        format.js {render}
      else
        format.html {redirect_to current_question}
        format.js {render}
      end
    end
  end


  def destroy
    @vote = Vote.find(params[:id])
    respond_to do |format|
      if @vote
        @vote.destroy
        format.html {redirect_to current_question, notice: "Vote removed"}
        format.js {render}
      else
        format.html {redirect_to current_question}
        format.js {render}
      end
    end
  end



  private
  def vote_params
    params.require(:vote).permit(:is_up)
  end
end
