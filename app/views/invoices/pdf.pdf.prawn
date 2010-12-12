unless @invoice.nro.nil?
  2.times do
    pdf.start_new_page
    pdf.font "Courier", :size => 9
    if @debug
      pdf.image RAILS_ROOT + '/public/images/factura.jpg', :at => [pdf.bounds.top_left]
    end

    pdf.draw_text "BS.AS. #{@invoice.date.strftime('%d/%m/%y')}", :at => [410,pdf.bounds.top-80]
    pdf.text_box @factura_header, :width => 300, :at => [80,pdf.bounds.top-150]
    pdf.text_box "Cliente Nº "+@invoice.client.id.to_s, :width => 130, :at => [450,pdf.bounds.top-150]
    pdf.draw_text @invoice.condicion_iva, :at => [70,pdf.bounds.top-195]
    pdf.draw_text @invoice.client.cuit, :at => [350,pdf.bounds.top-195]

    pdf.bounding_box [10,pdf.bounds.top-255], :width => 560 do
      pdf.table @products,
          :font_size  => 9, 
          :column_widths => { 0 => 60, 1 => 348, 2 => 70, 3 => 90 },
          :align              => {0 => :right, 1 => :left, 2 => :right, 3 => :right},
          :horizontal_padding => 10,
          :vertical_padding   => 3,
          :border_width       => 0
    end
    pdf.bounding_box [25,pdf.bounds.top-550], :width => 560 do
      pdf.table @totals,
          :font_size  => 9, 
          :column_widths => { 0 => 360, 1 => 100, 2 => 100 },
          :align              => {0 => :right, 1 => :right, 2 => :right},
          :horizontal_padding => 15,
          :vertical_padding   => 5,
          :border_width       => 0
    end
  end
end

unless @invoice.remito_nro.nil?
  3.times do
    pdf.start_new_page
    if @debug
      pdf.image RAILS_ROOT + '/public/images/remito.jpg', :at => [pdf.bounds.top_left]
    end
    
    pdf.draw_text "BS.AS. #{@invoice.date.strftime('%d/%m/%y')}", :at => [410,pdf.bounds.top-80]
    pdf.text_box @remito_header, :width => 300, :at => [80,pdf.bounds.top-150]
    pdf.text_box "Cliente Nº "+@invoice.client.id.to_s, :width => 130, :at => [450,pdf.bounds.top-150]
    pdf.draw_text @invoice.condicion_iva, :at => [70,pdf.bounds.top-195]
    pdf.draw_text @invoice.client.cuit, :at => [350,pdf.bounds.top-195]
    
    pdf.bounding_box [10,pdf.bounds.top-255], :width => 560 do
      pdf.table @remito_products,
          :font_size  => 9, 
          :column_widths => { 0 => 60, 1 => 348, 2 => 70, 3 => 90 },
          :align              => {0 => :right, 1 => :left, 2 => :right, 3 => :right},
          :horizontal_padding => 10,
          :vertical_padding   => 3,
          :border_width       => 0
    end
    
  end
end  
