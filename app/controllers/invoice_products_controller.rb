class InvoiceProductsController < ApplicationController
  layout "crud"
  active_scaffold :invoice_products do | config |
    config.columns = [:quantity,:product,:price,:total,:description]
    config.columns[:product].update_column = [:price]    
  end
end
