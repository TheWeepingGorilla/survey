require 'active_record'
require './lib/answer'
require './lib/question'
require './lib/survey'
require './lib/response'

database_configurations = YAML::load(File.open('./db/config.yml'))
test_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(test_configuration)

def header
  system 'clear'
  puts "*" * 50
  puts "Super Survey Taker 5000"
  puts "*" * 50
  puts "\n"
end

def main_menu
  header
  puts "E > Exit"
  puts "A > Add a survey"
  puts "T > Take a survey"
  puts "S > Survey stats"
  choice = gets.chomp.upcase
  case choice
  when 'A'
    add_survey
  when 'T'
    take_survey
  when 'S'
    survey_stats
  when 'E'
    puts "Have an excellent day!"
    exit
  else
    puts 'Invalid input. Try again.'
  end
  main_menu
end


def add_survey
  choice = ""
  puts "Please enter name of new survey:"
  new_survey_name = gets.chomp
  new_survey = Survey.create({:name => new_survey_name})
  until choice == 'N'
    puts "Enter question:"
    q_text = gets.chomp.capitalize
    question = new_survey.questions.create({text: q_text})
    a_choice = ""
    until a_choice == "N"
      puts "Enter a potential answer:"
      a_text = gets.chomp.capitalize
      answer = question.answers.create({text: a_text})
      puts "Add another answer? (Y/N)"
      a_choice = gets.chomp.upcase
    end

    puts "Add another question? (Y/N)"
    choice = gets.chomp.upcase
  end
  puts "Survey #{new_survey.name} has been created."
  puts "High Five! Press RETURN to continue..."
  gets
  main_menu
end

def take_survey
end

def survey_stats
end

def list_surveys
end

main_menu
