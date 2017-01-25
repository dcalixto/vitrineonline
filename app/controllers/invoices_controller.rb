class InvoicesController < ApplicationController
  before_filter :authorize_vitrine, only: [:index, :show]

  def index
    @q = current_vitrine.invoices.ransack(params[:q])
    @invoices = @q.result(distinct: true).paginate(page: params[:page], per_page: 22)
    render :index
   end

  def show
    @invoice = current_vitrine.invoices.find(params[:id])
    @order = @invoice.order
    @buyer = @order.buyer
    @product = @order.product
 #   respond_to do |format|
   #   format.html
   #   format.pdf do
   #     pdf = InvoicePdf.new(current_vitrine, @invoice, @order, @buyer, @product)
    #    send_data.to_s pdf.render, filename: "invoice_#{@invoice.id}.pdf", type: 'application/pdf'
    #  end
   ## end



 respond_to do |format|
      format.html
      format.pdf do
        render :pdf => 'file_name',
        :template => 'invoices/show.pdf.erb',
        :layout => 'pdf.html.erb',
        :show_as_html => params[:debug].present?
      end
    end


  end
end





