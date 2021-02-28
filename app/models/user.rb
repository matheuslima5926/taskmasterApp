class User < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :auth_token, case_sensitive: false
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  def info
    "#{email} - #{created_at} - Token #{Devise.friendly_token}"
  end
end
