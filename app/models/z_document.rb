class ZDocument < ZItem
  after_destroy :delete_file

  field :filename, type: String
  field :format, type: String

  attr_accessor :data
  def data
    @data ||= ZapDoc.config.repository.read(self.filename)
  end

  validates :filename, uniqueness: true

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