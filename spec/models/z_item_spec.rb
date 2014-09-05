require 'rails_helper'

RSpec.describe ZItem, :type => :model do
  it { should respond_to :identifier }
  it { should validate_presence_of :identifier }
  it { should validate_uniqueness_of :identifier }

  it 'should have a default identifier' do
    i = ZItem.new
    expect(i.identifier).to_not be_nil
  end
end
