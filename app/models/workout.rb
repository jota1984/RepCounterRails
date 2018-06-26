class Workout < ApplicationRecord
  has_many :rep_sets 
  has_many :reps, through: :rep_sets
end
