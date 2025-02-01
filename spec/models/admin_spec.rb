require 'rails_helper'

RSpec.describe Admin, type: :model do
  subject(:admin) { build(:admin) }

  it_behaves_like 'an authenticatable clients validation'
  it_behaves_like 'an authenticatable clients authentication'
  it_behaves_like 'an authenticatable clients image uploader'
  it_behaves_like 'a user authentication system'
  it_behaves_like 'a user role method'
  it_behaves_like 'a user token methods'
end
