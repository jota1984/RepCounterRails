class RepSet < ApplicationRecord
  has_many :reps 
  belongs_to :workout

  def count 
    self.reps.count
  end

  def duration 
    start_time = self.reps.first.date
    end_time = self.reps.last.date
    end_time - start_time
  end
end
