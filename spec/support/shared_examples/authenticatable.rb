RSpec.shared_examples 'an authenticatable clients authentication' do
  describe 'Authentication' do
    let(:secure_password) { User.generate_secure_password }
    let(:existing_user) { create(described_class.name.underscore.to_sym, password: secure_password, password_confirmation: secure_password) }

    it 'authenticates with a valid password' do
      expect(existing_user.valid_password?(secure_password)).to be true
    end

    it 'fails authentication with an incorrect password' do
      expect(existing_user.valid_password?('WrongPassword')).to be false
    end
  end
end
