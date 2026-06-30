require "test_helper"

require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "GET /login page renders" do
    get login_url
    assert_response :success
  end

  test "POST /login with valid credentials creates session" do
    post login_url, params: { email: "demo@creator.dev", password: "showcase-demo-2026" }
    assert_redirected_to root_url
    assert_not_nil session[:creator_id]
  end

  test "POST /login with invalid credentials fails" do
    post login_url, params: { email: "demo@creator.dev", password: "wrong" }
    assert_redirected_to login_url
    assert_nil session[:creator_id]
  end

  test "DELETE /logout clears session" do
    # Login first
    post login_url, params: { email: "demo@creator.dev", password: "showcase-demo-2026" }
    assert_redirected_to root_url

    # Logout
    delete logout_url
    assert_redirected_to login_url
    assert_nil session[:creator_id]
  end
end