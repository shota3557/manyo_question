class Task < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true
  scope :sort_expired, -> { order(end_date: :asc) }
  scope :rank, -> { order(priority: :desc) }
  scope :status_name, -> (status){ where(status: status)}
  scope :task_name, -> (name){ where('name Like(?)', "%#{name}%") }
  enum status: { 未着手: 1, 着手中: 2, 完成: 3 }
  enum priority: { 低い: 0, 中: 1, 高い: 2 }
  belongs_to :user
  has_many :labelings, dependent: :destroy, autosave: :true
  has_many :labels, through: :labelings
end
