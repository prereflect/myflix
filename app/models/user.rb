class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :full_name, presence: true
  validates :password, presence: true

  has_secure_password validations: false

  has_many :queue_items, -> { order('position') }

  def new_queue_item_position
    queue_items.count + 1
  end

  def already_queued?(video)
    queue_items.map(&:video).include?(video)
  end

  def normalize_queue_positions
    queue_items.each_with_index do |queue_item, index|
      queue_item.update_attributes(position: index + 1)
    end
  end
end
