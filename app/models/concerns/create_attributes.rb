module CreateAttributes
  extend ActiveSupport::Concern

  included do

  end

  module ClassMethods
    def attribute_names
      @@names
    end

    private
    def create_attributes(*names)
      @@names = names

      names.each do |n|
        send('attr_accessor', n.to_sym)
      end
    end
  end
end