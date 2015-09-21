require_relative "enrollment"
require_relative "statewide_testing"
require_relative "economic_profile"


class District
  attr_accessor :district_name, :data, :enrollment, :statewidetesting, :economicprofile

  def initialize(district_name, data)
    # require 'pry'; binding.pry
    @district_name = district_name
    @data ||= data
    @enrollment = Enrollment.new(district_name, data)
    @statewidetesting = StatewideTesting.new(district_name, data)
    @economicprofile = EconomicProfile.new(district_name, data)
  end

  # Enrollment = @enrollment
  # StatewideTesting = @statewidetesting
  # EconomicProfile = @economicprofile

  def self.name(district_name)
    district_name.upcase
  end

  def economic_profile
    @economicprofile
  end

  def statewide_testing
    @statewidetesting
  end

  def enrollment
    @enrollment
  end
end
