module InvoiceProductsHelper

  def invoice_product_quantity_form_column(record, options)
    options[:class] << ' text-input'
    options[:onchange] = "uip(this.id);"
    options[:ondblclick] = "this.value++;uip(this.id);"
    options[:onkeydown] = "return validateNumeric(event,true);"
    record.quantity = 1 if record.quantity.nil?
    input :record, :quantity, options
  end

  def invoice_product_price_form_column(record, options)
    options[:class] << ' text-input'
    if (params[:controller]=="invoice_products" && params[:action]=="render_field" && params[:column]=="product" )
      logger.debug 'lokking for product'
      product = Product.find(params[:value])
      record.price = product.price
    end
 #   options[:value] = sprintf("%.2f", options[:value]) unless options[:value].nil?
    options[:onchange] = "uip(this.id);"
    options[:onkeydown] = "return validateNumeric(event,false);"
    input :record, :price, options
  end

  def invoice_product_total_form_column(record, options)
    options[:readonly] = 'readonly'
    options[:class] << ' text-input'
#    options[:value] = record.total
#    options[:value] = sprintf("%.2f", options[:value]) unless options[:value].nil?
    input :record, :total, options
  end

  def invoice_product_description_form_column(record, options)
    options[:class] << ' text-input'
    options[:onfocus] = ' new TextAreaResize($(this.id))'
    input :record, :description, options
  end

end
