class VowelPurchasesController < ApplicationController
  before_filter :load_response

  def new
  end

  def create
    redirect_to new_challenge_response_path(@resp)
    @resp.show_vowels = true
    @resp.save!
  end

  protected
    def load_response
      @resp = Response.find(params[:resp_id])
    end
end
