require 'rails_helper'

RSpec.describe User, type: :model do
  # subject { build(:user) }
  # before { @user = FactoryBot.build(:user)}
  let(:user) { build(:user) }

  it { is_expected.to validate_presence_of(:name)}

  # it { expect(user).to respond_to(:email)}

  # context 'when name is blank' do
  #   before { user.name = '' }

  #   it { expect(user).not_to be_valid }
  # end

  # context 'when name is nil' do
  #   before { user.name = nil }

  #   it { expect(user).not_to be_valid}
  # end

  # it { expect(subject).to respond_to(:email) }
  # it { expect(subject).to respond_to(:password) }
  # it { expect(subject).to respond_to(:password_confirmation) }
  # it { expect(subject).to be_valid }

  # it { is_expected.to respond_to(:email) }
  # it { is_expected.to respond_to(:password)}
  # it { is_expected.to respond_to(:password_confirmation)}
  # it { is_expected.to be_valid }

  # it { expect(@user).to be_valid}
  # it { expect(@user).to respond_to(:email) }
  # it { expect(@user).to respond_to(:password)}
  # it { expect(@suer).to respond_to(:password_confirmation)}
end
