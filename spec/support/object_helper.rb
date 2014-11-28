module Helpers
  module Object
    RSpec::Matchers.define :have_an_alias do |original_name, alias_name|
      match do |actual|
        expect(actual.method(original_name) ).to be == actual.method(alias_name)
      end
      end
  end
end