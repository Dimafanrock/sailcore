FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "clients#{n}@example.com" }
    name { Faker::Name.name }
    password { User.generate_secure_password }
    password_confirmation { password }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/images/avatar.png'), 'image/png') if Rails.root.join('spec/fixtures/files/images/avatar.png').exist? }
  end
end
