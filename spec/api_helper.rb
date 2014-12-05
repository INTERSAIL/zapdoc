require 'rails_helper'

RSpec.configure do |config|
  config.include Helpers::Requests::JsonHelpers, type: :request
end