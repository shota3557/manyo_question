User.create!(name: "test54", email: "test54@test.com", password: "testtest", password_confirmation: "testtest", admin: true )
User.all.each do |user|
  Task.create!(user_id: user.id, name: "test", content: "test", status: "着手中", priority: "低い", end_date: "002022/11/30")
end

Label.create!(name: "test")
Label.create!(name: "example")