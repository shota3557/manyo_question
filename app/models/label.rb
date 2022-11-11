class Label < ApplicationRecord
  has_many :tasks, through: :labelings
  has_many :labelings, dependent: :destroy, autosave: :true
end
