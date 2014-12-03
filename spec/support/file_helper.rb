module Helpers
  module File
    def self.file_path(filename)
      ZapDoc.config.repository.path.to_s + ::File::SEPARATOR + filename
    end

    def self.touch(filename)
      ::FileUtils.touch file_path filename
    end

    def self.exists?(filename)
      ::File.exists? file_path filename
    end

    def self.clear_test_data
      ::FileUtils.rm_f(Dir[::File.join(ZapDoc.config.repository.path, '[^.]*')])
    end
  end
end