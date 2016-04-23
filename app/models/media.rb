class Media < ActiveRecord::Base
  scope :search, -> (search_term) {
    where('title LIKE ? or station LIKE ? or genre LIKE ? or date LIKE ? or description LIKE ?',
          "%#{search_term}%",
          "%#{search_term}%",
          "%#{search_term}%" ,
          "%#{search_term}%",
          "%#{search_term}%")
  }
end
