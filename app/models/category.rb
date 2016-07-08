class Category < ActiveRecord::Base
    has_many :questions, dependent: :nullify
    validates :title, presence: true, uniqueness: true   
end
