class User < ActiveRecord::Base
    #has_secure password will give us functionalities needed for user auth
    # 1 - it willadd attribute accessor: password, password_confirmation
    # 2 - it will add a validation for password presence and length of password(4-72)
    # 3 - if password confirmation is set it will validate that it is the same as password
    # 4 - it will add handy methods for us to automatically hash the password to the password_digest field
    # and compare a given password
    has_secure_password

    has_many :questions, dependent: :nullify

    validates :first_name, presence: true
    validates :last_name, presence: true

    VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    validates :email, format: VALID_EMAIL_REGEX, uniqueness: true



    scope :search, lambda {|s| where("first_name ILIKE :s OR last_name ILIKE :s OR email ILIKE :s", {s: "%#{s}%"})}

    scope :created_after, lambda {|date| where("created_at > ?", date)}

    def full_name
        "#{first_name} #{last_name}"
    end


end
