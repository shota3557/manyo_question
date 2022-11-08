FactoryBot.define do
  factory :user do
    name { 'テスト' }
    email { 'test@test.com' }
    password { 'testtest' }
    password_confirmation { 'testtest' }
  end 

  factory :second_user, class: User do
    name { 'テスト2' }
    email { 'test2@test.com' }
    password { 'testtest' }
    password_confirmation { 'testtest' }
  end 
end
