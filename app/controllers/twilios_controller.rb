class TwiliosController < ApplicationController
	require 'twilio-ruby'

	@caller_id = "+17183032619"

	def index
		@user = current_user
		@client_name = @user.screen_name		
	    @account_sid = 'AC3befa29772ffe62aea9716623a5b2c69'
	    @auth_token = '5c2608f71b917c577fd4e0a5b8e20f62'
	    @client = Twilio::REST::Client.new(@account_sid, @auth_token)
	    @account = @client.account
	    @browser_call_sid = 'APd77458e133d7460e91ae10adca88b8cb'
	    @application = @account.applications.get(@browser_call_sid)	        
	    @capability = Twilio::Util::Capability.new(@account_sid, @auth_token)
	    @capability.allow_client_outgoing(@browser_call_sid)
	    @capability.allow_client_incoming(@client_name)
	    @token = @capability.generate
	    render 'twilios/index', locals: {token: @token, client_name: @client_name}, layout: false		
	end

	def browser_call
		number = params[:PhoneNumber]
		response = Twilio::TwiML::Response.new do |r|
			r.Say 'Welcome to Shooloo Live Chat. Please wait to connect.', voice: 'woman'
			r.Dial callerId: @caller_id do |d|
				if /^[\d\+\-\(\) ]+$/.match(number)
	                d.Number(CGI::escapeHTML number)
	            else
	                d.Client number
	            end
			end
		end
		render :text => response.text, :content_type => "text/xml", layout: false
	end

	def conference
		response = Twilio::TwiML::Response.new do |r|
			r.Say 'Welcome to Shooloo Community Chat', voice: 'woman'
	  		r.Dial do |d|
	    		d.Conference "#{Time.now.strftime("%b %d, %Y")}"
	  		end
		end
		render :text => response.text, :content_type => "text/xml", layout: false
	end
end