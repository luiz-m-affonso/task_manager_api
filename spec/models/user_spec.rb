require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }
  let(:existing_user) { create(:user, auth_token: 'abc123xyztokenx')}

  it { is_expected.to validate_uniqueness_of(:email).case_insensitive}
  it { is_expected.to validate_confirmation_of(:password)}
  it { is_expected.to allow_value("luiz@gmail.com").for(:email)}
  it { is_expected.to validate_uniqueness_of(:auth_token)}

  before do
    allow(Devise).to receive(:friendly_token).and_return('JR_NGLzJ2JgZuvBBjMBg', 'abcXTZ123456', 'abcXTZ123456234sx')
  end

  describe "#info" do
    it 'returns email, created_at and token' do
      user.save!

      # Mock Devise.friendly_token - V.object to change other methods
      allow(Devise).to receive(:friendly_token).and_return('JR_NGLzJ2JgZuvBBjMBg')
      expect(user.info).to  eq("#{user.email} - #{user.created_at} - Token: JR_NGLzJ2JgZuvBBjMBg")
    end
  end

  # Changing object state
  describe "#generate_authentication_token!" do
    it 'generate a unique auth token' do
      allow(Devise).to receive(:friendly_token).and_return('JR_NGLzJ2JgZuvBBjMBg')
      user.generate_authentication_token!
      expect(user.auth_token).to eq('JR_NGLzJ2JgZuvBBjMBg')
    end

    it 'generate another auth token when the current auth token already exists' do
      user.generate_authentication_token!

      expect(user.auth_token).not_to eq(existing_user.auth_token)
    end
  end
end
