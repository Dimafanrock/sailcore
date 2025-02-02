RSpec.shared_examples 'a user authentication system' do
  describe 'Authentication Methods' do
    let(:secure_password) { User.generate_secure_password }
    let(:user) { create(described_class.name.underscore.to_sym, password: secure_password, password_confirmation: secure_password) }

    describe '.generate_secure_password' do
      it 'generates a secure 24-character password' do
        password = User.generate_secure_password
        expect(password.length).to eq(24)
        expect(password).to match(/\A[a-zA-Z0-9]+\z/) # Ensure alphanumeric format
      end
    end

    describe '#valid_password?' do
      it 'authenticates with a valid password' do
        expect(user.valid_password?(secure_password)).to be true
      end

      it 'fails authentication with an incorrect password' do
        expect(user.valid_password?('WrongPassword')).to be false
      end
    end
  end
end
