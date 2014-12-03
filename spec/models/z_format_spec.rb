require 'rails_helper'
#@jtodoIMP
RSpec.describe ZFormat, type: :model do
  it { should respond_to :description }
  it { should respond_to :mime_type }
  it { should respond_to :accepted_extensions }
  it { should respond_to :default }

  xit { should validate_presence_of(:identifier) }
  xit { should validate_presence_of(:mime_type) }
  xit { should validate_inclusion_of(:default).to_allow([true, false]) }
end