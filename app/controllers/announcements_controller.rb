# encoding: utf-8
class AnnouncementsController < ApplicationController
  before_filter :authorize_vitrine, only: [:create]

  def create
    @announcement = current_vitrine.announcements.build(params[:announcement])
    if @announcement.save
      redirect_to new_vitrine_announcement_path
      flash[:success] = 'Anúncio adicionado'
    else
      render :new
    end
  end

  def new
    @announcement = Announcement.new
  end
end
