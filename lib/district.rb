require_relative "enrollment"
require_relative "statewide_testing"
require_relative "economic_profile"


class District
  attr_accessor :name, :data, :enrollment, :statewidetesting, :economicprofile

  def initialize(name, data)
    @name = name.upcase
    @data ||= data
    @enrollment = Enrollment.new(name, data)
    @statewidetesting = StatewideTesting.new(name, data)
    @economicprofile = EconomicProfile.new(name, data)
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
