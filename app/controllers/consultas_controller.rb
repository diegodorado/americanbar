class ConsultasController < ApplicationController
  layout "crud"

  active_scaffold :invoice_products do | config |
    config.label = 'Consultas'
    
    config.actions = [:list, :search]
    config.actions.swap :search, :field_search
    config.field_search.columns = [:invoice_date, :invoice_client,:product]
    config.columns = [:invoice_client,:invoice_date,:invoice_nro,:invoice_remito_nro,:client_name,:quantity,:product,:price, :total]
    config.list.columns.exclude :invoice_client

    config.columns[:invoice_client].includes = {:invoice => :client}
    config.columns[:invoice_client].search_sql = 'clients.id'
    config.columns[:invoice_client].search_ui = :select
    config.columns[:invoice_client].options[:options] = Client.find(:all, :order => "name").map {|c| [c.name, c.id]}
    #HACK
    
    config.columns[:invoice_date].search_sql = 'invoices.date'
    config.columns[:invoice_date].search_ui = :calendar_date_select
    config.columns[:invoice_date].sort_by  :sql => 'invoices.date'

    config.columns[:client_name].sort_by  :sql => 'clients.name'
    config.columns[:invoice_nro].sort_by  :sql => 'invoices.nro'
    config.columns[:invoice_remito_nro].sort_by  :sql => 'invoices.remito_nro'

    config.columns[:quantity].calculate = :sum
    config.columns[:price].calculate = :avg
    config.columns[:total].calculate = :sum
   
  end

  
end
