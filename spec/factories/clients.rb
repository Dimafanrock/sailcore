FactoryBot.define do
  factory :client, parent: :user, class: 'Client' do
    nickname { Faker::Name.name }
  end
end
