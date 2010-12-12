class InvoiceProductsController < ApplicationController
  layout "crud"
  active_scaffold :invoice_products do | config |
    config.columns = [:quantity,:product,:price,:total,:description]
  end
end
