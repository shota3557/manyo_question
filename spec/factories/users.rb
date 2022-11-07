FactoryBot.define do
  factory :user do
    name { 'テスト' }
    email { 'test@test.com' }
    password { 'testtest' }
    password_confirmation { 'testtest' }
  end    
end
