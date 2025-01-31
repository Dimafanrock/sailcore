require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  it_behaves_like 'an authenticatable clients validation'
  it_behaves_like 'an authenticatable clients authentication'
  it_behaves_like 'an authenticatable clients image uploader'
end
