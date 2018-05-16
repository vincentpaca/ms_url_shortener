class ShortenedUrlsController < ApplicationController

  def new
    @shortened_url = ShortenedUrl.new
  end

  def create
    @shortened_url = ShortenedUrl.new(shortened_url_params)

    if @shortened_url.save
      redirect_to shortened_url_path(@shortened_url)
    end
  end

  def show
    shortened_url = ShortenedUrl.find(params[:id])
    @url = "#{request.base_url}/#{shortened_url.unique_name}"
  end

  def show_shortened_url
    @shortened_url = ShortenedUrl.find_by(unique_name: params[:id])

    if @shortened_url
      #todo: add the visitor statistics here
      redirect_to @shortened_url.original_url
    else
      raise ActionController::RoutingError, 'Not Found'
    end
  end

  private

  def shortened_url_params
    params.require(:shortened_url).permit(:original_url)
  end

end
