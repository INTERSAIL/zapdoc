require 'rails_helper'

RSpec.describe ZDocument, :type => :model do
  context 'Database Mapping' do
    it { should have_db_column(:filename).of_type :string }

    it 'should validate unique filename' do
      should validate_uniqueness_of :filename
    end
  end

  let(:document) { ZDocument.new(label: 'label') }
  it 'should have a default filename' do
    expect(document.filename).to_not be_nil
  end

  #@jtodoIMP fix this then use mock then test the file repo
  context 'data' do
    before :each do
      document.data = 'Hello world'
      document.save!
    end

    it 'should save data when write to database' do
      expect(ZapDoc.config.repository.read(document.filename)).to eq('Hello world')
    end

    it 'should read data when read from database' do
      d2 = ZDocument.find(document.id)
      expect(d2.data).to eq('Hello world')
    end

    it 'should delete data when destroyed' do
      document.destroy
      expect(ZapDoc.config.repository.exists?(document.filename)).to be false
    end
  end
end
