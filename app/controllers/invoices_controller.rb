class InvoicesController < ApplicationController
  layout "crud"
  active_scaffold :invoice do |config|
    config.columns = [:date,:nro,:remito_nro,:client,:has_descuento_10,:has_descuento_20,:iva_percent,:condicion_venta,:total_to_s]
    config.show.link = false
    config.update.link.inline = true

    config.columns[:client].form_ui = :select
    config.columns[:client].update_column = [:has_descuento_10,:has_descuento_20,:condicion_venta]
    list.sorting = {:nro => 'ASC'}
    config.columns[:nro].search_sql = 'nro'
    #config.columns[:nro].inplace_edit = true
    config.search.columns << :nro
    config.search.columns << :client
   # config.columns[:client].search_sql = 'clients.name'

    config.actions.swap :search, :field_search

    config.columns[:invoice_products].css_class = "invoice-products-sub-form"
    
    config.update.columns = [:date,:nro,:remito_nro,:client,:has_descuento_10,:has_descuento_20,:iva_percent,:condicion_venta, :invoice_products]
    config.create.columns = [:date,:nro,:remito_nro,:client,:has_descuento_10,:has_descuento_20,:iva_percent,:condicion_venta, :invoice_products]

    config.action_links.add 'pdf',:label => 'PDF', :type => :member, :page => true, :html_options=>{:target=>'blank'}
    config.action_links.add 'pdf',:parameters =>{:preview=>true}, :label => 'Vista Previa', :type => :member, :page => true, :html_options=>{:target=>'blank'}
  
  end


  def pdf
    @debug = params[:preview]
    @invoice = Invoice.find(params[:id])
    @client = @invoice.client

    @factura_header = @client.name + "\n"
    @factura_header << @client.direccion + "\n" unless @client.direccion.nil?
    @factura_header << @client.cp + " " unless @client.cp.nil?
    @factura_header << @client.localidad + " " unless @client.localidad.nil?
    @factura_header << @client.provincia + " " unless @client.provincia.nil?
    
    @remito_header = @client.name + "\n"
    @remito_header << @client.remito_direccion + "\n" unless @client.direccion.nil?
    @remito_header << @client.remito_cp + " " unless @client.remito_cp.nil?
    @remito_header << @client.remito_localidad + " " unless @client.remito_localidad.nil?
    @remito_header << @client.remito_provincia + " " unless @client.remito_provincia.nil?
    
    @products = @invoice.invoice_products.map do |ip|
      [
        ip.quantity,
        ip.product.name + (ip.description ? "\n" + ip.description : ''),
        sprintf("%.2f", ip.price),
        sprintf("%.2f", ip.total),
      ]
    end

    @remito_products = @invoice.invoice_products.map do |ip|
      [
        ip.quantity,
        ip.product.name + (ip.description ? "\n" + ip.description : ''),
      ]
    end

    @totals = []
    if @invoice.has_descuento_10
      @totals << [{:colspan=>2,:text=>'DESCUENTO 10%'+'.'*20}, sprintf("%.2f", @invoice.descuento_10) ]
    else
      @totals << [nil,nil,'-' ]
    end
    @totals << [nil,nil,nil]
    @totals << [nil,nil, sprintf("%.2f", @invoice.subtotal1) ]
    if @invoice.has_descuento_20
      @totals << [{:colspan=>2,:text=>'DESCUENTO 20%'+'.'*20}, sprintf("%.2f",@invoice.descuento_20) ]
    else
      @totals << [nil,nil,'-' ]
    end
    @totals << [nil,nil, sprintf("%.2f",@invoice.subtotal2) ]
    if @invoice.client.ri
      @totals << [nil,@invoice.iva_percent, sprintf("%.2f",@invoice.iva) ]
      @totals << [nil,nil, '-' ]
    else
      @totals << [nil,nil, '-' ]
      @totals << [nil,@invoice.iva_percent, sprintf("%.2f",@invoice.iva) ]
    end
    @totals << [nil,nil, {:text=>sprintf("%.2f",@invoice.total), :vertical_padding => 9 }]


    options = {
      :skip_page_creation=>true,
      :page_size=>'LETTER',
      :left_margin => 0,
      :right_margin => 0,
      :top_margin => 0,
      :bottom_margin => 0}
    prawnto :inline => true, :prawn=>options

    respond_to do |format|
      format.pdf {}
    end
  end

  protected

  def before_create_save(r)
    r.subtotal = 0
    r.invoice_products.each { |ip| r.subtotal += ip.total unless ip.total.nil?} 
  end
  def before_update_save(r)
    r.subtotal = 0
    r.invoice_products.each { |ip| r.subtotal += ip.total unless ip.total.nil?} 
  end

end
