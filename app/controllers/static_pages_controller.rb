class StaticPagesController < ApplicationController
  def home
    @offices = Office.where({:listed => 1, :status => 4})
  end

  def contact
  end

  def pricing
  end

	def about
  end
end
