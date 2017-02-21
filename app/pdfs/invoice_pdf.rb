#include ActionView::Helpers::NumberHelper


#!/usr/bin/env ruby
# This is an example of a very simple invoice.

lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'invoice_printer'

if @order.present?

item = InvoicePrinter::Document::Item.new(
  name: "#{@order.product.name}",
  quantity: "#{@order.product.quantity}",
    price: "#{@order.product.price}",
  tax: "#{@invoice.store_fee}",
  
)

invoice = InvoicePrinter::Document.new(
  number: "#{@invoice.id}",
  provider_name: 'Vitrineonline',
  provider_street: 'Avenida Roberto Silveira',
  provider_street_number: '95A',
  provider_postcode: '23970000',
  provider_city: 'Paraty',
  provider_city_part: 'Rio de Janeiro',
  purchaser_name: "#{@vitrine.name}",
  purchaser_street: "#{@vitrine.address}",
   purchaser_postcode: "#{@vitrine.post_code}",
  purchaser_city: "#{@user.city}",
  purchaser_city_part: "#{@user.state}",
  issue_date: "#{@invoice.created_at.strftime('%d/%m/%Y')}",
  subtotal: "#{@order.quantity}",
  tax:  "#{@invoice.store_fee}",
  total: "#{@order.total_price}",
payment: "#{@vitrine.policy.paypal}",
  items: [item],
  )




  InvoicePrinter.labels = {
  name: 'Fatura',
  provider: 'Serviço',
  purchaser: 'Usuário',
  payment: 'Forma de Pagamento',
  issue_date: 'Data',
  item: 'Item',
  quantity: 'Quantidade',
   tax: 'Comissão',
   subtotal: 'Subtotal',
  total: 'Total'
}



InvoicePrinter.print(
  document: invoice,
  labels: labels,
  logo: 'logo.png'
#  file_name: 'complex_invoice.pdf',
  )


end


