class ProductsController < ApplicationController
  layout "crud"
  active_scaffold :product do |config|
    config.columns = [:name, :price]
    config.show.link = false
    list.sorting = {:name => 'ASC'}
    config.actions.swap :search, :field_search
    
  end

end
