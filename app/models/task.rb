class Task < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true
  scope :sort_expired, -> { order(end_date: :asc) }
  scope :rank, -> { order(priority: :desc) }
  enum status: { 未着手: 0, 着手中: 1, 完成: 2 }
  enum priority: { 低い: 0, 中: 1, 高い: 2 }
end
