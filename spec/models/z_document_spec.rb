require 'rails_helper'

RSpec.describe ZDocument, :type => :model do
  let(:d) { ZDocument.new }

  it 'should have a default filename' do
    expect(d.filename).to_not be_nil
  end

  context 'data' do
    before :each do
      d.data = 'Hello world'
      d.save
    end

    it 'should save data when write to database' do
      expect(ZapDoc.config.repository.read(d.filename)).to eq('Hello world')
    end

    it 'should read data when read from database' do
      d2 = ZDocument.find_by(identifier: d.identifier)
      expect(d2.data).to eq('Hello world')
    end

    it 'should delete data when destroyed' do
      d.destroy
      expect(ZapDoc.config.repository.exists?(d.filename)).to be false
    end
  end
end
