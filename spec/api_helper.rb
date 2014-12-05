require_relative 'rails_helper'
RSpec.configure do |config|
  config.include Helpers::Requests::JsonHelpers, type: :request
  config.include Rails.application.routes.url_helpers

end