class API::MediaController < ApplicationController

  # before_filter :authenticate

  def index
    @media = Media.all

    # Search
    search_string = params[:q] if params[:q]
    search_terms = search_string.split(' ')
    search_terms.each do |search_term|
      @media = @media.search(search_term) if search_term
    end

    # TV station
    @media = @media.station(params[:station]) if params[:station]

    # Check if media should be live
    @media = @media.live()

    # Check that media was published before or after a specific date
    @media = @media.after_date(Time.parse(params[:after_date])) if params[:after_date]
    @media = @media.before_date(Time.parse(params[:before_date])) if params[:before_date]

    # Check that media is longer or shorter than a duration (in seconds)
    @media = @media.min_duration(params[:min_duration]) if params[:min_duration]
    @media = @media.max_duration(params[:max_duration]) if params[:max_duration]

    render json: @media if stale?(etag: @media.all, last_modified: @media.maximum(:updated_at))
  end

end
