class OfficesController < ApplicationController

  around_filter :user_time_zone, only: [:show]

  def show
    @office = Office.find(params[:id])
  end

  def new
    @office = Office.new
    @office.providers.build
  end
	
  def create
    @office=Office.new(office_params)
    if @office.save
      @office.providers.first.update_attribute(:access, 4)
      sign_in @office.provider, "provider"
      flash[:success] = "Welcome to your new Scheduling Assistant!"
      redirect_to @office
    else
      render 'new'
    end
  end
  
  def edit
    @office = current_provider.office
  end

  def update
    if @office.update_attributes(user_params)
      flash[:success] = "Office updated"
      redirect_to @office
    else
      render 'edit'
    end
  end
	
  private
    def office_params
      params.require(:office).permit(:name, :time_zone, :listed, :street, :city, :state, :zip, :phone, :email, :hours, :description, :category, :status, providers_attributes: [:email, :office, :username, :role, :password, :password_confirmation])
    end

    def user_time_zone(&block)
      Time.use_zone(Office.find(params[:id]).time_zone, &block)
    end

end
