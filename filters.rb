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

def enough_github_points?(candidate)
  candidate[:github_points] >= 100
end

def older_than_18?(candidate)
  candidate[:age] >= 18
end

def has_required_languages?(candidate)
  candidate[:languages].any? { |l| l == "Ruby" || l == "Python" }
end

def recent_applicant?(candidate)
  candidate[:date_applied] >= 15.day.ago.to_date
end

# More methods will go below

def qualified_candidates(candidates)
  candidates.select do |c|
    experienced?(c) &&
      enough_github_points?(c) &&
      older_than_18?(c) &&
      has_required_languages?(c) &&
      recent_applicant?(c)
  end
end

def best_candidate(a,b)
  return -1 if a[:years_of_experience] > b[:years_of_experience]
  return -1 if a[:github_points] > b[:github_points]
  1
end

def ordered_by_qualifications(candidates)
  candidates.sort { |a,b| 
    best_candidate(a,b) }
end

