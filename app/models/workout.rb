class Workout < ApplicationRecord
  has_many :rep_sets 
  has_many :reps, through: :rep_sets
  has_many :bio_entries

  def last_temp
    return 0 if bio_entries.empty?
    bio_entries.last.temperature
  end

  def last_hr
    return 0 if bio_entries.empty?
    bio_entries.last.heart_rate
  end

  def avg_hr
    return 0 if bio_entries.empty?
    values = bio_entries.pluck(:heart_rate)
    values.inject(:+) / values.count 
  end

  def avg_temp
    return 0 if bio_entries.empty?
    values = bio_entries.pluck(:temperature)
    values.inject(:+) / values.count 
  end

  def duration 
    return 0 if reps.empty?
    reps.last.date - reps.first.date
  end
end
