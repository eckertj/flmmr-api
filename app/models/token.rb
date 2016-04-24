class Token < ActiveRecord::Base

  scope :api_key, -> (api_key) { where api_key: api_key }

end

