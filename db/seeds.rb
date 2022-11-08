User.create!(name: "test", email: "test@test.com", password: "testtest", password_confirmation: "testtest" )
User.all.each do |user|
    Task.create!(
     user_id: user.id,
     name: "title",
     content: "test",
     status: "着手中",
     priority: "低い"
     end_date: "2022/11/30" )
   end