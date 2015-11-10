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


  include ActsAsTaggableOn::TagsHelper
end
