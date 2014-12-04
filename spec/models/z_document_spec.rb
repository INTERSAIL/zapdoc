require 'rails_helper'

RSpec.describe ZDocument, :type => :model do
  context 'Database Mapping' do
    it { should have_db_column(:resource_uri).of_type :string }
    it { should inherit_from ZItem }

    it 'should validate unique resource uri' do
      should validate_uniqueness_of :resource_uri
    end

    it 'should validate presence of folder' do
      should validate_presence_of :folder
    end
  end

  it 'should have a default resource uri' do
    generator = double
    expect(generator).to receive(:next).once.and_return :fake_name

    document = ZDocument.new name_generator: generator

    expect(document.resource_uri).to be == :fake_name
  end

  context 'data' do
    let (:document) { ZDocument.new label: "document1", data: "Hello world" }

    it 'should save data when write to database' do
      repository = double
      expect(repository).to receive(:write).once.with(document.resource_uri, document.data).and_return :resource_uri
      document.repository = repository

      document.save

      expect(document.resource_uri).to be_equal :resource_uri
    end

    it 'should handle write errors with save!' do
      repository = double
      expect(repository).to receive(:write).once.with(document.resource_uri, document.data).and_return false
      document.repository = repository

      expect { document.save! }.to raise_exception 'Error writing data'
    end

    it 'should read data when read from database' do
      null_write = double
      allow(null_write).to receive(:write).and_return("resource uri")
      allow(null_write).to receive(:read)
      document_persisted = ZDocument.create! label: "document2", repository: null_write

      repository = double
      expect(repository).to receive(:read).once.with("resource uri").and_return :data
      document_persisted.repository = repository

      expect(document_persisted.data).to eq :data
    end

    it 'should delete data when destroyed' do
      repository = double
      expect(repository).to receive(:delete).once.with(document.resource_uri)
      document.repository = repository

      document.destroy
    end

    context 'write repository integration' do
      it 'should handle write errors with write!' do
        repository = double
        expect(repository).to receive(:write).and_return(nil)
        document.repository = repository

        expect { document.send :write! }.to raise_exception 'Error writing data'
      end

      it 'should handle write success with write!' do
        repository = double
        expect(repository).to receive(:write).and_return(:resource_uri)
        document.repository = repository

        expect(document.send :write!).to be :resource_uri
      end
    end
  end
end
