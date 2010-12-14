class Client < ActiveRecord::Base
  has_many :invoices
  
  validates_uniqueness_of :name
  validates_uniqueness_of :cuit, :allow_blank => true
  validates_format_of :cuit, :with => /\A\d{2}-\d{8}-\d{1}\z/, :message => "formato invalido", :allow_blank => true

  def authorized_for_nested?
    self.invoices.count > 0
  end


#  before_create :direccion_remito

  private
    def direccion_remito
      self.remito_direccion = self.direccion unless self.remito_direccion
      self.remito_cp = self.cp unless self.remito_cp
      self.remito_localidad = self.localidad unless self.remito_localidad
      self.remito_provincia = self.provincia unless self.remito_provincia
    end


end
