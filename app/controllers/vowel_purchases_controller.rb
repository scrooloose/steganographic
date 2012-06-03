class VowelPurchasesController < ApplicationController
  before_filter :load_response

  def new
  end

  def create
    unless @resp.show_vowels
      @resp.show_vowels = true
      @resp.make_giverboard_purchase(current_user)
      @resp.save!
    end
  end

  protected
    def load_response
      @resp = Response.find(params[:resp_id])
    end

end
