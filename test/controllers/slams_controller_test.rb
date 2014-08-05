require 'test_helper'

class SlamsControllerTest < ActionController::TestCase
  setup do
    @slam = slams(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:slams)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create slam" do
    assert_difference('Slam.count') do
      post :create, slam: { media_id_first_id: @slam.media_id_first_id, media_id_second_id: @slam.media_id_second_id }
    end

    assert_redirected_to slam_path(assigns(:slam))
  end

  test "should show slam" do
    get :show, id: @slam
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @slam
    assert_response :success
  end

  test "should update slam" do
    patch :update, id: @slam, slam: { media_id_first_id: @slam.media_id_first_id, media_id_second_id: @slam.media_id_second_id }
    assert_redirected_to slam_path(assigns(:slam))
  end

  test "should destroy slam" do
    assert_difference('Slam.count', -1) do
      delete :destroy, id: @slam
    end

    assert_redirected_to slams_path
  end
end
