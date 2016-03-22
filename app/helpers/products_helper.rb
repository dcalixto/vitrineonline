# encoding: utf-8
module ProductsHelper
  def mede(medida = false)
    if medida
      return "#{medida}cm"
    else
      return '----'
    end
  end

  def render_showcase
    render partial: 'showcase'
  end

  def options_for_tags(product_tags)
    (ActsAsTaggableOn::Tag.most_used(30) + product_tags).map(&:name).uniq.sort
  end


  include ActsAsTaggableOn::TagsHelper
end
