class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.boolean :delta, :null => false, :default => true
      t.timestamps
    end

    add_index :articles, :delta
  end
end
