class RefChecksController < ApplicationController
	respond_to :html, :js
  def create
    @ref_check = RefCheck.create!(params[:ref_check])
    @referral = @ref_check.referral
    @user = @referral.referred
    respond_with @user
  end
end
