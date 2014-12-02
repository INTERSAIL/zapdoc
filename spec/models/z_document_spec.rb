require 'rails_helper'

RSpec.describe ZDocument, :type => :model do
  context 'Database Mapping' do
    it { should have_db_column(:filename).of_type :string }

    it 'should validate unique filename' do
      should validate_uniqueness_of :filename
    end
  end

  it 'should have a default filename' do
    generator = double
    expect(generator).to receive(:next).once.and_return :fake_name

    document = ZDocument.new name_generator: generator

    expect(document.filename).to be == :fake_name
  end

  #@jtodoIMP fix this then use mock then test the file repo and then fix dependency in zfolder
  #@jtodoIMP use resource name instead of filename!
  context 'data' do
    let (:document) { ZDocument.new label: "document1" }
    before :each do
      document.data = 'Hello world'
    end

    it 'should save data when write to database' do
      repository = double
      expect(repository).to receive(:write).once.with(document.filename, document.data).and_return :filename
      document.repository = repository

      document.save

      expect(document.filename).to be_equal :filename
      # expect(ZapDoc.config.repository.read(document.filename)).to eq('Hello world')
    end

    it 'should handle write errors with save!' do
      repository = double
      expect(repository).to receive(:write).once.with(document.filename,document.data).and_return false
      document.repository = repository

      expect{document.save!}.to raise_exception 'Error writing data'
    end

    #@jtodoIMP
    xit 'should read data when read from database' do
      d2 = ZDocument.find(document.id)
      expect(d2.data).to eq('Hello world')
    end

    xit 'should delete data when destroyed' do
      document.destroy
      expect(ZapDoc.config.repository.exists?(document.filename)).to be false
    end
  end
end
