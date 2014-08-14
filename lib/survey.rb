class Survey < ActiveRecord::Base
  validates :name, :presence => true, :length => { :minimum => 1 }

  has_many :questions
  has_many :answers, through: :questions
  before_create :no_scrubs

private

  def no_scrubs
    if name == "scrubs"
      puts "I don't want no scrubs."
      puts "Scrub is a survey that gets no love from me."
      puts "Please enter another name."
      name = gets.chomp
    end
  end
end

