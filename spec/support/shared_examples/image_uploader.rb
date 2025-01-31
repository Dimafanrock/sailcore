RSpec.shared_examples 'an authenticatable clients image uploader' do
  describe 'ImageUploader' do
    let(:secure_password) { User.generate_secure_password }
    let(:existing_user) { create(described_class.name.underscore.to_sym, password: secure_password, password_confirmation: secure_password) }

    context 'when uploading a valid image' do
      it 'is valid with a valid image' do
        existing_user.image = Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/images/avatar.png'), 'image/png')
        expect(existing_user.image).to be_present
        expect(existing_user).to be_valid
      end
    end

    context 'when no image is uploaded' do
      it 'is valid without an image' do
        existing_user.image = nil
        expect(existing_user).to be_valid
      end
    end
  end
end
