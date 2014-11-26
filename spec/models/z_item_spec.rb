require 'rails_helper'

RSpec.describe ZItem, :type => :model do
  it { should respond_to :identifier }
  xit { should respond_to :label }
  xit { should respond_to :format_identifier }
  xit { should respond_to :mime_type }

  xit { should validate_presence_of :identifier }
  xit { should validate_uniqueness_of :identifier }

  xit 'should have a default identifier' do
    i = ZItem.new
    expect(i.identifier).to_not be_nil
  end

  xit 'should have revision 1 on creation' do
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
end
