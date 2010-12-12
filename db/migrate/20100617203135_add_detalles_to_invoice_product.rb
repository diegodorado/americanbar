class AddDetallesToInvoiceProduct < ActiveRecord::Migration
  def self.up
    add_column :invoice_products, :detalles, :text
  end

  def self.down
    remove_column :invoice_products, :detalles
  end
end
