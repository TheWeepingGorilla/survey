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
    puts "1) Multiple Choice"
    puts "2) Multiple Selection"
    puts "3) Open-ended\n"
    puts "Enter question type ID:"
    q_type = gets.chomp.to_i
    puts "Enter question:"
    q_text = gets.chomp.capitalize
    question = new_survey.questions.create({text: q_text, q_type: q_type})
    if q_type == 1 || q_type == 2
      a_choice = ""
      until a_choice == "N"
        puts "Enter a potential answer:"
        a_text = gets.chomp.capitalize
        answer = question.answers.create({text: a_text})
        puts "Add another answer? (Y/N)"
        a_choice = gets.chomp.upcase
      end
      question.answers.create({text: "Other"})
    else
      answer = question.answers.create({text: ""})
    end
    puts "Add another question? (Y/N)"
    choice = gets.chomp.upcase
  end
  puts "Survey #{new_survey.name} has been created."
  puts "High Five! Press RETURN to continue..."
  gets
end

def take_survey
  list_surveys
  puts "Choose survey id to take that survey:"
  choice = gets.chomp.to_i
  survey = Survey.find(choice)
  survey.questions.each do |question|
    puts question.text
    choice_x = ""
    until (choice_x == "N")
      if (question.q_type == 1) || (question.q_type == 2)
        question.answers.each {|answer| puts "#{answer.id}: #{answer.text}"}
        puts "Select answer id:"
        answer = Answer.find(gets.chomp.to_i)
        if answer.text == "Other"
          puts "Please enter your response:"
          answer.responses.create({:text => gets.chomp})
        else
          answer.responses.create
        end
      elsif (question.q_type == 3)
        puts "Please enter answer:"
        answer = question.answers.first
        answer.responses.create({text: gets.chomp})
      end
      if (question.q_type == 2)
        puts "Add another answer? (Y/N)"
        choice_x = gets.chomp.upcase
      else
        choice_x = "N"
      end
    end
  end
  puts "Thanks for taking the survey!"
  puts "High Five! Press RETURN to continue..."
  gets
end

def survey_stats
  list_surveys
  puts "What survey would you like to see stats for?"
  choice = gets.chomp.to_i
  survey = Survey.find(choice)
  survey.questions.each do |question|
    puts "\n"
    puts "For Question \##{question.id}: #{question.text}"
    if question.q_type == 3
      answer = question.answers.first
      answer.responses.each {|response| puts response.text}
    else
      stats = question.response_stats
      total = question.total(stats)
      percentages = question.percentage(stats,total)
      question.answers.each do |answer|
        puts "  #{answer.id.to_s}: #{answer.text}"
        puts "    Number : #{stats.shift.to_s}"
        puts "    Percent: #{percentages.shift.to_s}%"
        if answer.text == "Other"
          answer.responses.each {|response| puts "      #{response.text}"}
        end
      end
    end
  end
  puts "\n"
  puts "High Five! Press RETURN to continue..."
  gets
end

def list_surveys
  puts "Survey List:"
  Survey.all.each do |survey|
    puts "#{survey.id} : #{survey.name}"
  end
  puts "\n"
end

main_menu
