require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "GET /register page renders" do
    get register_url
    assert_response :success
  end

  test "POST /register with valid data creates creator" do
    post register_url, params: { name: "New Creator", email: "new@example.org", password: "secret123" }
    assert_redirected_to root_url
    assert_not_nil session[:creator_id]
    assert Creator.find_by(email: "new@example.org")
  end

  test "POST /register with invalid email" do
    post register_url, params: { name: "Bad", email: "not-an-email", password: "secret123" }
    assert_response :unprocessable_entity
    assert_nil session[:creator_id]
  end

  test "POST /register without password" do
    post register_url, params: { name: "No Password", email: "nopwd@example.org" }
    assert_response :unprocessable_entity
    assert_nil session[:creator_id]
  end
end