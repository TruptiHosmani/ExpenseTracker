require 'test_helper'

class ExpenseStatesControllerTest < ActionController::TestCase
  setup do
    @expense_state = expense_states(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:expense_states)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create expense_state" do
    assert_difference('ExpenseState.count') do
      post :create, expense_state: @expense_state.attributes
    end

    assert_redirected_to expense_state_path(assigns(:expense_state))
  end

  test "should show expense_state" do
    get :show, id: @expense_state
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @expense_state
    assert_response :success
  end

  test "should update expense_state" do
    put :update, id: @expense_state, expense_state: @expense_state.attributes
    assert_redirected_to expense_state_path(assigns(:expense_state))
  end

  test "should destroy expense_state" do
    assert_difference('ExpenseState.count', -1) do
      delete :destroy, id: @expense_state
    end

    assert_redirected_to expense_states_path
  end
end
