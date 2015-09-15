require "enrollment"

class District
  attr_accessor :district

  def name
    #return upcased name of the District
  end

  def statewide_testing
    #returns an instance of statewide testing
  end

  def enrollment
    Enrollment.new(name)
  end

end
