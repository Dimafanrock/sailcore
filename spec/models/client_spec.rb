require 'rails_helper'

RSpec.describe Client, type: :model do
  subject(:client) { build(:client) }

  it_behaves_like 'an authenticatable clients validation'
  it_behaves_like 'an authenticatable clients authentication'
  it_behaves_like 'an authenticatable clients image uploader'
end
