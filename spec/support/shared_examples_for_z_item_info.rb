require 'rails_helper'

RSpec.shared_examples_for 'z_item_info' do
  it { should respond_to(:identifier) }
  it { should respond_to(:label) }
  it { should respond_to(:type) }
  it { should respond_to(:created_at) }
  it { should respond_to(:revision) }

  it { should_not be_persisted }
end