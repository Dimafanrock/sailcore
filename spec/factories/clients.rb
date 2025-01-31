FactoryBot.define do
  factory :client, parent: :user, class: 'Client' do
    name { Faker::Name.name }
  end
end
