module Netzke 
  class AreasPricesForm < FormPanel 
    def default_config 
      super.merge({ 
        :class_name => 'Panel', 
        :static_form_layout => { 
          :xtype => 'textfield', 
          :fieldLabel => 'Lot area', 
          :name => 'lot_area_description', 
          :anchor => '95%', 
          :cls => 'statictext' 
        }, 
        :model => 'Property', 
        :ext_config => { 
          :header => false 
        } 
      }) 
    end 
  end 
end 

module Netzke
  class InvoiceFormPanel < FormPanel

    def initial_config
      
      super.merge({
        :static_form_layout => { 
          :xtype => 'textfield', 
          :fieldLabel => 'Lot area', 
          :name => 'lot_area_description', 
          :anchor => '95%', 
          :cls => 'statictext' 
        }, 
        :ext_config => {
          :header => false,
          :bbar => false,
        },
        :model => "InvoiceForFormPanel",
        :ext_config => {
          :header => false,
          :bbar => false,
        },
        :record_id => super[:record_id],
        
      })
    end
    
#    def get_combobox_options(params)
#      column = params[:column]
#      query = params[:query]
#      {:data => ['mocos']}
      # {:data => data_class.options_for(column, query).map{|s| [s]}}
#    end
      
    def self.js_extend_properties
      {
        :label_width  => 100,
        :init_component => <<-END_OF_JAVASCRIPT.l,
          function(){
            #{js_full_class_name}.superclass.initComponent.call(this);
            this.getForm().findField('client__name').on("select", function(c){
              this.selectClient({client__name: c.getValue()});
            }, this);
          }
        END_OF_JAVASCRIPT
        
        :selected_client => <<-END_OF_JAVASCRIPT.l,
          function(c){
            this.getForm().findField('has_descuento_10').setValue(c.descuento10);
            this.getForm().findField('has_descuento_20').setValue(c.descuento20);
            this.getForm().findField('condicion_venta').setValue(c.condicionVenta);
          }
        END_OF_JAVASCRIPT

        
      }
    end

    api :select_client
    def select_client(params)
      c = Client.first(:conditions => ["name = ?", params[:client__name]])
      # pass 
      {'selected_client' => {:name=> c.name, :descuento10=> c.descuento10, :descuento20=> c.descuento20, :condicion_venta=> c.condicion_venta, :ri=> c.ri}}
    end

    
  end
end

