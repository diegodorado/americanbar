module Netzke::ModelExtensions
  class ClientForGridPanel < Client
    netzke_exclude_attributes :created_at, :updated_at
  end
end
