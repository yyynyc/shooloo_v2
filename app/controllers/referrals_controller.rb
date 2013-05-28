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
    if @referral.save
      respond_with @referrals
    else
      flash[:error] = "Something is wrong!"
      respond_with @referrals
    end    
  end
end
