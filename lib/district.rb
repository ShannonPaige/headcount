require_relative "enrollment"
# require "pry"

class District
  attr_accessor :district_name, :data

  def initialize(district_name, data)
    @district_name = district_name
    @data = data
  end

  # def name
  #   #return upcased name of the District
  #   name.upcase
  # end

  def statewide_testing
    StatewideTesting.new
  end

  def enrollment
    Enrollment.new(district_name, data.fetch(:pupil_enrollment))
  end



end
