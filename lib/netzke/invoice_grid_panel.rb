module Netzke
  class InvoiceGridPanel < GridPanel 
  
    def actions
      res = super
      res[:add][:text]="Agregar"
      res[:edit][:text]="Editar"
      res[:search][:text]="Buscar"
      res.merge({
        :print_invoice => {:text => "Imprimir Factura"},
      })
    end
    
    def default_bbar
      ["add", "-", "edit", "-", "search", "-","print_invoice"]
    end
    
    def default_context_menu
      ["add", "-", "edit", "-", "search", "-","print_invoice" ]
    end

    def self.js_extend_properties
      super.merge({
        :init_component => <<-END_OF_JAVASCRIPT.l,
          function(){
            #{js_full_class_name}.superclass.initComponent.call(this);

            this.getSelectionModel().on('selectionchange', function(sm){
            }, this);
            
            this.on('rowdblclick', this.onRowDblClick, this);
          }
        END_OF_JAVASCRIPT
        
        :on_add => <<-END_OF_JAVASCRIPT.l,
          function(){
            this.loadAggregatee({id: "addInvoice", callback: function(form){
              form.on('close', function(){
                if (form.closeRes === "ok") {
                  this.openInvoice(form.invoiceId());
                }
              }, this);
            }, scope: this});
          }
        END_OF_JAVASCRIPT

        # Event handler
        :on_row_dbl_click => <<-END_OF_JAVASCRIPT.l,
          function(self, rowIndex){
            this.openInvoice(self.store.getAt(rowIndex).get('id'));
          }
        END_OF_JAVASCRIPT

        # Event handler
        :open_invoice => <<-END_OF_JAVASCRIPT.l,
          function(id){
            this.invoice_id = id;
            this.selectInvoice({invoice_id: id});
          }
        END_OF_JAVASCRIPT

        :on_edit => <<-END_OF_JAVASCRIPT.l,
          function(self, rowIndex){
            this.loadAggregatee({id: "editInvoice", callback: function(form){
              form.on('close', function(){
                if (form.closeRes === "ok") {
                  this.store.reload();
                }
              }, this);
            }, scope: this});
          }
        END_OF_JAVASCRIPT

        :on_print_invoice => <<-END_OF_JAVASCRIPT.l,
          function(){
            window.open('/print/invoice/'+this.invoice_id+'.pdf','invoice_pdf','width=50,height=50,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,copyhistory=no,resizable=no');
          }
        END_OF_JAVASCRIPT

        
      })
    end

    api :select_invoice
    def select_invoice(params)
      # store selected boss id in the session for this widget's instance
      session[:selected_invoice_id] = params[:invoice_id]
      
      # pass 
      {"js"=>"this.onEdit()"}
    end

    def initial_late_aggregatees
      res = {}
      # Edit in form
      res.merge!({
        :add_invoice=> {
          :class_name => "InvoiceWindow",
          :record_id => nil,
        },
        :edit_invoice=> {
          :class_name => "InvoiceWindow",
          :record_id => session[:selected_invoice_id],
        },
      })      
      res
    end
    
  end
end
