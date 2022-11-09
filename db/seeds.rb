User.create!(name: "test2", email: "test2@test.com", password: "testtest", password_confirmation: "testtest" )
User.all.each do |user|
  Task.create!(user_id: user.id, name: "test", content: "test", status: "着手中", priority: "低い", end_date: "002022/11/30")
end