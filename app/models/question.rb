class Question < ActiveRecord::Base
    # has_many helps set up the assosiation between the two models. In this case "has_many" assumes that the answers table
    # contains a field named "question_id" that is an integer. (this is a Rails convention)

    # the dependent option takes values like 'destroy' and 'nullify'. Destroy will make rails automatically delete associated
    # answers before deleting the question, nullify will make rails turn the 'question_id' values to NULL before deleting the
    # question
    has_many :answers, dependent: :destroy
    belongs_to :category
    belongs_to :user


    validates(:title, {presence: {message: "Need a title dumbass!"}, uniqueness: true})

    validates :body, presence: true,
                    length: {minimum: 7},
                    uniqueness: {scope: :title}

    validates :view_count, numericality: {greater_than_or_equal_to: 0}

    # VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    # validates :email,

    validate :no_monkey

    validate :no_title_in_body

    after_initialize :set_defaults

    before_validation :squeezer

    #saved queries
    #recent questions
    scope :recent, lambda {|count| where("created_at > ?", 3.day.ago).limit(count)}

    #search
    scope :search, -> (word) {where("title ILIKE :word OR body ILIKE :word", {word: "%#{word}%"})}

    # scope :hit_count, -> {increment(:hit_count, 1}

    # def self.recent(count)
    #     where("created_at > ?", 3.day.ago).limit(count)
    # end

    # scope :new_first_answers, -> {answers.order(created_at: :desc)}
    def new_first_answers
        answers.order(created_at: :desc)
    end

    private

    def set_defaults
        self.view_count ||= 0
    end


    def squeezer
        if title
            self.title = title.squeeze(" ")
            self.body = body.squeeze(" ")
        end
    end

    def no_monkey
        if title && title.downcase.include?("monkey")
            errors.add(:title, "No monkey please!")
        end
    end

    def no_title_in_body
        if title && body && body.downcase.include?(title.downcase)
            errors.add(:body, "Please don't include your title in the body text!")
        end
    end

end
