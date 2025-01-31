FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'Password@123!' }
    password_confirmation { 'Password@123!' }
    confirmed_at { Time.zone.now }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/images/avatar.png'), 'image/png') }
  end
end
