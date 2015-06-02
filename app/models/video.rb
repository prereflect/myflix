class Video < ActiveRecord::Base
  belongs_to :category

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true

  def self.search_by_title(search_term)
    return [] if search_term.blank?
    video = Video.arel_table
    Video.where(video[:title].matches("%#{search_term}%")).order(created_at: :desc)
  end
end
