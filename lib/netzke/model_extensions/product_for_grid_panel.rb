module Netzke::ModelExtensions
  class ProductForGridPanel < Product
    netzke_exclude_attributes :created_at, :updated_at
    
  end
end
