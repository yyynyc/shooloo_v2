class ReferralsController < ApplicationController
  before_filter :signed_in_user
  respond_to :html, :js

  def new
    @authorized_users = User.joins(:authorizations).where('authorizations.approval' => "accepted")
  	@referrer = @authorized_users.search(params[:q])
    @referrers = @referrer.result
  end

  def create
    @user = User.find(params[:referral][:referrer_id])
    current_user.ref_request!(@user)
    respond_with @user
  end

  def destroy
    @user = Referral.find(params[:id]).referrer
    current_user.ref_withdraw!(@user)
    respond_with @user
  end

  def index
    @ref_seekers = current_user.referred_users.all    
  end

  def update
    @referral = Referral.find(params[:id])
    @user = @referral.referred
    current_user.ref_grant!(@user)
    respond_with @user    
  end

  def decline
    @referreral = Referral.find(params[:id])
    @user = @referral.referred
    current_user.ref_decline!(@user)
    respond_with @user    
  end
end
