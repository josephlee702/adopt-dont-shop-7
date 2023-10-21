require "rails_helper"

RSpec.describe "admin#shelters" do
  before :each do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
    @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    @shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @shelter_3.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
    @bruno = Pet.create!(adoptable: true, age: 3, breed: "doberman", name: "Bruno", shelter_id: @shelter_1.id)
    @john = Application.create!(name: "John Smith", street_address: "376 Amherst Street", city: "Providence", state: "RI", zip_code: "02904", description: "I am a good person.", pet_names: [@bruno.name], status: "Pending")
  end

  describe 'Admin Shelters#index' do
    # User Story 10, Admin Shelters Index (SQL ONLY)
    it 'shows all Shelters in the system listed in reverse alphabetical order by name' do
      visit '/admin/shelters'
      expect(@shelter_2.name).to appear_before(@shelter_3.name)
      expect(@shelter_3.name).to appear_before(@shelter_1.name)
    end
  end

  # User Story 11, Shelters with Pending Applications (ACTIVERECORD ONLY)
  it 'shows the name of every shelter that has a pending application' do
    visit '/admin/shelters'
    save_and_open_page

    expect(page).to have_content("Shelters with Pending Applications")
    expect("Shelters with Pending Applications").to appear_before(@shelter_1.name)
    expect("Shelters with Pending Applications").to_not appear_before(@shelter_2.name)
    expect("Shelters with Pending Applications").to_not appear_before(@shelter_3.name)
  end
end