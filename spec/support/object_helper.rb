module Helpers
  module Object
    RSpec::Matchers.define :have_an_alias do |original_name, alias_name|
      match do |actual|
        expect {actual.should_receive(original_name)}
        actual.send(original_name)
      end
      end
  end
end