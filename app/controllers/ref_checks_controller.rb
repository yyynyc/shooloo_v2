class RefChecksController < ApplicationController
	respond_to :html, :js
  def create
    #@user = Referral.find(params[:id]).referred
    #@user = User.find(params[:ref_check][:referrals][:referred_id])
    #@referral = current_user.reverse_referrals.find(params[:id])
    #@referral = Referral.find(params[:id])
  	#@referral = current_user.reverse_referrals.find_by_referred_id(@user.id)
  	#@ref_check = @referral.ref_checks.create!(params[:ref_check])
    @ref_check = RefCheck.create!(params[:ref_check])
    @referral = @ref_check.referral
    @user = @referral.referred
    respond_with @user
  #  @ref_seekers = current_user.referred_users.all
   # @ref_checks = @ref_seekers.collect do |r|
    #  @referral = current_user.reverse_referrals.find_by_referred_id(r)
     # @referral.ref_checks.create!(params[:ref_check])
    #end
  	#if @ref_check.save
  	 	#redirect_to root_path	
  	#end
  end

  def update
  end
end
