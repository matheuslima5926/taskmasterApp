require 'rails_helper'
RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:user) }
  context 'when name is blank' do
    before { user.name = " " }
    
    it { expect(user).to_not be_valid }
  end

  context 'when name is nil' do
    before { user.name = nil }
    
    it { expect(user).to_not be_valid }
  end

    # subject { FactoryBot.build(:user) }
  # before { @user = FactoryBot.build(:user) }
  # it { expect(@user).to respond_to(:email) }
  # it { expect(@user).to respond_to(:name) }
  # it { expect(@user).to respond_to(:password) }
  # it { expect(@user).to respond_to(:password_confirmation) }
  # it { expect(@user).to be_valid }
  # it { is_expected.to respond_to(:email) }

  #usando shoulda-matchers par reduzir quantidade de código

  context 'validate attributes with shoulda-matchres gem helpers' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to allow_value("gerenic_mail@gmail.com").for(:email) }
    it { is_expected.to validate_confirmation_of(:password) }
    it { is_expected.to validate_uniqueness_of(:auth_token).case_insensitive }

    describe '#info' do
      it 'returns email, created_at and a Token' do
        user.save!
        allow(Devise).to receive(:friendly_token).and_return('abc123456')
        expect(user.info).to eq("#{user.email} - #{user.created_at} - Token #{Devise.friendly_token}")
      end
    end

    describe '#generate_athentication_token!' do
      it 'generetes a unique auth token' do
        allow(Devise).to receive(:friendly_token).and_return('random_TOKEN')
        user.generate_authentication_token!
        expect(user.auth_token).to eq('random_TOKEN')
      end

      it 'generetes another token when current auth token already been created' do
        allow(Devise).to receive(:friendly_token).and_return('abc123455', 'abc123455', '2342token')
        existing_user = FactoryBot.create(:user, name: 'randomName')
        user.generate_authentication_token!
        expect(user.auth_token).not_to eq(existing_user.auth_token)
      end
    end
  end

end
