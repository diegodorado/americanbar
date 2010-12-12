module InvoicesHelper

  def javascript_for_update_column(column, scope, options)
  
    if column.update_column
      #diego's hack!!
      form_id = 'as_invoices-'+(params[:id] ? 'update-'+params[:id] : 'create-')+'-form'
      logger.debug column.name
      logger.debug form_id
      
      url_params = {:action => 'render_field', :id => params[:id], :column => column.name, :update_column => column.update_column}
      url_params[:eid] = params[:eid] if params[:eid]
      url_params[:controller] = controller.class.active_scaffold_controller_for(@record.class).controller_path if scope
      url_params[:scope] = scope if scope
      
      ajax_options = {:method => :get,
                      :url => url_for(url_params), :with => column.send_form_on_update_column ? "Form.serialize(this.form)" : "'value=' + this.value",
                      :after => "Form.disable('#{form_id}');",
                      :complete => "Form.enable('#{form_id}');ucc('#{form_id}','#{scope}');"}
      options[:onchange] = "#{remote_function(ajax_options)};#{options[:onchange]}"
    end
    options
  end


  def invoice_condicion_venta_form_column(record, options)
    options[:class] << ' text-input'
    if (params[:controller]=="invoices" && params[:action]=="render_field" && params[:column]=="client" )
      client = Client.find(params[:value])
      options[:value] = client.condicion_venta
    end
    input :record, :condicion_venta, options
  end

  def invoice_has_descuento_10_form_column(record, options)
    if (params[:controller]=="invoices" && params[:action]=="render_field" && params[:column]=="client" )
      client = Client.find(params[:value])
      options[:checked] = 'checked' if client.descuento10
    end
    options[:onchange] = "uit($(this.id).up('form'));"
    check_box :record, :has_descuento_10, options
  end

  def invoice_has_descuento_20_form_column(record, options)
    if (params[:controller]=="invoices" && params[:action]=="render_field" && params[:column]=="client" )
      client = Client.find(params[:value])
      options[:checked] = 'checked' if client.descuento20
    end
    options[:onchange] = "uit($(this.id).up('form'));"
    check_box :record, :has_descuento_20, options
  end


  def invoice_iva_percent_form_column(record, options)
    # simple example that just hard codes two possible values
    options[:onchange] = "uit($(this.id).up('form'));"
    select :record, :iva_percent, options_for_select({'' => '', '21%'=>21.0, '10.5%' => 10.5},record.iva_percent), options, options
  end

end
