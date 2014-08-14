require 'spec_helper'

describe 'Answer' do
  it 'belongs to question' do
    question1 = Question.create({:text => "Black or Red?"})
    answer1 = question1.answers.create({:text => "Black, of course."})
    expect(answer1.question_id).to eq question1.id
  end
end
