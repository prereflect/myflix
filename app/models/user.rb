class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :full_name, presence: true
  validates :password, presence: true

  has_secure_password validations: false

  has_many :queue_items

  def new_queue_item_position
    queue_items.count + 1
  end

  def already_queued?(video)
    queue_items.map(&:video).include?(video)
  end
end
