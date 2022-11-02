class Task < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true
  scope :sort_expired, -> { order(end_date: :asc) }
  enum status: { 未着手: 1, 着手中: 2, 完成: 3 }
end
