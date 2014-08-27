module ZapDoc
  class Configuration
    attr_accessor :filename_generator
    attr_accessor :repository
  end

  cattr_accessor :config do
    Configuration.new
  end

  def self.use_relative_model_naming?
    true
  end

  def self.configure
    yield(self.config) if block_given?
  end

end