require_relative "enrollment"

class District
  attr_accessor :district_name, :data, :enrollment, :statewidetesting

  def initialize(district_name, data)
    @district_name = district_name
    @data = data
    @enrollment = Enrollment.new(district_name, data)
    @statewidetesting = StatewideTesting.new(district_name, data)
  end

  def self.name(district_name)
    district_name.upcase
  end

  def statewide_testing
    @statewidetesting
  end

  def enrollment
    @enrollment
  end
end
