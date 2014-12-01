class ZFolder < ZItem
  class UniqueRootValidator < ActiveModel::Validator
    def validate(record)
      record.errors[:folder] << 'Cannot have two root folders' if ZHierarchy.new.find_root && record.folder.nil?
    end
  end

  validates_with UniqueRootValidator

  def self.root_label
    '__ROOT__'
  end

  def root
    self.hierarchy.root
  end

  def root?
    self.hierarchy.root?
  end
end
