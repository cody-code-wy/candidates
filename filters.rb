# In this file we define the methods to help filter out candidates
# This way, we keep these methods separated from other potential parts of the program

require 'active_support/all'

def find(id)
  raise ArgumentError, "Expected fixnum got #{id.class}" unless id.class == "fixnum"
  raise "@candidates must be an array" if @candidates.nil?
  @candidates.detect do |c|
    c[:id] == id
  end
end

def experienced?(candidate)
  raise ArgumentError, "Candidate must have :years_of_experience" unless candidate.has_key?(:years_of_experience)
  candidate[:years_of_experience] >= 2
end

def enough_github_points?(candidate)
  raise ArgumentError, "Candidate must have :github_points" unless candidate.has_key?(:github_points)
  candidate[:github_points] >= 100
end

def older_than_18?(candidate)
  raise ArgumentError, "Candidate must have :age" unless candidate.has_key?(:age)
  candidate[:age] >= 18
end

def has_required_languages?(candidate)
  raise ArgumentError, "Candidate must have :languages" unless candidate.has_key?(:languages)
  candidate[:languages].any? { |l| l == "Ruby" || l == "Python" }
end

def recent_applicant?(candidate)
  raise ArgumentError, "Candidate must have :date_applied" unless candidate.has_key?(:date_applied)
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
  raise ArgumentError, "Candidate A must have :years_of_experience" unless a.has_key?(:years_of_experience)
  raise ArgumentError, "Candidate A must have :github_points" unless a.has_key?(:github_points)
  raise ArgumentError, "Candidate B must have :years_of_experience" unless b.has_key?(:years_of_experience)
  raise ArgumentError, "Candidate B must have :github_points" unless b.has_key?(:github_points)
  return -1 if a[:years_of_experience] > b[:years_of_experience]
  return -1 if a[:github_points] > b[:github_points]
  1
end

def ordered_by_qualifications(candidates)
  candidates.sort { |a,b| 
    best_candidate(a,b) }
end

