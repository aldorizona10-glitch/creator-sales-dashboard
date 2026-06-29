class ApplicationController < ActionController::Base
  # Only allow modern browsers
  allow_browser versions: :modern

  # Mock creator for showcase — no auth yet, just hardcoded single demo creator
  before_action :load_creator

  private

  def load_creator
    @current_creator = Creator.first || Creator.create!(
      email: "demo@creator.dev",
      name: "Demo Creator",
      password: "showcase-demo-2026"
    )
  end

  # Note: inertia_shared is called automatically by inertia_rails; no need to add a before_action
end
