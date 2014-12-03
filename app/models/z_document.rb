class ZDocument < ZItem
  attr_accessor :data
  attr_accessor :repository, :name_generator

  # event hooks
  after_destroy :delete_file

  # validation
  validates :resource_uri, uniqueness: true

  def data
    @data ||= self.repository.read(self.resource_uri)
  end

  #@jtodoLOW refactor this behaviour: you need to call save of activerecord first and
  # if you find any problem rollback the transaction and don't use the file repository
  def save(options = {})
    super if write
  end

  def save!(options = {})
    super if write!
  end

  private

  def set_defaults
    super
    initialize_name_generator
    initialize_repository
    initialize_resource_uri
  end

  def initialize_name_generator
    self.name_generator ||= ZapDoc.config.filename_generator
  end

  def initialize_repository
    self.repository ||= ZapDoc.config.repository
  end

  def initialize_resource_uri
    self.resource_uri = self.name_generator.next
  end

  def write
    self.resource_uri = self.repository.write(self.resource_uri, self.data) || self.resource_uri
  end

  def write!
    raise 'Error writing data' unless ( self.resource_uri = self.repository.write(self.resource_uri, self.data) )
    self.resource_uri
  end

  #@jtodoLOW handle case when delete fails and in that case don't remove the file
  def delete_file
    self.repository.delete(self.resource_uri)
  end
end
