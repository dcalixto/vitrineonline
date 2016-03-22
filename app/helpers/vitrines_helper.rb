# encoding: utf-8
module VitrinesHelper
include ActsAsTaggableOn::TagsHelper
  def current_vitrine
    @current_vitrine ||= current_user.vitrine
  end

  def current_vitrine?(vitrine)
    vitrine == current_vitrine
  end

  def vitrine
    vitrine = Vitrine.find_by_id(params[:id])
  end

  def current_vitrine=(vitrine)
    @current_vitrine = vitrine
  end

  def correct_vitrine
    @vitrine = Vitrine.find(params[:id])
    redirect_to login_path unless current_vitrine?(@vitrine)
  end
end
