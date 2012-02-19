require 'test_helper'

class AnketaControllerTest < ActionController::TestCase
  setup do
    @anketum = anketa(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:anketa)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create anketum" do
    assert_difference('Anketum.count') do
      post :create, anketum: @anketum.attributes
    end

    assert_redirected_to anketum_path(assigns(:anketum))
  end

  test "should show anketum" do
    get :show, id: @anketum
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @anketum
    assert_response :success
  end

  test "should update anketum" do
    put :update, id: @anketum, anketum: @anketum.attributes
    assert_redirected_to anketum_path(assigns(:anketum))
  end

  test "should destroy anketum" do
    assert_difference('Anketum.count', -1) do
      delete :destroy, id: @anketum
    end

    assert_redirected_to anketa_path
  end
end
