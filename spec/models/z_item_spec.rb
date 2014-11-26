require 'rails_helper'

RSpec.describe ZItem, :type => :model do
  context 'Database Columns' do
    it { should have_db_column(:id).of_type(:uuid) }
    it { should have_db_column(:label).of_type(:string) }
    it { should have_db_column(:custom_attributes).of_type(:hstore) }
    it { should have_db_column(:tags).of_type(:text) }
    it { should have_db_column(:revision).of_type(:integer) }
    it { should have_db_column(:format_identifier).of_type(:string) }
    it { should have_db_column(:mime_type).of_type(:string) }
    it { should have_db_column(:folder_id).of_type(:integer) }

    it 'have an id alias to identifier' do
      first_value = 1
      second_value = 2

      # first value to second value
      subject.id = first_value
      expect { subject.identifier = second_value }
      .to change { subject.id }
          .from(first_value)
          .to(second_value)

      #second value to first value
      expect { subject.id = first_value }
      .to change { subject.identifier }
          .from(second_value)
          .to(first_value)
    end
  end

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

    it 'should update revision after save' do
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
