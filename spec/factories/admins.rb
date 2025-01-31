FactoryBot.define do
  factory :admin, parent: :user, class: 'Admin' do
    email { Faker::Internet.email }
    password { 'Password@123!' }
    password_confirmation { 'Password@123!' }
    confirmed_at { Time.zone.now }
  end
end
