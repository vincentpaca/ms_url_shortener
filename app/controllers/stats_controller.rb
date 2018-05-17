class StatsController < ApplicationController

  protect_from_forgery prepend: true

  def show_click_stats
    unique_name = URI::parse(params[:url]).path.gsub('/','')
    shortened_url = ShortenedUrl.find_by(unique_name: unique_name)

    if shortened_url
      visits = shortened_url.visits
      render json: {
        click_stats: {
          summary: {
            total_clicks: visits.count
          },
          visits: visits
        }
      }.to_json
    else
      render json: {
        error: 'Not Found'
      }.to_json, status: 404
    end
  end

end
