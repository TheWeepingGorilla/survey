require 'spec_helper'

describe 'Question' do
  it 'has many answers' do
    question1 = Question.create({:text => "Black or Red?"})
    question2 = Question.create({:text => "Soft or hard?"})
    answer1 = question1.answers.create({:text => "Black"})
    answer2 = question1.answers.create({:text => "Red"})
    answer3 = question2.answers.create({:text => "Soft"})
    answer4 = question2.answers.create({:text => "Hard"})
    expect(question1.answers).to eq [answer1, answer2]
    expect(question2.answers).to eq [answer3, answer4]
  end

  it 'belongs to survey' do
    survey1 = Survey.create({:name => "Liquorice"})
    question1 = survey1.questions.create({:text => "Black or Red?"})
    expect(question1.survey_id).to eq survey1.id
  end
  it 'has many responses (via answers)' do
    question1 = Question.create({:text => "Black or Red?"})
    answer1 = question1.answers.create({:text => "Black"})
    answer2 = question1.answers.create({:text => "Red"})
    response1 = answer1.responses.create
    response2 = answer2.responses.create
    expect(question1.responses).to eq [response1, response2]
  end
end
