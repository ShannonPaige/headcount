class EconomicProfile
  attr_accessor :district_name, :data

  def initialize(district_name, data)
    # An instance this class can be initialized by supplying the name of the
    #district which is then used to find the matching data in the data files.
    @district_name = district_name
    @data ||= data
  end

  def free_or_reduced_lunch_by_year
    #not truncating or sorting low to high
    new_hash = data[:students_qualifying_for_free_or_reduced_price_lunch_by_percentage]["Eligible for Free or Reduced Lunch"]
    truncated_hash = new_hash.map do |hash|
      return_percent = '%.3f' % hash[1]
      [hash[0], return_percent.to_f]
    end
    truncated_hash.reverse.to_h
  end

  def free_or_reduced_lunch_in_year(year)
    year_eligible = data[:students_qualifying_for_free_or_reduced_price_lunch_by_percentage]["Eligible for Free or Reduced Lunch"][2012]
    year_eligible = '%.3f' % year_eligible
    year_eligible.to_f
  end

  def school_aged_children_in_poverty_in_year(year)
    poverty_by_year = data[:school_aged_children_in_poverty_by_percentage][year]
    # poverty_by_year = '%.3f' % poverty_by_year
    # poverty_by_year.to_f
  end

  def title_1_students
    title_1 = data[:title_i_students]
    truncated_hash = title_1.map do |hash|
      [hash[0], hash[1]]
    end
    truncated_hash.to_h
  end

  def title_1_students_in_year(year)
    data[:title_i_students][year]
  end

end
