module Netzke
  class InvoiceProductGridPanel < GridPanel
    
    def self.js_extend_properties
      {
        :init_component => <<-END_OF_JAVASCRIPT.l,
          function(){
            #{js_full_class_name}.superclass.initComponent.call(this);
          }
        END_OF_JAVASCRIPT

        :subtotal => <<-END_OF_JAVASCRIPT.l,
          function(){
            var r = 0;
            Ext.iterate(this.store.data.items, function(o){            
              r += o.data.quantity * o.data.price;
            }, this);
            return r;
          }        
        END_OF_JAVASCRIPT

        :lines => <<-END_OF_JAVASCRIPT.l,
          function(){
            var r = 0;
            Ext.iterate(this.store.data.items, function(o){            
              r += 1;
              var v = o.data.description;
              if (v!=null){
                r += Math.ceil(Math.max(1,v.split().length/10,v.split(' ').length/10));
              }
            }, this);
            return r;
          }        
        END_OF_JAVASCRIPT
                
      }
    end
    
  end
end
