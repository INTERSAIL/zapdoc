module ZapDoc
  class Configuration
    attr_accessor :filename_generator
    attr_accessor :repository
  end

  #@jtodoLOW use singleton here
  mattr_accessor :config do
    Configuration.new
  end

  def self.configure
    yield(self.config) if block_given?
  end
end