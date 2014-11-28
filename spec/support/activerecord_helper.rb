module Helpers
  module ActiveRecord
    RSpec::Matchers.define :have_an_alias_attribute do |original_name, alias_name|
      match do |actual|
        first_value = 1
        second_value = 2

        # first value to second value
        actual.send("#{original_name}=", first_value)
        expect { actual.send("#{alias_name}=", second_value) }
        .to change { actual.send(original_name) }
            .from(first_value)
            .to(second_value)

        #second value to first value
        expect { actual.send("#{original_name}=",first_value) }
        .to change { actual.send(alias_name) }
            .from(second_value)
            .to(first_value)
      end
    end

    RSpec::Matchers.define :have_timestamps do
      match do |actual|
        expect(actual).to(have_db_column(:created_at).of_type(:datetime))
        expect(actual).to(have_db_column(:updated_at).of_type(:datetime))
      end
    end

    RSpec::Matchers.define :implement_sti do
      match do |actual|
        expect(actual).to(have_db_column(:type).of_type(:string))
      end
    end
  end
end
