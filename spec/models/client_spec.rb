require 'rails_helper'
RSpec.describe Client, type: :model do
  subject(:client) { build(:client) }

  it_behaves_like 'an authenticatable user validation'
  it_behaves_like 'an authenticatable user authentication'
  it_behaves_like 'an authenticatable user image uploader'

  describe 'Additional Client Validations' do
    it 'validates presence of name' do
      client.name = nil
      expect(client).not_to be_valid
      expect(client.errors[:name]).to include("can't be blank")
    end

    it 'validates password format' do
      client.password = 'weakpassword'
      expect(client).not_to be_valid
      expect(client.errors[:password]).to include(I18n.t('models.user.password_validation'))
    end
  end
end
