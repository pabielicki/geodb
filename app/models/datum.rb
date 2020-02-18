class Datum < ApplicationRecord
  validates_presence_of :ip, :latitude, :longitude
end
