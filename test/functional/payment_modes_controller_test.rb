require 'test_helper'

class PaymentModesControllerTest < ActionController::TestCase
  setup do
    @payment_mode = payment_modes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:payment_modes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create payment_mode" do
    assert_difference('PaymentMode.count') do
      post :create, payment_mode: @payment_mode.attributes
    end

    assert_redirected_to payment_mode_path(assigns(:payment_mode))
  end

  test "should show payment_mode" do
    get :show, id: @payment_mode
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @payment_mode
    assert_response :success
  end

  test "should update payment_mode" do
    put :update, id: @payment_mode, payment_mode: @payment_mode.attributes
    assert_redirected_to payment_mode_path(assigns(:payment_mode))
  end

  test "should destroy payment_mode" do
    assert_difference('PaymentMode.count', -1) do
      delete :destroy, id: @payment_mode
    end

    assert_redirected_to payment_modes_path
  end
end
