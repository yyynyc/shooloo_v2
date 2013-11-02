class ErrorsController < ApplicationController

	def show
		@exception = env["action_dispatch.exception"]
		respond_to do |format|
			format.html { render action: request.path[1..-1] }
			format.json { render json: {status: request.path[1..-1], error: @exception.message} }
		end
	end
	# def error_404
	#     @not_found_path = params[:not_found]
	# end
	 
	# def error_500
	# end
end
