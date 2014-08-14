require 'spec_helper'

describe 'Response' do
  it 'belongs to answer' do
    question1 = Question.create({:text =>"Black or Red?"})
    answer1 = question1.answers.create({:text => "Black."})
    response1 = answer1.responses.create
    expect(response1.answer_id).to eq answer1.id
  end
end
