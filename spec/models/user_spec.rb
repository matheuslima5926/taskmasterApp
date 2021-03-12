require 'rails_helper'

RSpec.describe User, type: :model do
    subject { FactoryBot.build(:user) }
    describe "has valid attributes" do
      it { should validate_presence_of(:email) }
      it { should validate_uniqueness_of(:email).case_insensitive }
      it { should validate_presence_of(:password) }
      it { should validate_confirmation_of(:password).on(:create) }
    end
end
