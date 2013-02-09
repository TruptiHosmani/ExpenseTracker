class ExpenseStatesController < ApplicationController
  # GET /expense_states
  # GET /expense_states.json
  def index
    @expense_states = ExpenseState.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @expense_states }
    end
  end

  # GET /expense_states/1
  # GET /expense_states/1.json
  def show
    @expense_state = ExpenseState.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @expense_state }
    end
  end

  # GET /expense_states/new
  # GET /expense_states/new.json
  def new
    @expense_state = ExpenseState.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @expense_state }
    end
  end

  # GET /expense_states/1/edit
  def edit
    @expense_state = ExpenseState.find(params[:id])
  end

  # POST /expense_states
  # POST /expense_states.json
  def create
    @expense_state = ExpenseState.new(params[:expense_state])

    respond_to do |format|
      if @expense_state.save
        format.html { redirect_to @expense_state, notice: 'Expense state was successfully created.' }
        format.json { render json: @expense_state, status: :created, location: @expense_state }
      else
        format.html { render action: "new" }
        format.json { render json: @expense_state.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /expense_states/1
  # PUT /expense_states/1.json
  def update
    @expense_state = ExpenseState.find(params[:id])

    respond_to do |format|
      if @expense_state.update_attributes(params[:expense_state])
        format.html { redirect_to @expense_state, notice: 'Expense state was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @expense_state.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expense_states/1
  # DELETE /expense_states/1.json
  def destroy
    @expense_state = ExpenseState.find(params[:id])
    @expense_state.destroy

    respond_to do |format|
      format.html { redirect_to expense_states_url }
      format.json { head :no_content }
    end
  end
end
