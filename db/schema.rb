ActiveRecord::Schema.define(:version => 20130503203623) do
  create_table "articles", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end
end
