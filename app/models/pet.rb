class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :application_pets
  has_many :applications, through: :application_pets

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  # def self.pets_with_pending_apps
  #   Pet.select("pets.*").joins([:applications]).where("applications.status = 'pending'").distinct
  # end
end
