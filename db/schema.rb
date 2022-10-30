ActiveRecord::Schema.define(version: 2022_10_27_123054) do

  enable_extension "plpgsql"

  create_table "tasks", force: :cascade do |t|
    t.string "name"
    t.text "content", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end
end
