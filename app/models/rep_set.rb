class RepSet < ApplicationRecord
  has_many :reps 
  belongs_to :workout

  def count 
    self.reps.count
  end

  def duration 
    end_time - start_time
  end

  def start_time 
    self.reps.first.date
  end

  def end_time 
    self.reps.last.date
  end
end
