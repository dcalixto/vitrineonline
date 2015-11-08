module PoliciesHelper
  def correct_policy
    @policy = Policy.find(params[:id])
    redirect_to login_path unless current_vitrine?(@policy.vitrine)
  end
end
