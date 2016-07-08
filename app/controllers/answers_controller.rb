class AnswersController < ApplicationController
    before_action :authorize_owner, only: [:edit, :destroy]

    def create
        @answer = Answer.new answer_params
        @question = Question.find params[:question_id]
        @answer.question = @question
        @answer.user = current_user

        respond_to do |format|
          if @answer.save
              AnswersMailer.notify_question_owner(@answer).deliver_later
              format.html {redirect_to question_path(@question), notice: "Answer created!"}
              # format.js {render js:i}
              format.js { render :create_success }
          else
            format.html {render "questions/show"}
            format.js { render :create_failure }
          end
        end
    end

    def destroy
        question = Question.find params[:question_id]
        @answer = Answer.find params[:id]
        @answer.destroy
        respond_to do |format|
          format.html {redirect_to question_path(question), notice: "Answer deleted"}
          # format.js {render :destroy_success}
          format.js {render} #render app/views/answers/destroy.js.erb
        end
    end


    private
    def answer_params
        params.require(:answer).permit(:body)
    end
    def authorize_owner
        redirect_to root_path, alert: "access denied" unless can? :manage, @answer
    end
end


# {
#   "utf8": "✓",
#   "authenticity_token": "JrkKFvOg86ZmISe7N4cQGLSgTSUF8r5twHNOJB3aRm8tK0zuJHyiV8WzAMmkvQ5qnXv2128G87V70aeic8zlag==",
#   "answer": {
#     "body": "this is an answer"
#   },
#   "commit": "Create Answer",
#   "controller": "answers",
#   "action": "create",
#   "question_id": "717"
# }
