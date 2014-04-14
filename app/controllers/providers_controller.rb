class ProvidersController < ApplicationController

  before_action :set_office_instance_variable
  before_action :is_signed_in_provider, only: [:new, :create, :edit, :update]
  before_action :is_admin_user, only: [:new, :create]
  before_action :is_admin_user_or_self, only: [:edit, :update]
  before_action :is_listed, only: [:show]

  def show
    @provider = Provider.find(params[:id])
  end

  def new
    @provider = Provider.new
  end
	
  def create
    @provider = @office.providers.build(provider_params)
    if @provider.save
      flash[:success] = "New staff member successfully added."
      redirect_to @provider
    else
      render 'new'
    end
  end

  def edit
    @provider = Provider.find(params[:id])
  end

  def update
    if @provider.update_attributes(provider_params)
      flash[:success] = "Staff member updated"
      redirect_to @provider
    else
      render 'edit'
    end
  end

  private
    def provider_params
      if is_admin?
        params.require(:provider).permit(:email, :username, :password, :password_confirmation, :role, :access)
      else
        params.require(:provider).permit(:email, :username, :password, :password_confirmation)
      end
    end

    def is_admin?
      current_provider.office_id == @office.id and current_provider.access == 4
    end

# Before filters

    def set_office_instance_variable
      # for new and create
      if params.has_key?(:office_id)
        @office = Office.find(params[:office_id])
      # for edit, update, show and index
      else
        @provider = Provider.find(params[:id])
        @office = Office.find(@provider.office_id)
      end
    end

    def is_signed_in_provider
      set_office_instance_variable
      unless  !current_provider.nil? and current_provider.office_id == @office.id
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def is_admin_user
      unless current_provider.access == 4
        redirect_to root_url, notice: "You must be an administrator to access this page."
      end
    end

    def is_admin_user_or_self
      unless current_provider.access == 4 or current_provider.id == params[:id].to_i
        redirect_to root_url, notice: "You must be an administrator to access this page."
      end
    end

    def is_listed
      unless @office.listed == 1 and @provider.role == 2
        is_signed_in_provider
      end
    end
end
