include ActionView::Helpers::NumberHelper

class InvoicePdf < Prawn::Document
  def initialize(vitrine, invoice, order, buyer, product)
    super({ page_size: 'A4' })
    @vitrine = vitrine
    @invoice = invoice
    @order = order
    @buyer = buyer
    @product = product
    text "FATURA ##{@invoice.id}"
    move_down 10
    body
    table table_data
  end

  def body
    headings = %w(USUÁRIO VITRINE PRODUTO COMISSÃO DATA)
    table_data = [headings]

    img = nil
   
    if @product.images.present? && @product.images.first.small
      img_url = @product.images.first.small.url
      if img_url.include?('.jpg') || img_url.include?('.png')
        begin
          if img_url.index('http') == 0
            img = open img_url
          else
            img = Rails.root.to_s + '/public' + img_url
            img = nil unless File.exist? img
          end
        rescue StandardError => e
          img = nil
        end
      end
    end

    rowspan = img.nil? ? 3 : 4
#[1]
    table_data make_table = [{ content: user_info, rowspan: rowspan },
                     { content: @vitrine.id, rowspan: rowspan, align: :center },
                     { content: @product.name, align: :center, padding_bottom: 0, borders: [] },
                     { content: number_to_currency(@invoice.store_fee), rowspan: rowspan, align: :center },
                     { content: @invoice.created_at.strftime('%d/%m/%Y'), rowspan: rowspan, align: :center }]

    product_price_col = { content: number_to_currency(@product.price), align: :center, size: 10, padding_top: 0, borders: [] }
    quantity_col = { content: "Quantidade: #{@order.quantity}", align: :center, size: 10, padding_top: 0, borders: [:bottom] }
    image_col = { image: img, padding_left: 20, borders: [], scale: 0.54 }
    table_data[2] = [img.nil? ? product_price_col : image_col]
    table_data[3] = [img.nil? ? quantity_col : product_price_col]
    table_data[4] = [quantity_col] unless img.nil?

    table table_data do # , :cell_style => {:borders => [:bottom]}
      rows(0).style(size: 10, font_style: :bold, align: :center)
      rows(1).style(size: 10)
      self.column_widths = { 0 => 140, 1 => 100, 2 => 140, 3 => 70, 4 => 70 }
    end
  end

  def user_info
    newline = "\n"
    info = @buyer.full_name + newline
    info += @buyer.user_address + newline if @buyer.address
    info += @buyer.user_neighborhood + newline if @buyer.neighborhood
    info += @buyer.user_city + newline if @buyer.city
    info += @buyer.postal_code + newline if @buyer.postal_code
    info += @buyer.user_address_supplement + newline if @buyer.address_supplement
    info
  end
end
