ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS[:default]='%m/%d/%Y'

class Invoice < ActiveRecord::Base
  belongs_to :client
  has_many :invoice_products
  has_many :products, :through => :invoice_products

  validates_presence_of :date
  validates_presence_of :client_id
  validates_inclusion_of :iva_percent, :in => [10.5, 21]
  validates_uniqueness_of :nro, :allow_blank => true
  validates_uniqueness_of :remito_nro, :allow_blank => true


  delegate :name, :to => :client, :allow_nil => true, :prefix => true

  def name
    nro
  end

  def lines
    res = 0
    self.invoice_products.each do |ip|
      res = res + ip.lines
    end
    res
  end

  def condicion_iva
    self.client.ri ? 'RESP. INSCRIPTO' : 'RESP. NO INSCRIPTO'
  end
  
  def subtotal
    self[:subtotal].nil? ? 0 : self[:subtotal]
  end
  alias subtotal0 subtotal

  def descuento_10
    -self.subtotal * (self.has_descuento_10 ? 0.1 : 0)
  end

  def subtotal1
    self.subtotal +  self.descuento_10
  end

  def descuento_20
    -self.subtotal1 * (self.has_descuento_20 ? 0.2 : 0)
  end

  def subtotal2
    self.subtotal1 +  self.descuento_20
  end

  def iva_percent
    self[:iva_percent].nil? ? 0 : self[:iva_percent]
  end

  def iva
    self.subtotal2 * self.iva_percent/100
  end

  def total
    self.subtotal2 + self.iva
  end

  def total_to_s
    sprintf("%.2f", total)
  end
  
  
  def authorized_for_pdf?
    self.invoice_products.count > 0
  end
  
  
end
