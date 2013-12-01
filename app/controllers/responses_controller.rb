class ResponsesController < ApplicationController
  before_filter :signed_in_user
  load_and_authorize_resource

  def index
  	@assignment = Assignment.find(params[:id])
  	@responses = @assignment.responses.order('responses.assignee.last_name ASC')
  end
end
