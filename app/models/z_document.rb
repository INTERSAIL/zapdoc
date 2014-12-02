class ZDocument < ZItem
  #@jtodoIMP then finish folder
  attr_accessor :data
  # event hooks
  after_destroy :delete_file

  # validation
  validates :filename, uniqueness: true

  def data
    @data ||= ZapDoc.config.repository.read(self.filename)
  end

  #@jtodoIMP use events here when done
  def save(options = {})
    super if write
  end

  def save!(options = {})
    if write
      super
    else
      raise 'Error writing data'
    end
  end

  private

  def set_defaults
    super
    self.filename ||= ZapDoc.config.filename_generator.next
  end

  def write
    self.filename = ZapDoc.config.repository.write(self.filename, self.data) || self.filename
  end

  def delete_file
    ZapDoc.config.repository.delete(self.filename)
  end
end
