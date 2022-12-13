class Api::V1::SessionsController < Api::V1::BaseController # inherit from base controller
  skip_before_action :verify_request

  def login
    # 1 - Rails sends the code to Tencent along with app secret and app id
    # 2 - Tencent sends back user's openId
    # 3 - Find user with openId in the database; if not, create a new user with this openId
    # 4 - Send a JWT that stores user information to MP
    user = User.find_or_create_by!(open_id: fetch_open_id['openid'])
    p user
    response.set_header('Authorization', fetch_jwt_token(user))

    render json: { user:, avatar: user.avatar.url }
  end

  private

  def fetch_open_id
    code = params[:code]
    app_id = Rails.application.credentials.dig(:wechat, :app_id)
    app_secret = Rails.application.credentials.dig(:wechat, :app_secret)
    url = "https://api.weixin.qq.com/sns/jscode2session?appid=#{app_id}&secret=#{app_secret}&js_code=#{code}&grant_type=authorization_code"

    res = RestClient.get(url)
    JSON.parse(res)
  end

  def fetch_jwt_token(user)
    payload = { user_id: user.id }
    JWT.encode(payload, HMAC_SECRET, 'HS256')
  end
end
