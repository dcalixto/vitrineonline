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
      title: 'Vitrineonline - Monte sua Vitrine',
      description: 'Monte sua vitrine, desenvolva sua vitrine, compre e venda roupas, calçados e acessórios do seu estilo',
      keywords: 'vitrine, loja, estilo,  moda, calçados, camisas, cordões, pulseiras, brincos, comprar, roupas, vender, ecommerce, loja virtual, online'
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

    #  markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(
                                        #   hard_wrap: true, filter_html: true, safe_links_only: true),
                                        # no_intraemphasis: true, autolink: true)
      markdown.render(text).html_safe
 end
    end
end
