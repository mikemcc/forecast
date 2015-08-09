require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  setup do
    @item = items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create item" do
    assert_difference('Item.count') do
      post :create, item: { april: @item.april, august: @item.august, december: @item.december, february: @item.february, signature: @item.signature, january: @item.january, july: @item.july, june: @item.june, march: @item.march, may: @item.may, name: @item.name, november: @item.november, october: @item.october, september: @item.september, sheet_id: @item.sheet_id, user_id: @item.user_id, vendor_id: @item.vendor_id, version: @item.version }
    end

    assert_redirected_to item_path(assigns(:item))
  end

  test "should show item" do
    get :show, id: @item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @item
    assert_response :success
  end

  test "should update item" do
    patch :update, id: @item, item: { april: @item.april, august: @item.august, december: @item.december, february: @item.february, signature: @item.signature, january: @item.january, july: @item.july, june: @item.june, march: @item.march, may: @item.may, name: @item.name, november: @item.november, october: @item.october, september: @item.september, sheet_id: @item.sheet_id, user_id: @item.user_id, vendor_id: @item.vendor_id, version: @item.version }
    assert_redirected_to item_path(assigns(:item))
  end

  test "should destroy item" do
    assert_difference('Item.count', -1) do
      delete :destroy, id: @item
    end

    assert_redirected_to items_path
  end
end
