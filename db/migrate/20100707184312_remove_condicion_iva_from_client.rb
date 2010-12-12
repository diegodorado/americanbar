class RemoveCondicionIvaFromClient < ActiveRecord::Migration
  def self.up
    remove_column :clients, :condicion_iva
  end

  def self.down
    add_column :clients, :condicion_iva, :string
  end
end
