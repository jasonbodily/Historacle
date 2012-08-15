require 'test_helper'

class ChroniclesControllerTest < ActionController::TestCase
  setup do
    @chronicle = chronicles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:chronicles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create chronicle" do
    assert_difference('Chronicle.count') do
      post :create, chronicle: { description: @chronicle.description, name: @chronicle.name, subject: @chronicle.subject, use_value1: @chronicle.use_value1, use_value2: @chronicle.use_value2, use_value3: @chronicle.use_value3, value1_title: @chronicle.value1_title, value2_title: @chronicle.value2_title, value3_title: @chronicle.value3_title }
    end

    assert_redirected_to chronicle_path(assigns(:chronicle))
  end

  test "should show chronicle" do
    get :show, id: @chronicle
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @chronicle
    assert_response :success
  end

  test "should update chronicle" do
    put :update, id: @chronicle, chronicle: { description: @chronicle.description, name: @chronicle.name, subject: @chronicle.subject, use_value1: @chronicle.use_value1, use_value2: @chronicle.use_value2, use_value3: @chronicle.use_value3, value1_title: @chronicle.value1_title, value2_title: @chronicle.value2_title, value3_title: @chronicle.value3_title }
    assert_redirected_to chronicle_path(assigns(:chronicle))
  end

  test "should destroy chronicle" do
    assert_difference('Chronicle.count', -1) do
      delete :destroy, id: @chronicle
    end

    assert_redirected_to chronicles_path
  end
end
