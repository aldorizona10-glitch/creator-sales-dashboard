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
      render inertia: "Auth/Register",
             props: { errors: creator.errors.to_hash(true) },
             status: :unprocessable_entity
    end
  end

  private

  def creator_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
