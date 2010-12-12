class ChangeCondicionVentaFromInvoice < ActiveRecord::Migration
  def self.up
    change_table :invoices do |t|
      t.change :condicion_venta, :string
    end  
  end

  def self.down
    change_table :invoices do |t|
      t.change :condicion_venta, :text
    end  
  end
end
