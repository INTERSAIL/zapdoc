module ZapDoc
  class Configuration
    include Singleton

    attr_accessor :filename_generator
    attr_accessor :repository
  end

  mattr_accessor :config do
    Configuration.instance
  end

  def self.configure
    yield(self.config) if block_given?
  end
end