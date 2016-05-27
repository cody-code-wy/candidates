# This is the main entrypoint into the program
# It requires the other files/gems that it needs

require 'pry'
require './candidates'
require './filters'

## Your test code can go here

# binding.pry

def puts_candidate(candidate)
  puts "Candidate ##{candidate[:id]} has #{candidate[:years_of_experience]} years of experience, and #{candidate[:github_points]} github points. they know #{candidate[:languages].join(", ")}. They applied on #{candidate[:date_applied]}. They are aged #{candidate[:age]}."
end

def repl()
  puts "You can say quit, qualified, all, or find id#"
  while true do
    user = gets.chomp.strip.downcase
    case user
      when /^find \d*$/
        id = user.split(" ")[1].to_i
        candidate = find(id)
        if candidate
          puts_candidate(candidate)
        else
          puts "Candidate #{id} does not exist"
        end
      when "all"
        @candidates.each { |c| puts_candidate(c) }
      when "qualified"
        qualified = ordered_by_qualifications(qualified_candidates(@candidates)) 
        qualified.each { |c| puts_candidate(c) }
      when "quit"
        break
      else
        puts "I dont understand \"#{user}\", you can say quit, qualified, all, or find id#"
      end
  end
end

repl()
