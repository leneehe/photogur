class Picture < ApplicationRecord

  def self.newest_first
    Picture.order("created_at DESC")
  end

  def self.most_recent_five
    Picture.newest_first.limit(5)
  end

  def self.created_before(time)
    Picture.where("created_at < ?", time)
  end

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
