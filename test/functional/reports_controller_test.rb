require 'test_helper'

class ReportsControllerTest < ActionController::TestCase
  setup do
    @report = reports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create report" do
    assert_difference('Report.count') do
      post :create, report: { abuseType: @report.abuseType, address: @report.address, block: @report.block, description: @report.description, email: @report.email, groundId: @report.groundId, lat: @report.lat, lng: @report.lng, name: @report.name, otherGroundDescription: @report.otherGroundDescription, otherGroundName: @report.otherGroundName, phone: @report.phone, recordId: @report.recordId, reportDate: @report.reportDate, row: @report.row, seat: @report.seat }
    end

    assert_redirected_to report_path(assigns(:report))
  end

  test "should show report" do
    get :show, id: @report
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @report
    assert_response :success
  end

  test "should update report" do
    put :update, id: @report, report: { abuseType: @report.abuseType, address: @report.address, block: @report.block, description: @report.description, email: @report.email, groundId: @report.groundId, lat: @report.lat, lng: @report.lng, name: @report.name, otherGroundDescription: @report.otherGroundDescription, otherGroundName: @report.otherGroundName, phone: @report.phone, recordId: @report.recordId, reportDate: @report.reportDate, row: @report.row, seat: @report.seat }
    assert_redirected_to report_path(assigns(:report))
  end

  test "should destroy report" do
    assert_difference('Report.count', -1) do
      delete :destroy, id: @report
    end

    assert_redirected_to reports_path
  end
end
