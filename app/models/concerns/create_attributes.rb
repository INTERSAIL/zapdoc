# module CreateAttributes
#   extend ActiveSupport::Concern
#
#   included do
#     @names = nil
#   end
#
#   module ClassMethods
#     def attribute_names
#       @names
#     end
#
#     private
#     def create_attributes(*names)
#       @names ||= (self.superclass.respond_to?(:attribute_names) ? self.superclass.attribute_names.dup : [])
#       @names.concat names.map(&:to_s)
#
#       names.each do |n|
#         send('attr_accessor', n.to_sym)
#       end
#     end
#   end
# end