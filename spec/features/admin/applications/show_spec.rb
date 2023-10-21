require "rails_helper"

RSpec.describe "the application show" do
  before :each do
    @shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @john = Application.create!(name: "John Smith", street_address: "376 Amherst Street", city: "Providence", state: "RI", zip_code: "02904", description: "I am a good person.", pet_names: "Bruno", status: "In Progress")
    @trevor = Application.create!(name: "Trevor Smith", street_address: "815 Ardsma Ave", city: "Providence", state: "RI", zip_code: "02904", description: "I am a good person.", pet_names: [], status: "In Progress")  
    @bruiser = Pet.create!(adoptable: true, age: 1, breed: "huskey", name: "Bruiser", shelter_id: @shelter.id)
    @bruno = Pet.create!(adoptable: true, age: 3, breed: "doberman", name: "Bruno", shelter_id: @shelter.id)
    @trixie = Pet.create!(adoptable: true, age: 7, breed: "pitbull", name: "Trixie", shelter_id: @shelter.id)
  end

  describe 'Admin Application Show Page' do
    # User Story 12, Approving a Pet for Adoption
    it 'has a button to approve the application for a specific pet' do
      visit "/admin/applications/#{@john.id}"

      within(@bruno.id) do
        expect(page).to have_content("Approve Adoption")
      end

      within(@bruno.id) do
        click_button("Approve Adoption")
      end

      expect(current_path).to eq('/admin/applications')

      within(@bruno.id) do
        expect(page).to_not have_content("Adopt This Pet")
      end

      expect(page).to have_content("This Adoption has been Approved")
    end
  end
end