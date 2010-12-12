module Netzke
  class InvoiceWindow < Window

    def actions
      super.merge({ 
        :print  => {:text => "Imprimir", :disabled=>true},
        :save     => {:text => "Guardar"},
        :close => {:text => "Cerrar"},
      })
    end

    def initial_config
      super.merge({
        :item =>  {
          :widget_class_name => "BorderLayoutPanel",
          :regions => {
            :north => {
              :widget_class_name => "InvoiceFormPanel",
              :region_config => {
                :height => 100,
                :split => true
              },
              :record_id => super[:record_id],
            },
            :center => {
              :widget_class_name => "InvoiceProductGridPanel",
              :model => "InvoiceProductForGridPanel",
              :ext_config => {
                :header => false,
                :enable_pagination => false,
                :disabled => true,
                :bbar =>  ["add"],
              },
              :scopes => [[:invoice_id, super[:record_id]]],
              :strong_default_attrs => {:invoice_id => super[:record_id]}
              
            },
            :south => {
              :widget_class_name => "Panel",
              :region_config => {
                :height => 30,
                :split => true
              },
              :ext_config => {
                :header => false,
              },
            },
          },
          :ext_config => {
            :header => false,
          }

        },
        :ext_config => {
          :closable => false,
          :maximized => true,
          :modal => true,
          :cls => 'invoice_form',
          :title => "Factura / Recibo",          
          :layout => 'absolute',
          :fbar => [
            :print,
            :save, 
            :close
          ],
        },
      })
    end
  
    def self.js_extend_properties
      {
        :button_align => "right",      

        :invoice_id => <<-END_OF_JAVASCRIPT.l,
          function(){
            var v = this.getWidget().getNorthWidget().getForm().getValues();
            return v.id;
          }
        END_OF_JAVASCRIPT

        :grid_panel => <<-END_OF_JAVASCRIPT.l,
          function(){
            return this.getWidget().getCenterWidget();
          }
        END_OF_JAVASCRIPT

        :summary => <<-END_OF_JAVASCRIPT.l,
          function(v){
            this.getWidget().getSouthWidget().updateBodyHtml(v);
          }
        END_OF_JAVASCRIPT

        :init_component => <<-END_OF_JAVASCRIPT.l,
          function(){
            #{js_full_class_name}.superclass.initComponent.call(this);
            this.getWidget().getNorthWidget().on("submitsuccess", function(){
              this.getWidget().getCenterWidget().onApply();
              this.closeRes = "ok";
              if (this.isNew){
                this.close();
              }
            }, this);
            this.gridPanel().on("afterEdit", function(e){
              if (e.field=='product__name'){
                this.selectProduct({product__name: e.value});
                e.record.data.price=30;
                e.record.commit();
                console.log(e);
              }
              this.updateSummary();                        
            }, this);
            this.on("afterrender", function(){
              this.isNew = !(this.invoiceId()>0);
              if (!this.isNew){
                this.actions.print.setDisabled(0);
                this.gridPanel().enable();
              }
            }, this);
          }
        END_OF_JAVASCRIPT
      
        :on_print => <<-END_OF_JAVASCRIPT.l,
          function(){
            window.open('/print/invoice/'+this.invoiceId()+'.pdf','invoice_pdf','width=50,height=50,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,copyhistory=no,resizable=no');
          }
        END_OF_JAVASCRIPT
                        
        :update_summary => <<-END_OF_JAVASCRIPT.l,
          function(){
            var max_lines = 4;
            var html = 'Total: '+ Ext.util.Format.usMoney(this.gridPanel().subtotal());
            if (this.gridPanel().lines()>max_lines) html += '<span style="color:red;float:right;"> Es posible que la impresión no quepa en la hoja.</span>';
            this.summary(html);
          }
        END_OF_JAVASCRIPT
                        
        :on_save => <<-END_OF_JAVASCRIPT.l,
          function(){
            this.getWidget().getNorthWidget().onApply();
          }
        END_OF_JAVASCRIPT
      
        :on_close => <<-END_OF_JAVASCRIPT.l,
          function(){
            //if (this.getWidget().getNorthWidget().getForm().isDirty()) {
            if (false) {
              Ext.Msg.confirm('Confirmar', 'Desea cerrar sin guardar cambios?', function(btn){
                if (btn == 'yes') {
                  this.close();
                }
              }, this);          
            }else{
              this.close();
            }
          }
        END_OF_JAVASCRIPT
        
        :selected_product => <<-END_OF_JAVASCRIPT.l,
          function(p){
            console.log(p);
            //this.getForm().findField('condicion_venta').setValue(c.condicionVenta);
          }
        END_OF_JAVASCRIPT
                
      }
    end
    
    api :select_product
    def select_product(params)
      p = Product.first(:conditions => ["name = ?", params[:product__name]])
      # pass 
      {:selected_product => {:name=> p.name, :price=> p.price}}
    end
    
  end
end
