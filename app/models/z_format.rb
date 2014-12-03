class ZFormat < ActiveRecord::Base
  # validation
  validates :mime_type, presence: true
  validates :default, inclusion: [true, false]
end
