class ImagesController < InheritedResources::Base
  before_filter :authenticate_user!

  def new
    @image = Image.new
  end

  def create
    @image = Image.new(params[:image])
    if @image.save
      redirect_to dashboard_path, :notice => "Successfully created image."
    else
      render :action => 'new'
    end
  end
end
