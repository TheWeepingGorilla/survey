class Question < ActiveRecord::Base
  belongs_to :survey
  has_many   :answers
  has_many :responses, through: :answers

  def response_stats
    stats = []
    self.answers.each do |answer|
      count = 0
      answer.responses.each do |response|
        count +=1
      end
      stats << count
    end
    stats
  end

  def total(stats)
    stat_total = 0
    stats.each {|stat| stat_total += stat}
    stat_total.to_f
  end

  def percentage(stats,total)
    percentages = []
    stats.each do |stat|
      percentages << ((stat / total) * 100).to_i
    end
    percentages
  end

end
