RSpec.shared_examples 'an authenticatable user authentication' do
  describe 'Authentication' do
    let(:existing_user) { create(described_class.name.underscore.to_sym, password: 'Password@123!') }

    it 'authenticates with a valid password' do
      expect(existing_user.valid_password?('Password@123!')).to be true
    end

    it 'fails authentication with an incorrect password' do
      expect(existing_user.valid_password?('WrongPassword')).to be false
    end
  end
end
