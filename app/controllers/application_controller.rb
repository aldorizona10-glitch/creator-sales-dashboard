class ApplicationController < ActionController::Base
  # Only allow modern browsers
  allow_browser versions: :modern

  # Mock creator for showcase — no auth yet, just hardcoded single demo creator
  before_action :load_current_creator

  private

  def load_current_creator
    if session[:creator_id]
      @current_creator = Creator.find_by(id: session[:creator_id])
    end
    # Fallback untuk demo — login page tidak redirect kalau belum login
    @current_creator ||= Creator.first
  end

  # Note: inertia_shared is called automatically by inertia_rails; no need to add a before_action
end
