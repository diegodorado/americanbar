class AddTotalToInvoiceProduct < ActiveRecord::Migration
  def self.up
    add_column :invoice_products, :total, :float
    execute 'UPDATE invoice_products SET total = quantity * price'
  end

  def self.down
    remove_column :invoice_products, :total
  end
end
