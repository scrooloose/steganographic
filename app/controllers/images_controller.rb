class ImagesController < InheritedResources::Base
  before_filter :login_required

  def new
    @image = Image.new
  end

  def create
    @image = Image.new(params[:image])
    if @image.save
      redirect_to new_challenge_path, :notice => "Successfully created image."
    else
      render :action => 'new'
    end
  end
end
