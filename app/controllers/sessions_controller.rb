class SessionsController < ApplicationController
  def new
  end

  def create
    input = params[:input]
    if (input.match /.+@.+\..+/i).nil? # Check if this is in an email format
      user = User.find_by(username: input)
    else
      user = User.find_by(email: input)
    end

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
