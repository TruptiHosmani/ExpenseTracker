class ReportsController < ApplicationController
  before_filter :authenticate_employee!
  #before_filter :only_for_managers

  def top_spenders
      @expenses = Expense.find_by_sql("Select sum(amount) as tot_amount, employees.name as emp_name
                        from expenses inner join employees on expenses.employee_id = employees.id
                        group by expenses.employee_id,emp_name order by tot_amount desc")
  end
  def top_vendors
    @vendors =  Expense.find_by_sql("Select sum(amount) as tot_amount, vendors.name as vendor_name
                      from expenses inner join vendors on expenses.vendor_id = vendors.id
                      group by expenses.vendor_id,vendor_name order by tot_amount desc")
  end

  def expense_by_types
    @expenses = Expense.find_by_sql("Select sum(amount) as tot_amount, expense_types.name as expense_type_name
                      from expenses inner join expense_types on expenses.expense_type_id = expense_types.id
                      group by expenses.expense_type_id,expense_type_name order by tot_amount desc")
  end

  def expense_by_an_employee
    if request.post?
      @employee_id = params[:employee_id].to_i
      start_date = params[:start_date]
      end_date = params[:end_date]



      @expenses =  Expense.find_by_sql("Select  expense_types.name, sum(amount) as tot_amount
                                        from expenses inner join expense_types on expenses.expense_type_id = expense_types.id
                                         where date between '#{start_date}' and '#{end_date}'
                                         and expenses.employee_id = #{@employee_id}
                                          group by expense_types.id")


    else
      @employees = Employee.all
    end
  end

  def departments
    @departments =  Expense.find_by_sql("Select sum(amount) as tot_amount,departments.name as dept_name, date_part('year', expenses.date) as date
                      from expenses inner join employees on employees.id = expenses.employee_id
                      inner join departments on departments.id = employees.department_id
                      group by dept_name, date order by date ,dept_name  ")

    department_expense_by_year = {}
    @departments.each do |department|
      year = department.date
      if !department_expense_by_year[year]
        department_expense_by_year[year] = []
      end

      department_expense_by_year[year] << department.tot_amount
    end

    @department_expense_data = []
    department_expense_by_year.each do |year, row|
      @department_expense_data << row.unshift(year)
    end

    logger.info(@department_expense_data)

  end

  def index

  end
end
