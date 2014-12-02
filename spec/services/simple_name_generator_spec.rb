require 'rails_helper'

RSpec.describe SimpleNameGenerator do
  let(:generator) {SimpleNameGenerator.new}

  it 'should generate a random name with next' do
    values = []
    1..10.times do
      new_name = generator.next
      expect(values).not_to include new_name
      values << new_name
    end
  end
end