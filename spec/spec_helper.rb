require 'active_record'
require 'pry'
require 'rspec'

require 'answer'
require 'response'
require 'question'
require 'survey'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['test']
ActiveRecord::Base.establish_connection(development_configuration)

RSpec.configure do |config|
  config.after(:each) do
    Answer.all.each { |answer| answer.destroy }
    Response.all.each { |response| response.destroy }
    Question.all.each { |question| question.destroy }
    Survey.all.each { |survey| survey.destroy }
  end
end
