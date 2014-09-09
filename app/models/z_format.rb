class ZFormat
  include Mongoid::Document

  field :identifier, type: String
  field :description, type: String
  field :mime_type, type: String
  field :accepted_extensions, type: Array
  field :default, type: Boolean

  validates :identifier, presence: true
  validates :mime_type, presence: true
  validates :default, inclusion: [true, false]
end