class ChangeInvoice < ActiveRecord::Migration
  def self.up
    change_table :invoices do |t|
#      t.remove :description, :name
      t.boolean :has_descuento_10
      t.boolean :has_descuento_20
      t.float :iva_percent
      t.index :iva_percent
#      t.rename :upccode, :upc_code
    end  
  end

  def self.down
    change_table :invoices do |t|
      t.remove :has_descuento_10,:has_descuento_20,:iva_percent
    end  
  end
end
