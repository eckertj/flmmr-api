class API::MediaController < ApplicationController

  # GET /media
  # GET /media.json
  def index
    @media = Media.all

    # Search
    @media = @media.search(params[:q]) if params[:q]

    @media = @media.live(true)

    render json: @media if stale?(etag: @media.all, last_modified: @media.maximum(:updated_at))
  end

 end