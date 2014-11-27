require 'rails_helper'

RSpec.describe ZHistory, :type => :model do
  context 'Database Mapping' do
    it { should have_db_column(:id).with_options(primary: true) }
    it { should have_db_column(:history_date).of_type(:datetime) }
    it { should have_db_column(:z_item_id).of_type(:uuid) }
    it { should have_db_column(:revision).of_type(:integer) }
    it { should have_timestamps }

    it 'should have a relation with history' do
      pending
      should belongs_to(:z_item)
    end

    it 'should validate presence of item' do
      should validate_presence_of(:z_item)
    end

    it 'should validate revision' do
      should validate_presence_of(:revision)
      should validate_numericality_of(:revision)
    end
  end

  context 'revision' do
    it 'should have equal revision of his item' do
      item = ZItem.create(label: '1', revision: 12)
      history = ZHistory.create(z_item: item)
      expect(history.revision).to eq(item.revision)
    end
  end

  it 'should save timestamp on creation' do
    expect{subject.save}.to change { subject.history_date }
      .to( be_within(2).of(Time.now))
  end
end