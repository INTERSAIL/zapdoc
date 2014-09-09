require 'rails_helper'

RSpec.describe ZFormat, type: :model do
  it { should respond_to :identifier }
  it { should respond_to :description }
  it { should respond_to :mime_type }
  it { should respond_to :accepted_extensions }
  it { should respond_to :default }

  it { should validate_presence_of(:identifier) }
  it { should validate_presence_of(:mime_type) }
  it { should validate_inclusion_of(:default).to_allow([true, false]) }
end