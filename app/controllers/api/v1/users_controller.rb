class Api::V1::UsersController < Api::V1::BaseController
  skip_before_action :verify_request

  def update
    # p "====== #{@current_user} ======"
    # @current_user.update(user_params)
    @user = User.find(params[:id])
    p "===== #{@user.id} ====="
    @user.update(user_params)
    p "===== #{user_[paras]} ====="
    render json: { user: @user }
  end

  private

  def user_params
    params.require(:user).permit(:name, :open_id, :image_url)
  end
end
