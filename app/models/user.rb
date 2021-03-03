class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates_presence_of :name
  validates_uniqueness_of :auth_token, case_sensitive: false
  before_create :generate_authentication_token!

  alias_method :authenticate, :valid_password?


  def self.from_token_request request
    email = request.params["auth"] && request.params["auth"]["email"]
    self.find_by email: email
  end

  def self.from_token_payload payload
    self.find payload["sub"]
  end

  def to_token_payload
    {sub: id}
  end
  
  def info
    "#{email} - #{created_at} - Token #{Devise.friendly_token}"
  end

  def generate_authentication_token!
    begin
      self.auth_token = Devise.friendly_token
    end while User.exists?(auth_token: self.auth_token)
  end
end
