# encoding: utf-8
class PoliciesController < ApplicationController
  before_filter :authorize, :correct_policy, only: [:edit, :update]
  def edit
    @policy = Policy.find(params[:id])
  end

  def update
    @policy = Policy.find(params[:id])
    if @policy.update_attributes(params[:policy])
      redirect_to(action: :edit, id: @policy)
      flash[:success] = 'Política Atualizada'
    else
      render :edit
    end
  end

  private

  def correct_policy
    @policy = Policy.find(params[:id])
    redirect_to login_path unless current_vitrine?(@policy.vitrine)
  end
end
