class Workout < ApplicationRecord
  has_many :rep_sets 
  has_many :reps, through: :rep_sets

  def duration 
    return 0 if reps.empty?
    reps.last.date - reps.first.date
  end
end
