class Media < ActiveRecord::Base
  scope :search, -> (search_term) {
    where('title LIKE ? or station LIKE ? or genre LIKE ? or description LIKE ?',
          "%#{search_term}%",
          "%#{search_term}%",
          "%#{search_term}%",
          "%#{search_term}%")
  }

  scope :station, -> (station) { where station: station }

  scope :live, -> () { where live: true }

  scope :after_date, -> (date) { where("date >= ?", date)}
  scope :before_date, -> (date) { where("date <= ?", date)}

  scope :min_duration, -> (duration) { where("duration >= ?", duration) }
  scope :max_duration, -> (duration) { where("duration <= ?", duration) }

  scope :most_recent, -> () { order(date: :desc) }
  scope :least_recent, -> () { order(date: :asc) }

end
