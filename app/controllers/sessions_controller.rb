class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user
      if user.authenticate(params[:password])
        # we have a real user
        # raise params
        session[:user_id] = user.id
        redirect_to root_path
      else
        render :new
      end
    else
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end
end
