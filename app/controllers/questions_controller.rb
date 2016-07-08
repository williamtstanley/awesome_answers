class QuestionsController < ApplicationController

    before_action :find_question, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, except: [:show, :index]
    before_action :authorize_owner, only: [:edit, :destroy]

    def index
        @questions = Question.order(created_at: :desc).page(params[:page]).per(params[:per] || 10)
        respond_to do |format|
          format.html
          format.json {render json: @questions}
        end
    end

    def new
        @question = Question.new
    end

    def create
        @question = Question.new question_params
        @question.user = current_user
        if @question.save
            flash[:notice] = "Question created successfully"
            redirect_to question_path(@question)
        else
            flash[:alert] = "Question not created"
            render :new
        end
    end

    def show
        @question.increment!(:view_count)
        @answer = Answer.new
        respond_to do |format|
          format.html
          format.json {render json:{question: @question, answers: @question.answers, user_name: @question.user.full_name}}
        end
    end


    def edit
    end

    def update
        @question.slug = nil
        if @question.update question_params
           redirect_to question_path(@question), notice: "Question updated"
        else
            render :edit
        end
    end

    def destroy
        @question.destroy
        redirect_to questions_path, notice: "Question deleted"
    end



    private

    def question_params
        params.require(:question).permit(:title, :body, :category_id, {tag_ids: []})
    end

    def find_question
      @question = Question.find params[:id]
    end

    def authorize_owner
        redirect_to root_path, alert: "access denied" unless can? :manage, @question
    end
    def current_user_vote
      @question.vote_for(current_user)
    end
    helper_method :current_user_vote

end
