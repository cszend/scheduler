module SessionsHelper
  def sign_in(user, user_type)
    if user_type == "provider"
      remember_token = Provider.new_remember_token
      cookies.permanent[:remember_token] = remember_token
      user.update_attribute(:remember_token, Provider.hash(remember_token))
      self.current_provider = user
    elsif user_type == "user"
      remember_token = User.new_remember_token
      cookies.permanent[:remember_token] = remember_token
      user.update_attribute(:remember_token, User.hash(remember_token))
      self.current_user = user
    end
  end  
	
  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end
	
  def current_user
    remember_token = User.hash(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end
	
  def current_user?(user)
    user == current_user
  end
	
  def signed_in_provider?
    !current_provider.nil?
  end

  def current_provider=(provider)
    @current_provider = provider
  end
	
  def current_provider
    remember_token = Provider.hash(cookies[:remember_token])
    @current_provider ||= Provider.find_by(remember_token: remember_token)
  end
	
  def current_provider?(provider)
    provider == current_provider
  end

  def has_access_level?(min, requested_office_id)
    current_provider.access >= min and current_provider.office_id == requested_office_id
  end

  def sign_out
    if current_provider.respond_to?('update_attribute')
      current_provider.update_attribute(:remember_token, Provider.hash(Provider.new_remember_token))
      self.current_provider = nil
    elsif current_user.respond_to?('update_attribute')
      current_user.update_attribute(:remember_token, User.hash(User.new_remember_token))
      self.current_user = nil
    end
    cookies.delete(:remember_token)
  end
	
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end
end
