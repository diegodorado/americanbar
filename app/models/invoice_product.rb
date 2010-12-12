class InvoiceProduct < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :product

  validates_presence_of :invoice_id
  validates_presence_of :product_id
  validates_numericality_of :quantity
  validates_numericality_of :price
  validates_numericality_of :total

  def lines
    description ? [description.split.size/10,description.size/50].max + 2 : 1
  end

  delegate :client_name, :to => :invoice, :allow_nil => true
  delegate :client,:date,:nro,:remito_nro, :to => :invoice, :allow_nil => true, :prefix => true
  delegate :name, :to => :product, :allow_nil => true, :prefix => true
  
end
