class Api::V1::SessionsController < Api::V1::BaseController # inherit from base controller

  def login
    # Recap of what needs to happen in login
    # 1 - Rails sends the code to Tencent along with app secret and app id
    # 2 - Tencent sends back user's openId
    # 3 - Find user with openId in the database; if not, create a new user with this openId
    # 4 - Send a JWT that stores user information to MP
  end
end
