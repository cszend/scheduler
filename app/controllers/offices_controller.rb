class OfficesController < ApplicationController
	
  before_action :is_signed_in_provider, only: [:edit, :update]
  before_action :is_admin_user,   only: [:edit, :update]
  before_action :is_listed,   only: [:show]
#  before_action :status_is_pending, only: [:create]

  around_filter :user_time_zone, only: [:show]

  def show
    @office = Office.find(params[:id])
    @providers = @office.providers.where(role: 2)
  end

  def new
    @office = Office.new
    @office.providers.build
  end
	
  def create
    @office=Office.new(office_create_params)
      if params[:office][:status].to_i != 2
        redirect_to root_url, notice: "You cannot alter the status of the office until after it has been created."
      else
        if @office.save
          @office.providers.first.update_attribute(:access, 4)
          sign_in @office.providers.first, "provider"
          flash[:success] = "Welcome to your new Scheduling Assistant!"
          redirect_to @office
        else
          render 'new'
        end
      end
  end
  
  def edit
    @office = Office.find(params[:id])
  end

  def update
    @office = Office.find(params[:id])
    old_status = @office.status
    if @office.update_attributes(office_update_params)
      if (0..2).member?(old_status)
        if old_status == params[:office][:status].to_i
  	  status_ok = "yes"
	else
          status_ok = "no"
        end
      elsif (3..4).member?(old_status)
        if (3..4).member?(params[:office][:status].to_i) or params[:office][:status].to_i == 0
  	  status_ok = "yes"
	else
          status_ok = "no"
        end
      end
      if status_ok == "no"
        @office.reload
	@office.update_attribute(:status, old_status)
	message_addendum = "- But invalid option for status was ignored!"
      end
      flash[:success] = "Office updated #{message_addendum}"
      redirect_to @office
    else
      flash[:error] = "Changes could not be saved."
      render 'edit'
    end
  end
	
  private
    def office_update_params
      if is_admin?
        params.require(:office).permit(:name, :time_zone, :street, :city, :state, :zip, :phone, :email, :hours, :description, :category, :listed, :status)
      else
        params.require(:office).permit(:name, :time_zone, :street, :city, :state, :zip, :phone, :email, :hours, :description, :category)
      end
    end

    def office_create_params
      params.require(:office).permit(:name, :time_zone, :listed, :street, :city, :state, :zip, :phone, :email, :hours, :description, :category, :status, providers_attributes: [:email, :office, :username, :role, :password, :password_confirmation])
    end

    def is_admin?
      @office = Office.find(params[:id])
      current_provider.office == @office and current_provider.access == 4
    end

    def user_time_zone(&block)
      Time.use_zone(Office.find(params[:id]).time_zone, &block)
    end

# Before filters

    def is_signed_in_provider
      @office = Office.find(params[:id])
      unless  !current_provider.nil? and current_provider.office == @office
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def is_admin_user
      @office = Office.find(params[:id])
      unless current_provider.access == 4
        redirect_to root_url, notice: "You must be an administrator to access this page."
      end
    end

    def is_listed
      @office = Office.find(params[:id])
      unless @office.listed == 1 
        is_signed_in_provider
      end
    end

    def is_active
      @office = Office.find(params[:id])
      unless @office.status == 4 
        redirect_to root_url, notice: "Account is not active."
      end
    end
end
