# In this file we define the methods to help filter out candidates
# This way, we keep these methods separated from other potential parts of the program

require './candidates.rb'
require 'active_support/all'

def find(id)
  @candidates.detect do |c|
    c[:id] == id
  end
end

def experienced?(candidate)
  candidate[:years_of_experience] >= 2
end

def github_points?(candidate)
# More methods will go below

def qualified_candidates(candidates)
  candidates.select do |c|
    #Experienced
    xp = experienced? c
    #Github Points
    gp = c[:github_points] >= 100
    #Age
    ag = c[:age] >= 18
    #Ruby or Python
    rp = c[:languages].any? { |l| l == "Ruby" || l == "Python" }
    #Days ago
    da = c[:date_applied] >= 15.day.ago.to_date
  end
end
