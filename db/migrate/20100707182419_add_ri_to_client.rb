class AddRiToClient < ActiveRecord::Migration
  def self.up
    add_column :clients, :ri, :boolean
    execute <<-SQL
      UPDATE clients SET ri=true
    SQL
    
  end

  def self.down
    remove_column :clients, :ri
  end
end


