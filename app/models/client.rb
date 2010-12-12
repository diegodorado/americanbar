class Client < ActiveRecord::Base
  has_many :invoices
  
  validates_uniqueness_of :name
  validates_uniqueness_of :cuit, :allow_blank => true
  validates_format_of :cuit, :with => /\A\d{2}-\d{8}-\d{1}\z/, :message => "formato invalido", :allow_blank => true

  def authorized_for_nested?
    self.invoices.count > 0
  end

end
