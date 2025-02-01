RSpec.shared_examples 'a user role method' do
  let(:secure_password) { User.generate_secure_password }
  let(:user_factory) { described_class.name.underscore.to_sym }
  let(:existing_user) { create(user_factory, password: secure_password, password_confirmation: secure_password) }

  describe '#role' do
    it 'returns the lowercase version of the type' do
      existing_user.update!(type: 'Admin')
      expect(existing_user.role).to eq('admin')
    end

    it 'returns nil if type is not set' do
      existing_user.update!(type: nil)
      expect(existing_user.role).to be_nil
    end
  end
end
