# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name 'Test User'
    email 'example@example.com'
    password 'changeme'
    password_confirmation 'changeme'
    # required if the Devise Confirmable module is used
    # confirmed_at Time.now
    factory :admin do
      after(:create) do |user|
        admin_role = Role.find_or_create_by name: "admin"
        user.roles = [admin_role]
      end
    end
  end
end
