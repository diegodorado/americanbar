class CreateInvoices < ActiveRecord::Migration
  def self.up
    create_table :invoices do |t|
      t.date :date
      t.string :nro
      t.string :remito_nro
      t.text :details
      t.references :client
      t.timestamps
    end
  end

  def self.down
    drop_table :invoices
  end
end
