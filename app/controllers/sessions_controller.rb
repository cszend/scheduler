class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase) unless provider = Provider.find_by(email: params[:session][:email].downcase)
    if provider and provider.authenticate(params[:session][:password])
      if provider.access == 0
        flash.now[:error] = 'Your account has been disabled. Please speak with your office\'s admin for more information.'
        render 'new'
      else
        sign_in provider, "provider"
        redirect_back_or Office.find_by(id: provider.office)
      end
    elsif user and user.authenticate(params[:session][:password])
       sign_in user, "user"
       redirect_back_or user
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
