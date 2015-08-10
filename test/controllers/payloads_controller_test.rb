require 'test_helper'

class PayloadsControllerTest < ActionController::TestCase
  setup do
    @payload = payloads(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:payloads)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create payload" do
    assert_difference('Payload.count') do
      post :create, payload: { contents: @payload.contents, user_id: @payload.user_id }
    end

    assert_redirected_to payload_path(assigns(:payload))
  end

  test "should show payload" do
    get :show, id: @payload
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @payload
    assert_response :success
  end

  test "should update payload" do
    patch :update, id: @payload, payload: { contents: @payload.contents, user_id: @payload.user_id }
    assert_redirected_to payload_path(assigns(:payload))
  end

  test "should destroy payload" do
    assert_difference('Payload.count', -1) do
      delete :destroy, id: @payload
    end

    assert_redirected_to payloads_path
  end
end
