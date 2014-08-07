require 'test_helper'

class GroupsControllerTest < ActionController::TestCase
  setup do
    @user_group = groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create group" do
    assert_difference('Group.count') do
      post :create, group: { group_name: @user_group.group_name, user_id: @user_group.user_id }
    end

    assert_redirected_to group_path(assigns(:group))
  end

  test "should show group" do
    get :show, id: @user_group
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_group
    assert_response :success
  end

  test "should update group" do
    patch :update, id: @user_group, group: { group_name: @user_group.group_name, user_id: @user_group.user_id }
    assert_redirected_to group_path(assigns(:group))
  end

  test "should destroy group" do
    assert_difference('Group.count', -1) do
      delete :destroy, id: @user_group
    end

    assert_redirected_to groups_path
  end
end
