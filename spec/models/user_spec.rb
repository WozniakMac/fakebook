require 'rails_helper'

RSpec.describe User, type: :model do
  context 'when user is created from initializer' do
    it 'is valid' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'is invalid if provider is nil' do
      user = build(:user, provider: nil)
      expect(user).to be_invalid
    end

    it 'is invalid if uid is nil' do
      user = build(:user, uid: nil)
      expect(user).to be_invalid
    end

    it 'is invalid if first_name is nil' do
      user = build(:user, first_name: nil)
      expect(user).to be_invalid
    end

    it 'is invalid if last_name is nil' do
      user = build(:user, last_name: nil)
      expect(user).to be_invalid
    end

    it 'is invalid if email is invalid' do
      user = build(:user, email: 'invalid_email')
      expect(user).to be_invalid
    end
  end

  context 'when user is created from oauth' do
    let(:attrs) { attributes_for(:user) }

    let(:oauth_struct) do
      OpenStruct.new(
        provider: attrs[:provider],
        uid: attrs[:uid],
        info: OpenStruct.new(
          first_name: attrs[:first_name],
          last_name: attrs[:last_name],
          email: attrs[:email]
        )
      )
    end

    it 'create valid user' do
      user = User.find_or_create_from_omniauth(oauth_struct)

      expect(user).to be_valid
    end

    it 'update existing user if exists' do
      existing_user = create(:user, first_name: 'ExistingUser')

      expect { User.find_or_create_from_omniauth(oauth_struct) }
        .to change { User.first.first_name }
        .from(existing_user.first_name)
        .to(attrs[:first_name])
    end
  end
end
