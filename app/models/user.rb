include Devise::JWT::RevocationStrategies::Denylist
class User < ApplicationRecord
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable ,:jwt_authenticatable,
   jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Denylist
end
