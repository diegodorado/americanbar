class AddSubtotalToInvoice < ActiveRecord::Migration
  def self.up
    add_column :invoices, :subtotal, :float
#    execute <<-SQL
#            UPDATE invoices i 
#            SET i.subtotal = 0
#        SQL
#    execute <<-SQL
#            UPDATE invoices i 
#            INNER JOIN (SELECT invoice_id i, sum(total) t FROM invoice_products ip GROUP BY i ) ipt 
#            ON i.id=ipt.i 
#            SET i.subtotal = ipt.t    
#        SQL
  end

  def self.down
    remove_column :invoices, :subtotal
  end
end
