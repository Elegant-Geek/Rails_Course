class Movie < ApplicationRecord
  has_many :characterizations, dependent: :destroy
  has_many :genres, through: :characterizations #< no "source" bit needed here
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :fans, through: :favorites, source: :user #only need the "source" bit if (fans for instance) is something created in controller/is not standalone table/model
  has_many :critics, through: :reviews, source: :user #user.critics directs to all reviewers for that movie
  validates :title, :released_on, :duration, presence: true
  validates :description, length: { minimum: 25 }
  validates :total_gross, numericality: { greater_than_or_equal_to: 0 }
  validates :image_file_name, format: {
    with: /\w+\.(jpg|png)\z/i,
    message: "must be a JPG or PNG image"
  }
  RATINGS = %w(G PG PG-13 R NC-17)
  validates :rating, inclusion: { in: RATINGS }

  def self.released
    where("released_on < ?", Time.now).order("released_on desc")
  end

  def self.hits
    where("total_gross >= 300000000").order(total_gross: :desc)
  end
  
  def self.flops
    where("total_gross < 22500000").order(total_gross: :asc)
  end
  
  def self.recently_added
    order("created_at desc").limit(3)
  end

  def flop?
    total_gross.blank? || total_gross < 225_000_000
  end

  def average_stars
    reviews.average(:stars) || 0.0
  end 
  # (note the ^^ movie.reviews is just an atttribute/method you can call on the movie youre analyzing, like movie.title etc.)
  def average_stars_as_percent
    (self.average_stars / 5.0) * 100
  end

end


