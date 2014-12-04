module Helpers
  module File
    @@repository_path = ZapDoc.config.repository.path

    def self.file_path(filename)
      @@repository_path.to_s + ::File::SEPARATOR + filename
    end

    def self.touch(filename)
      ::FileUtils.touch file_path filename
    end

    def self.exists?(filename)
      ::File.exists? file_path filename
    end

    def self.clear_test_data
      ::FileUtils.rm_f(Dir[::File.join(@@repository_path, '[^.]*')])
    end
  end
end