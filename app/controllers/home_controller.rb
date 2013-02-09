class HomeController < ApplicationController
  def index

  end
  def edit
    @current_employee= current_employee
  end

end