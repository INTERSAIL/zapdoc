require 'rails_helper'

RSpec.describe ZItem, :type => :model do
  it_behaves_like 'an item'

  #@jtodo validate label and revision check

  it 'should have revision 1 on creation' do
    i = ZItem.create(label: '1')
    expect(i.revision).to eq(1)
  end

  context 'with two revisions' do
    let(:item) { ZItem.create(label: '1') }
    before(:each) do
      item.update_attribute(:label, '2')
    end

    xit 'should update revision after save' do
      expect(item.revision).to eq(2)
    end

    xit 'should create history on save' do
      expect(item.histories.count).to eq(1)
    end

    xit 'should have revision 1 in history' do
      expect(item.histories.first.revision).to eq(1)
    end
  end

  xit 'should have a default folder' do
    i = ZItem.create(label: '1')
    expect(i.folder.identifier).to eq(ZFolder.root.identifier)
  end

  #@jtodo handle the first and last with timestamp
end
