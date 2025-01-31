require 'rails_helper'

RSpec.describe Admin, type: :model do
  subject(:admin) { build(:admin) }

  it_behaves_like 'an authenticatable user validation'
  it_behaves_like 'an authenticatable user authentication'
  it_behaves_like 'an authenticatable user image uploader'

  describe 'Additional Admin Validations' do
    it 'validates presence of email' do
      admin.email = nil
      expect(admin).not_to be_valid
      expect(admin.errors[:email]).to include("can't be blank")
    end
  end
end
