ZapDoc.configure do |config|

  config.filename_generator = SimpleNameGenerator.new

  config.repository = PlainFilesystemRepository.new(Rails.root.join('repository', Rails.env))

end