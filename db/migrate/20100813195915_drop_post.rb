class DropPost < ActiveRecord::Migration
  def self.up
    drop_table :posts
  end

  def self.down
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.boolean :published

      t.timestamps
    end
  end
end
