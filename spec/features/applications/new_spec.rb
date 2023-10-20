require 'rails_helper'

RSpec.describe "new application" do

  describe 'application new page' do
    # User Story 2, Starting an Application
    it 'it will show a new application for the user to fill out' do
      application = Application.create!(name: "John Smith", street_address: "376 Amherst Street", city: "Providence", state: "RI", zip_code: "02904", description: "I am a good person.", pet_names: "Bruno", status: "In Progress")
      
      visit '/applications/new'
      expect(page).to have_content("Name")
      expect(page).to have_content("Street address")
      expect(page).to have_content("City")
      expect(page).to have_content("State")
      expect(page).to have_content("Zip code")
      expect(page).to have_content("Description")
      
      fill_in("Name", with: "Arthur")
      fill_in("Street address", with: "108 Clay St")
      fill_in("City", with: "Hialeah")
      fill_in("State", with: "FL")
      fill_in("Zip code", with: "33010")
      fill_in("Description", with: "I would like a dog")
      click_button("Submit")

      visit '/applications'
      
      expect(page).to have_content("Arthur")
      expect(page).to have_content("108 Clay St Hialeah FL 33010")
      expect(page).to have_content("I would like a dog")
      expect(page).to have_content("In Progress")
    end
    
    # User Story 3, Starting an Application, Form not Completed
    it 'will not let me submit form if fields not filled' do
      visit '/applications/new'

      fill_in("Name", with: "Arthur")
      fill_in("Street address", with: "108 Clay St")
      fill_in("City", with: "Hialeah")
      fill_in("State", with: "FL")
      fill_in("Zip code", with: "33010")

      click_button("Submit")

      expect(current_path).to eq('/applications/new')
      expect(page).to have_content("You must fill in all fields.")
    end
  end
end