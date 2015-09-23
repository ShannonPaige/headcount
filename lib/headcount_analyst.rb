require "district_repository"

class HeadcountAnalyst
  attr_accessor :dr

  def initialize(dr)
    @dr = dr
  end

  def top_statewide_testing_year_over_year_growth(top = {:top => 1}, subject = {}, weighting = {})
    #if :top =>1 just return the score
    #if :top is > 1 return an array of all the top districts with their scores

    #if subject is a subject, return the scores for that subject
    #if subject is empty, return scores across all subjects

    #if weighting is empty, don't worry about it
    #if weighting isn't empty, then we have to take that into consideration somehow???
  end

  def kindergarten_participation_rate_variation(district_name, against)
  end

  def kindergarten_participation_against_household_income(district_name)
  end

  def kindergarten_participation_correlates_with_household_income(for = {}, across = {})
    #_Let's consider the kindergarten_participation_against_household_income and
    #set a correlation window between 0.6 and 1.5. If the result is in that range
    #then we'll say that these percentages are correlated.
    #
    # Then let's look statewide. If more than 70% of districts across the state
    #show a correlation, then we'll answer true. If it's less than 70% we'll
    #answer false.
    #
    # And let's add the ability to just consider a subset of districts.
  end

  def kindergarten_participation_against_high_school_graduation(district_name)
    # Call kindergarten variation the result of dividing the district's
    #kindergarten participation by the statewide average. Call graduation
    #variation the result of dividing the district's graduation rate by the
    #statewide average. Divide the kindergarten variation by the graduation
    #variation to find the kindergarten-graduation variance.
    #
    # If this result is close to 1, then we'd infer that the kindergarten
    #variation and the graduation variation are closely related.
  end

  def kindergarten_participation_correlates_with_high_school_graduation(for = {})
    # Let's consider the kindergarten_participation_against_high_school_graduation
    #and set a correlation window between 0.6 and 1.5. If the result is in that
    #range then we'll say that they are correlated.
  end
end
