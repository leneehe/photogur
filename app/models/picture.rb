class Picture < ApplicationRecord
  belongs_to :user

  validates :artist, :url, presence: true
  validates :title, length: { in: 3..20 }
  validates :url, uniqueness: true

  scope :newest_first, -> { order("created_at DESC") }
  scope :most_recent_five, -> { newest_first.limit(5) }
  scope :created_before, -> (time) { where("created_at < ?", time) }

  def self.pictures_created_in_year(year)
    year = DateTime.new(year)
    Picture.where("created_at >= ? AND created_at <= ?", year.beginning_of_year, year.end_of_year)
  end

  def self.years_created
    years = []
    Picture.all.each do |x|
      years << x.created_at.year
      years.reverse!
    end
    return years.uniq!
  end

end
