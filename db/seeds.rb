User.create!(name: "test3", email: "test3@test.com", password: "testtest", password_confirmation: "testtest", admin: true )
User.all.each do |user|
  Task.create!(user_id: user.id, name: "test", content: "test", status: "着手中", priority: "低い", end_date: "002022/11/30")
end