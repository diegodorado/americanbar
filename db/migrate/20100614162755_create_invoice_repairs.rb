class CreateInvoiceRepairs < ActiveRecord::Migration
  def self.up
    create_table :invoice_repairs do |t|
      t.string :details
      t.float :price
      t.references :invoice

      t.timestamps
    end
  end

  def self.down
    drop_table :invoice_repairs
  end
end
