# encoding: utf-8
module ApplicationHelper

 

  def broadcast(channel, &block)
    PrivatePub.publish_message(PrivatePub.message(channel, capture(&block)))
  end

  def new_messages?
    @new_messages ||= current_user.conversations.where(['conversations.updated_at > ?', current_user.last_read_messages_at])
    @new_messages.count > 0
  end

  def num_new_messages
    if new_messages?
      @new_messages.count
    else
      0
    end
  end

  def new_feedback?
    @awaiting_feedback_count = Order.awaiting_feedback(current_user)
    @awaiting_feedback_count.count > 0
  end

  def num_new_feedback
    if new_feedback?
      @awaiting_feedback_count.count
    else
      0
    end
  end






  def num_new_comments
    current_user.posts.joins(:comments).where('comments.user_id != ? and not comments.read', current_user.id).count
  end

  def default_meta_tags
    {

      title: 'Vitrineonline - Compre agora eletrônicos, roupas, supplementos, produtos para casa & jardim e automotivos',
      
      description: 'Comprar online, produtos automotivos, acessórios para telefone, computador, eletrônicos,
      roupa, beleza, saúde,  supplementos, casa e jardim, brinquedos, esportes, casamento, eventos,
      Monte sua vitrine agora na vitrineonline e anuncie  para todo Brasil.',

      keywords: 'Vitrineonline, social, ofertas, oferta, loja, camisas, comprar, roupas, vender, ecommerce, loja online, celular, camisetas,
      iphone, samsung, whey, spirulina, coenzyma q10, supplemento, supplementos, nike, facebook, Twitter, instagram,
      camisa polo, smartphone, smartfone, camisas masculinas, camisas femininas, BCAA, Creatina, Optimum Nutrition Opti-Men,
      Gopro, Maca, Colágeno,
      Compras online, Comprar online, Marketing online, Automotivo, Telefones, Acessórios, Computadores, PlayStation,xbox,
      Eletrônicos, Moda, Beleza, Saúde, Casa, Jardim, Brinquedos, Esportes, Casamento, Eventos'

      
      

    }
  end










  def remove_user
    cookies.delete(:auth_token)
    current_user = nil
    redirect_to root_url
  end

  def order_count
    if current_user
      unless current_user.cart.nil?
        total = 0
        current_user.cart.orders.each do |order|
          total += order.quantity if order.status.nil?
        end
        total > 0 ? " #{total}" : ''
      end
    end
  end

  def order_subtotal
    if current_user
      unless current_user.cart.nil?
        total = 0
        current_user.cart.orders.each do |order|
          total += order.total_price if order.status.nil?
        end
        total > 0 ? " #{total}" : ''
      end
    end
  end

  def markdown(text)
    if text.blank?
      nil
    else
      markdown = Redcarpet::Markdown.new(MdEmoji::Render, :no_intra_emphasis => true,
                                         hard_wrap: true, filter_html: true, safe_links_only: true,
                                         no_intraemphasis: true, autolink: true)

      # markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(
      #                                     hard_wrap: true, filter_html: true, safe_links_only: true),
      #                                 no_intraemphasis: true, autolink: true)
      markdown.render(text).html_safe
    end
  end


  def full_image_path_helper(img)
    root_url.chomp('/') + asset_path(img)
  end



def display_image(pdata)  
    unless pdata.nil? 
      image_tag(pdata.image) 
    else
      image_tag("/assets/fallback/small_foto.png")
     end    
end


def human_boolean(boolean)
    boolean ? 'Sim' : 'Não'
end



def percent_of(n)
    self.to_f / n.to_f * 100.0
  end
end



