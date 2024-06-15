class ApplicationController < ActionController::API
  before_action :process_token

  private

  def process_token
    token = request.headers['Authorization']&.split(' ')&.last
    unless token.present?
      return render json: { error: 'Unauthorized Request' }, status: :unauthorized
    end

    begin
      
      decoded_token = JWT.decode(token, Rails.application.credentials.secret_key_base)

      @user = User.find(decoded_token.first['sub'])
    rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
      render json: { error: 'Invalid Token' }, status: :unauthorized
    end
  end
end
