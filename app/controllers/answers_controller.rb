class AnswersController < ApplicationController

    def create
        @answer = Answer.new answer_params
        @question = Question.find params[:question_id]
        @answer.question = @question
        if @answer.save
            redirect_to question_path(@question), notice: "Answer created!"
        else
            render "questions/show"
        end
    end

    def destroy
        question = Question.find params[:question_id]
        answer = Answer.find params[:id]
        answer.destroy
        redirect_to question_path(question), notice: "Answer deleted"
    end


    private
    def answer_params
        params.require(:answer).permit(:body)
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
