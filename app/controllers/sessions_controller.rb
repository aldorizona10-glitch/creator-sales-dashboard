class SessionsController < ApplicationController
  # Inertia page — login form
  def new
    render inertia: "Auth/Login", props: {}
  end

  # Create session — authenticate + set session cookie
  def create
    creator = Creator.find_by(email: params[:email])

    if creator&.authenticate(params[:password])
      session[:creator_id] = creator.id
      redirect_to root_path, notice: "Signed in"
    else
      redirect_to login_url, alert: "Invalid email or password"
    end
  end

  # Destroy session — logout
  def destroy
    session[:creator_id] = nil
    redirect_to login_url, notice: "Signed out"
  end
end