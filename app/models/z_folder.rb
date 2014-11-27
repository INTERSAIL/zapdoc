class ZFolder < ActiveRecord::Base
  # class UniqueRootValidator < ActiveModel::EachValidator
  #   def validate_each(record, attribute, value)
  #     record.errors.add attribute, (options[:message] || 'Cannot have two root folders') if value && ZFolder.find_by(is_root: true)
  #   end
  # end
  #
  # validates :is_root, unique_root: true

  def self.root_label
    '__ROOT__'
  end

  # def self.root
  #   @@root ||= (ZFolder.find_by(is_root: true) || ZFolder.create!(label: root_label, is_root: true))
  # end
  #
  # def root?
  #   self.is_root
  # end
end
