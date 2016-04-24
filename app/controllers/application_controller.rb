class ApplicationController < ActionController::API
  include ActionController::Serialization

  def authenticate
    api_key = request.headers['X-Api-Key']

    @token = Token.where(api_key: api_key).first if api_key

    unless @token
      head status: :unauthorized
      return false
    end
  end

end
