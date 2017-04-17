class PdatasController < ApplicationController


  def show
    @pdata = Pdata.find(params[:id])
  end

end
