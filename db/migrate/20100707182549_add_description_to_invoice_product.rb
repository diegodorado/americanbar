class AddDescriptionToInvoiceProduct < ActiveRecord::Migration
  def self.up
    add_column :invoice_products, :description, :text
  end

  def self.down
    remove_column :invoice_products, :description
  end
end
