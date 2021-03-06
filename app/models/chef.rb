class Chef < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,:confirmable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :recipes
  has_many :likes
  has_many :comments, dependent: :destroy
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { minimum: 3, maximum: 40 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {  maximum: 105}, 
                                  uniqueness: { case_sensitive: false },
                                  format: { with: VALID_EMAIL_REGEX }
                                  
end
