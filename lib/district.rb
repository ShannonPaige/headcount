require "enrollment"

class District
  attr_accessor :district_name

  def initialize(district_name)
    @district_name = district_name
  end

  def name
    #return upcased name of the District
    name.upcase
  end

  def statewide_testing
    StatewideTesting.new
  end

  def enrollment
    Enrollment.new(name)
  end

end
