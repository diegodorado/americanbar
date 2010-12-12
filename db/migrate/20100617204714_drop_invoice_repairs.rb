class DropInvoiceRepairs < ActiveRecord::Migration
  def self.up
    drop_table :invoice_repairs
  end

  def self.down
    create_table :invoice_repairs do |t|
      t.string :details
      t.float :price
      t.references :invoice

      t.timestamps
    end
  end
end
