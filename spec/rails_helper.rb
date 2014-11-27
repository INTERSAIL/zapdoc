# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!


  # Clean database at start of the suite and then
  # just uses transactions
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |single_test|
    DatabaseCleaner.cleaning do
      single_test.run
    end
  end

  config.before(:all) do
    #@jtodo handle that with various seed data
    # depending on the SUT

    # example directory structure:
    # - ROOT
    # -- ROOT:1
    # -- ROOT:SUB1
    # --- SUB1:1
    # -- ROOT:SUB2

    # ZItem.destroy_all

    # @root = ZFolder.root
    # @root_doc1 = @root.documents.create(label: 'ROOT:1', format_identifier: :txt, data: 'Hello world!')
    #
    # @sub = @root.folders.create!(label: 'ROOT:SUB1')
    # @sub_doc1 = @sub.documents.create!(label: 'SUB1:1', format_identifier: :txt, data: 'Hello world!')
    #
    # @sub2 = @root.folders.create(label: 'ROOT:SUB2')
  end

  config.after(:all) do
    FileUtils.rm_f(Dir[File.join(ZapDoc.config.repository.path, '[^.]*')])
  end

  # config.include Requests::JsonHelpers, type: :request
end

# Rails.application.load_seed
