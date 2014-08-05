require 'test_helper'

class GroupSharesControllerTest < ActionController::TestCase
  setup do
    @group_share = group_shares(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:group_shares)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create group_share" do
    assert_difference('GroupShare.count') do
      post :create, group_share: { group_id: @group_share.group_id, media_id: @group_share.media_id }
    end

    assert_redirected_to group_share_path(assigns(:group_share))
  end

  test "should show group_share" do
    get :show, id: @group_share
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @group_share
    assert_response :success
  end

  test "should update group_share" do
    patch :update, id: @group_share, group_share: { group_id: @group_share.group_id, media_id: @group_share.media_id }
    assert_redirected_to group_share_path(assigns(:group_share))
  end

  test "should destroy group_share" do
    assert_difference('GroupShare.count', -1) do
      delete :destroy, id: @group_share
    end

    assert_redirected_to group_shares_path
  end
end
