class RemoveDetallesFromInvoiceProduct < ActiveRecord::Migration
  def self.up
    remove_column :invoice_products, :detalles
  end

  def self.down
    add_column :invoice_products, :detalles, :text
  end
end
