require 'rails_helper'

RSpec.describe Datum, type: :model do
  it { should validate_presence_of(:ip)}
  it { should validate_presence_of(:latitude)}
  it { should validate_presence_of(:longitude)}
end
