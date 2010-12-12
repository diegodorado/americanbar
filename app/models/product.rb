class Product < ActiveRecord::Base
  has_many :invoices, :through => :invoice_products

  validates_uniqueness_of :name
  validates_numericality_of :price
end
