class Admin::SheltersController < ApplicationController
  def index
    if "All Shelters".present?
      @shelters = Shelter.order_reverse_alphabetical
    elsif "Shelters with Pending Applications".present?
      @shelters = Shelter.shelter_with_pending_apps
    end
  end

  private

  def shelter_params
    params.permit(:id, :name, :city, :foster_program, :rank)
  end
end