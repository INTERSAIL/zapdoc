class ZDocument < ZItem
  attr_accessor :data
  attr_accessor :repository, :name_generator
  # event hooks
  after_destroy :delete_file

  # validation
  validates :filename, uniqueness: true

  def data
    @data ||= ZapDoc.config.repository.read(self.filename)
  end

  def save(options = {})
    super if write
  end

  def save!(options = {})
    super if write!
  end

  private

  def set_defaults
    super
    initialize_repository
    initialize_name_generator
    initialize_filename
  end

  def initialize_name_generator
    self.name_generator ||= ZapDoc.config.filename_generator.next
  end

  def initialize_repository
    self.repository ||= ZapDoc.config.repository
  end

  def initialize_filename
    self.filename ||= self.name_generator.next
  end

  def write
    self.filename = self.repository.write(self.filename, self.data) || self.filename
  end

  def write!
    raise 'Error writing data' unless (self.filename = self.repository.write(self.filename, self.data))
  end

  #@jtodoIMP
  def delete_file
    self.repository.delete(self.filename)
  end
end
