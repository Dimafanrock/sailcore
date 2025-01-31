require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  it_behaves_like 'an authenticatable user validation'
  it_behaves_like 'an authenticatable user authentication'
  it_behaves_like 'an authenticatable user image uploader'
end
