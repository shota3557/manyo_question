class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, length: { minimum: 6 }

  before_validation { email.downcase! }
  has_secure_password
  has_many :tasks, dependent: :destroy
  before_destroy :must_not_destroy_last_one_admin

  private

  def must_not_destroy_last_one_admin
    throw(:abort) if self.admin
  end
end
