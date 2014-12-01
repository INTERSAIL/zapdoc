class ZFolder < ZItem
  class UniqueRootValidator < ActiveModel::Validator
    def validate(record)
      record.errors[:z_item_id] << 'Cannot have two root folders' if ZFolder.new.hierarchy.find_root
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
