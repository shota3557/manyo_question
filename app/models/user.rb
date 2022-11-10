class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, length: { minimum: 6 }

  before_validation { email.downcase! }
  has_secure_password
  has_many :tasks, dependent: :destroy
  before_destroy :admin_cannot_delete
  before_update :admin_cannot_update

  private

  def admin_cannot_delete
    throw :abort if User.where(admin: true).count == 1 && self.admin == true
  end

  def admin_cannot_update
    throw :abort if User.where(admin: true).count == 1 && self.admin_change_to_be_saved == [true, false]
  end
end