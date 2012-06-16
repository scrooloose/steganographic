class VowelPurchasesController < ApplicationController
  before_filter :login_required

  def new
    #a hack to detect if the google checkout form has redirected back to us
    if params[:unlock_token]
      create
    else
      @resp = Response.find(params[:resp_id])
    end

  end

  def create
    @resp = Response.find_by_id_and_unlock_token(params[:resp_id], params[:unlock_token]) || raise(ActiveRecord::RecordNotFound)
    unless @resp.show_vowels
      @resp.show_vowels = true
      @resp.make_giverboard_purchase(current_user)
      @resp.save!
    end
    render :action => 'create'
  end
end
