class PlainFilesystemRepository
  def initialize(path)
    @path = path
    Dir.mkdir @path unless Dir.exists? @path
  end

  def path
    @path
  end

  def write(filename, data)
    full_path = full_path(filename)
    indx = 1
    while File.exist?(full_path)
      full_path = full_path("#{filename}-#{indx}")
      indx += 1
    end

    File.split(full_path).last if File.binwrite(full_path, data) > 0
  end

  def read(filename)
    full_path = full_path(filename)

    File.read(full_path) if File.exist?(full_path)
  end

  def delete(filename)
    full_path = full_path(filename)
    File.delete(full_path) if File.exists?(full_path)
  end

  def exists?(filename)
    File.exists?(full_path(filename))
  end

  private
  def full_path(filename)
    File.join(@path, filename)
  end
end