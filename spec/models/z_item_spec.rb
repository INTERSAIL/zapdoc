require 'rails_helper'

RSpec.describe ZItem, :type => :model do
  it { should respond_to :identifier }
  it { should validate_presence_of :identifier }
  it { should validate_uniqueness_of :identifier }

  it 'should have a default identifier' do
    i = ZItem.new
    expect(i.identifier).to_not be_nil
  end

  it 'should have revision 1 on creation' do
    i = ZItem.create(label: '1')
    expect(i.revision).to eq(1)
  end

  context 'with two revisions' do
    let(:item) { ZItem.create(label: '1') }
    before(:each) do
      item.update_attribute(:label, '2')
    end

    it 'should update revision after save' do
      expect(item.revision).to eq(2)
    end

    it 'should create history on save' do
      expect(item.histories.count).to eq(1)
    end

    it 'should have revision 1 in history' do
      expect(item.histories.first.revision).to eq(1)
    end
  end
end
