class RegistrationsController < ApplicationController
  def new
    redirect_to dashboard_path if current_user
  end

  def create
    @user = User.new(email: params[:email].to_s.downcase, password: params[:password])

    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      flash.now[:alert] = @user.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end
end
