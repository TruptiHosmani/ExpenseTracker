class ExpensesController < ApplicationController
  before_filter :authenticate_employee!, :except=> [:index]
  before_filter :only_for_managers, :only=> :review

  # GET /expenses
  # GET /expenses.json
  def index
    emp_id = current_employee.id
    if request.post?
      if (params)
        start_date = params[:start_date]
        end_date = params[:end_date]

        if params[:type] == "Approved"
          @expenses = Expense.find_by_sql("Select * from expenses where expenses.expense_state_id = 2
                                            and expenses.employee_id ='#{emp_id}' and date between
                                            '#{start_date}' and '#{end_date}' group by expenses.expense_type_id")
          #@expenses = Expense.where("expenses.expense_state_id = ? and expenses.employee_id = ?", 2, emp_id)
        elsif params[:type] == "Pending"
          @expenses = Expense.find_by_sql("Select * from expenses where expenses.expense_state_id = 1
                                          and expenses.employee_id ='#{emp_id}' and date between '#{start_date}'
                                          and '#{end_date}' group by expenses.expense_type_id")
          #@expenses = Expense.where("expenses.expense_state_id = ? and expenses.employee_id = ?", 1, emp_id)
        elsif params[:type] == "Declined"
          @expenses = Expense.find_by_sql("Select * from expenses where expenses.expense_state_id = 3
                                            and expenses.employee_id ='#{emp_id}' and date between
                                                    '#{start_date}' and '#{end_date}' group by expenses.expense_type_id")
          #@expenses = Expense.where("expenses.expense_state_id = ? and expenses.employee_id = ?", 3, emp_id)
        elsif params[:type] == "All"
          @expenses = Expense.find_by_sql("Select * from expenses where  expenses.employee_id = '#{emp_id}'
                                                     and date between '#{start_date}' and '#{end_date}' group by expenses.expense_type_id")
          #@expenses = Expense.where(" expenses.employee_id = ?", emp_id)
        end
      end

       if params[:type] == "Approved"
         @expenses = Expense.find_by_sql("Select * from expenses where expenses.expense_state_id = 2
                                            and expenses.employee_id ='#{emp_id}'  group by expenses.expense_type_id")
       elsif params[:type] == "Pending"
          @expenses = Expense.find_by_sql("Select * from expenses where expenses.expense_state_id = 1
                                          and expenses.employee_id ='#{emp_id}' group by expenses.expense_type_id")
       elsif params[:type] == "Declined"
         @expenses = Expense.find_by_sql("Select * from expenses where expenses.expense_state_id = 3
                                            and expenses.employee_id ='#{emp_id}'  group by expenses.expense_type_id")
       elsif params[:type] == "All"
         @expenses = Expense.find_by_sql("Select * from expenses where  expenses.employee_id = '#{emp_id}'
                                                      group by expenses.expense_type_id")
       end
    else
      #@expenses = Expense.all
      @expenses = current_employee.expenses
    end
  end

  # GET /expenses/1
  # GET /expenses/1.json
  def show
    @expense = Expense.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb                         .
      format.json { render json: @expense }
    end
  end

  def review
    @subordinates = current_employee.subordinates
    @expenses = {}

    if @subordinates.count > 0
      @subordinates.each do |subordinate|
        @expenses[subordinate.id] = subordinate.expenses
      end
       @data =   Expense.find_by_sql("Select expenses.employee_id as emp_id, sum(amount) as tot_amount , employees.name as emp_name
                                      from expenses inner join employees on manager_id = '#{current_employee.id}'
                                      where  expenses.employee_id = employees.id
                                       group by emp_id,emp_name")


    end
  end

  def approve
    expense = Expense.find(params[:id])

    if expense.employee.manager ==  current_employee
      if expense.amount < expense.expense_type.max_expensable     &&   expense.expense_state_id == 1  &&   expense.expense_state_id != 3
        expense.expense_state_id = 2
        expense.save!
        Notifier.expense_approved_email(expense).deliver
      else
        initial_amount = expense.amount
        expense.expense_state_id = 1
        expense.amount = expense.amount - expense.expense_type.max_expensable
        expense.save!
        Notifier.expense_max_expensable_email(initial_amount,expense).deliver
      end
    end

    redirect_to "/expenses/review"
  end

  def decline
    expense = Expense.find(params[:id])

    if expense.employee.manager ==  current_employee     &&   expense.expense_state_id == 1  &&   expense.expense_state_id != 2
      expense.expense_state_id = 3
      expense.save!
      Notifier.expense_declined_email(expense).deliver

    end

    redirect_to "/expenses/review"
  end

  # GET /expenses/new
  # GET /expenses/new.json
  def new
    @expense = Expense.new
    @employees = Employee.all
    @expense_types = ExpenseType.all
    @payment_modes = PaymentMode.all
    @vendors = Vendor.all
    @expense_states  = ExpenseState.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @expense }
    end
  end

  # GET /expenses/1/edit
  def edit
    @expense = Expense.find(params[:id])
    @employees = Employee.all
    @expense_types = ExpenseType.all
    @payment_modes = PaymentMode.all
    @vendors = Vendor.all
    @expense_states  = ExpenseState.all
     end

  # POST /expenses
  # POST /expenses.json
  def create
    # @todo get the id for pending in the right way instead of hard coding here
    @expense = Expense.new(params[:expense].merge!(:employee => current_employee, :expense_state_id => 1))

    #@ticket=@project.tickets.build(params[:ticket].merge!(:user=>current_user))

    respond_to do |format|
      if @expense.save
        format.html { redirect_to @expense, notice: 'Expense was successfully created.' }
        format.json { render json: @expense, status: :created, location: @expense }
      else
        format.html { render action: "new" }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end

  end

  # PUT /expenses/1
  # PUT /expenses/1.json
  def update
    @expense = Expense.find(params[:id])

    respond_to do |format|
      if @expense.update_attributes(params[:expense])
        format.html { redirect_to @expense, notice: 'Expense was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end

  end

  # DELETE /expenses/1
  # DELETE /expenses/1.json
  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy

    respond_to do |format|
      format.html { redirect_to expenses_url }
      format.json { head :no_content }
    end
  end
end
