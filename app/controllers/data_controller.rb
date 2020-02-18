class DataController < ApplicationController
  require "geolocation_api"
  before_action :set_datum, only: %i{show destroy}

  def create
    @datum = Datum.create! GeolocationApi.get_geolocation(datum_params[:ip])
    render json: @datum, status: :created
  end

  def show
    render json: @datum, status: :ok
  end

  def destroy
    @datum.destroy
    head :no_content
  end

  private

  def datum_params
    params.permit(:ip).tap do |datum_params|
      datum_params.require(:ip)
    end
  end
 
  def set_datum
    @datum = Datum.find(params[:id])
  end

end
