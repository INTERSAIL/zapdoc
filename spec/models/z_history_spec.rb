require 'rails_helper'

RSpec.describe ZHistory, :type => :model do
  context 'Database Mapping' do
    it { should have_db_column(:id).with_options(primary: true) }
    it { should have_db_column(:history_date).of_type(:datetime) }
    it { should have_db_column(:z_item_id).of_type(:uuid) }
    it { should have_db_column(:revision).of_type(:integer) }
    it { should have_timestamps }

    #@jtodoIMP fix test
    it 'should have a relation with history' do
      pending
      should have_many(:z_history).dependent(:destroy)
    end
  end

  context 'revision' do
    #@jtodoIMP move this to the history test
    it 'should have revision 1 in history' do
      pending
      expect(item.histories.first.revision).to eq(1)
    end
  end
end