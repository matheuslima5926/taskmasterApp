require 'rails_helper'

RSpec.describe Project, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
  end
  describe "valid attributes" do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:user_id)}
  end
end
