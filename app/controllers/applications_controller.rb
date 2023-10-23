class ApplicationsController < ApplicationController
  def new
  end
  
  def show
    @application = Application.find(params[:application_id])
    @pets = @application.pets
    if params[:search].present?
      @searched = Pet.search_for_pet(params[:search])
    end
    if params[:good_home_reason].present?
      #Show the application as "Pending"
      @application.status = "Pending"
    end
  end

  def create
    application = Application.new(application_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else 
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(application.errors)}"
    end
  end

  def update
    @application = Application.find(params[:application_id])
    selected_pet = Pet.find(params[:pet_id])
    @application.add_pet(selected_pet)
    if params[:good_home_reason] != nil
      @application.submitted = true
      redirect_to "/applications/#{application.id}"
    end
    redirect_to "/applications/#{@application.id}"
  end

  private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :pet_names, status: "In Progress", submitted: false)
  end
end
