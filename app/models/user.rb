class User < ApplicationRecord
  #
  # if you add an atrribute accessor to an ActiveRecord object then you will be able to capture that from the from and have it in memoery bu tit will not be stored in the dataabse i fyou dont have a databse field for it
  #
  #   attr_accessor :association_basics
  #   we dont have to do this for `password` and `password_confirmation` if we use `f.password_field` because Rails automatically adds attribute accessorss for these two special fields.

#has_secure_password is a built-in rails method tha thelps us with user authentication.

#1. it will automtically add a presence validator for the assword field
#2. when given a password it will generate a salt then it will has the salt and password combo and will store the result of the Hashing (using bcrypt) along with the randomly generated salt into a database field  called `password_field'`
#3. if you skp `password_confirmation` field then it wont give you a validation errors for that. if you provide `password_confirmation` then it will validate tha tthe password matches the password_confirmation
#4. we will get a method called `authentiate` that will help us test if the user has entered the correct password or not.

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: VALID_EMAIL_REGEX

  before_validation :downcase_email
  has_many :questions, dependent: :nullify
  private
  def downcase_email
    self.email.downcase! if email.present?
  end

end
