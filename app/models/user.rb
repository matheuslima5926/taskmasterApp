include Devise::JWT::RevocationStrategies::Denylist
class User < ApplicationRecord
  has_many :projects
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable ,:jwt_authenticatable,
   jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Denylist

   validates_presence_of :email, :password, :password_confirmation
   validates_uniqueness_of :email
   validates_confirmation_of :password, on: :create
end
