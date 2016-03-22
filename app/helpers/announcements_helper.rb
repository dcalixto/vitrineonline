 #encoding: utf-8
module AnnouncementsHelper
  def announcement_hidden?(current_announcement)
    cookies["announcement_#{current_announcement.created_at}"] == 'hidden'
  end

def vitrine
  vitrine = Vitrine.find(params[:id])
end

  def current_announcement
    @current_announcement ||= vitrine.announcements.current
end

  def current_vitrine_announcement
    @current_vitrine_announcement ||= current_vitrine.announcements.current
end
end
