class RegistrationsController < ApplicationController
  def new
    render inertia: "Auth/Register", props: {}
  end

  def create
    creator = Creator.new(creator_params)

    if creator.save
      session[:creator_id] = creator.id
      redirect_to root_path, notice: "Account created"
    else
      redirect_to register_url, alert: creator.errors.full_messages.join(", ")
    end
  end

  private

  def creator_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end