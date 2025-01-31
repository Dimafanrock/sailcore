RSpec.shared_examples 'an authenticatable user validation' do
  describe 'Validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to allow_value('test@example.com').for(:email) }
    it { is_expected.not_to allow_value('invalid_email').for(:email) }
  end

  describe 'Password security' do
    it 'requires a secure password' do
      subject.password = 'weak'
      expect(subject).not_to be_valid
      expect(subject.errors[:password]).to include(I18n.t('models.user.password_validation'))
    end
  end
end
