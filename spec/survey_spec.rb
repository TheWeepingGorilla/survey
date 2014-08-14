require 'spec_helper'

describe 'Survey' do
  it "has many questions" do
    survey1 = Survey.create({:name => "Liquorice"})
    question1 = survey1.questions.create({:text => "Black or Red?"})
    question2 = survey1.questions.create({:text => "Soft or hard?"})
    expect(survey1.questions).to eq [question1, question2]
  end

  it "has many answers" do
    survey1 = Survey.create({:name => "Liquorice"})
    question1 = survey1.questions.create({:text => "Black or Red?"})
    question2 = survey1.questions.create({:text => "Soft or hard?"})
    answer1 = question1.answers.create({:text => "Black"})
    answer2 = question1.answers.create({:text => "Red"})
    answer3 = question2.answers.create({:text => "Soft"})
    answer4 = question2.answers.create({:text => "Hard"})
    expect(survey1.answers).to eq [answer1, answer2, answer3, answer4]
  end
end

