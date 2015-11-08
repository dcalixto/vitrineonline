class SectionsController < ApplicationController
  before_filter :authorize, :correct_section, only: [:destroy]

  def index
    @sections = current_vitrine.sections.order('created_at DESC').page(params[:page]).per_page(15)
    @section = Section.new
  end

  def create
    @section = current_vitrine.sections.build(params[:section])
    respond_to do |format|
      if @section.save
        format.html { redirect_to vitrine_sections_url, notice: 'Seção criada.' }
        format.json { render json: @section, status: :created, location: @section }
        format.js
      else
        format.html { render action: 'index' }

        @sections = current_user.vitrine.sections.all
      end
    end
  end

  def show
    @section = Section.find_by_id(params[:id])
    @vitrine = Vitrine.find_by_id(params[:id])
    @products = @section.products
    @total_from_buyers = Feedback.by_participant(@section.boutique.user, Feedback::FROM_BUYERS).not_neutral(Feedback::FROM_BUYERS).count
    @positive_from_buyers = Feedback.by_rating(@section.boutique.user, Feedback::FROM_BUYERS, Feedback::POSITIVE).count
  end

  def products
    @boutique = Vitrine.find_by_id(params[:id])
    @section = Section.find_by_id(params[:id])
    # unless
    @products = @section.products.order('created_at DESC').page(params[:page]).per_page(8)
    # end
    respond_to do |format|
      format.html { render 'products', layout: false }
    end
  end

  def destroy
    @section = Section.find_by_id(params[:id])
    @section.destroy
    redirect_to boutique_sections_url
    flash[:notice] = 'Seção deletada'
  end

  private

  def correct_section
    @section = Section.find(params[:id])
    redirect_to login_path unless current_vitrine?(@section.vitrine)
  end
end
