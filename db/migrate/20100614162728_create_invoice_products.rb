class CreateInvoiceProducts < ActiveRecord::Migration
  def self.up
    create_table :invoice_products do |t|
      t.integer :quantity
      t.float :price
      t.references :invoice
      t.references :product

      t.timestamps
    end
  end

  def self.down
    drop_table :invoice_products
  end
end
