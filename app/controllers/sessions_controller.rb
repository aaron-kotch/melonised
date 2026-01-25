class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_path, alert: "Try again later." }

  def new
  end

  def create
    respond_to do |format|
      if user = User.authenticate_by(params.permit(:email_address, :password))
        start_new_session_for user
        format.html { redirect_to after_authentication_url }
      else
        flash.now[:alert] = "Try another email address or password."
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { render turbo_stream: turbo_stream.update("flash", partial: "layouts/flash") }
      end
    end
  end

  def destroy
    terminate_session
    redirect_to new_session_path, status: :see_other
  end
end
