class ClientsController < ApplicationController
  layout "crud"
  active_scaffold :clients do | config |
    
    config.list.columns = [:name, :nombre_fantasia, :cuit,   :direccion, :cp,:localidad,:provincia, :email, :tel_fax]
    config.show.link = false
#    config.nested.add_link("Facturas", [:invoices])
 
    list.sorting = {:name => 'ASC'}

    config.actions.swap :search, :field_search
    config.field_search.columns =[:name, :nombre_fantasia, :cuit,:localidad,:provincia]

    config.columns.exclude :invoices

    config.update.columns.exclude :invoices
    config.update.columns.add_subgroup "Datos Principales" do |g|
      g.add :name, :nombre_fantasia, :cuit, :condicion_venta,:descuento10, :descuento20, :ri
    end
    config.update.columns.add_subgroup "Direccion" do |g|
      g.add :direccion, :cp,:localidad,:provincia
    end
    config.update.columns.add_subgroup "Direccion Remito" do |g|
      g.add :remito_direccion, :remito_cp,:remito_localidad,:remito_provincia
    end
    config.update.columns.add_subgroup "Otros Datos" do |g|
      g.add  :email,:tel_fax,:observaciones
      g.collapsed = true
    end

    config.create.columns.exclude :invoices
    config.create.columns.add_subgroup "Datos Principales" do |g|
      g.add :name, :nombre_fantasia, :cuit, :condicion_venta,:descuento10, :descuento20, :ri
    end
    config.create.columns.add_subgroup "Direccion" do |g|
      g.add :direccion, :cp,:localidad,:provincia
    end
    config.create.columns.add_subgroup "Direccion Remito" do |g|
      g.add :remito_direccion, :remito_cp,:remito_localidad,:remito_provincia
    end
    config.create.columns.add_subgroup "Otros Datos" do |g|
      g.add  :email,:tel_fax,:observaciones
      g.collapsed = true
    end

    
  end
end
