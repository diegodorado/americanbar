class AddCondicionVentaToInvoice < ActiveRecord::Migration
  def self.up
    add_column :invoices, :condicion_venta, :text
  end

  def self.down
    remove_column :invoices, :condicion_venta
  end
end
