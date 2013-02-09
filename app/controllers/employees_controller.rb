class EmployeesController < ApplicationController
  before_filter :authenticate_employee!, :except=> [:index, :show]
  before_filter :only_managers
  def new
    @employee = Employee.new
    @departments = Department.all
    @job_titles = JobTitle.all
    @managers = Employee.all

  end

  def index
    @employees = Employee.all
  end

  def show
    @employee = Employee.find(params[:id])
  end

  def create
    @employee = Employee.new(params[:employee])
    if @employee.save
      Notifier.welcome_email(@employee).deliver

        format.html { redirect_to(@employee, :notice => 'User was successfully created.') }
        format.json { render :json => @employee, :status => :created, :location => @employee }
    else
        format.html { render :action => "new" }
        format.json { render :json => @employee.errors, :status => :unprocessable_entity }
    end
      redirect_to @employee, notice: 'Employee was successfully created.'

  end

  def edit
    @employee = Employee.find(params[:id])
    @departments = Department.all
    @job_titles = JobTitle.all
    @managers = Employee.all
  end

  def update
    @employee = Employee.find(params[:id])

    if @employee.update_attributes(params[:employee])
      redirect_to employees_path, notice: 'Employee was updated'
    end
  end
end
