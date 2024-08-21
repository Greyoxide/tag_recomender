class Api::TagRecomendationsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def create
    service = TagRecomendationService.new(params[:name], params[:description])
    render json: service.request_tags
  end

end