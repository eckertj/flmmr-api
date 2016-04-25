class API::MediaController < ApplicationController

  # before_filter :authenticate

  def index
    @media = Media.all

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

    # Search
    if params[:q]
      search_terms = params[:q].split(' ')
      search_terms.each do |search_term|
        @media = @media.search(search_term) if search_term
      end
    end

    # set limit - default value is 200
    @media = params[:limit] ? @media.limit(params[:limit]) : @media.limit(200)

    # set order_least_recent=1 if you want the oldest entry first - newest entry first is default
    @media = params[:order_least_recent] && params[:order_least_recent].to_i>0 ? @media.least_recent() : @media.most_recent()

    render json: @media if stale?(etag: @media.all, last_modified: @media.maximum(:updated_at))
  end

end
