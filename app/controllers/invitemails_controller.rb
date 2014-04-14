class InvitemailsController < ApplicationController
	before_filter :signed_in_user
	respond_to :html, :js
  
  def new
  	@invitemail = Invitemail.new
  end

  def create
  	@invitemail = current_user.invitemails.build(params[:invitemail])
  	if @invitemail.save
      flash[:success] = "Email sent successfully! When your fellow educator joins Shooloo, both of you will get 10 points towards getting an Advocacy Prize!"
      redirecct_back_or root_path
      # respond_to do |format|
	    # 	format.html {redirect_to root_url }
	    #     format.js {}
	    # end
    else 
      render 'new'
      # render :js => "alert('You need to add an email address before sending!');"   
    end            
  end
end
