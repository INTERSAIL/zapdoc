require 'rails_helper'

RSpec.describe PlainFilesystemRepository do
  let (:repository) { ZapDoc.config.repository }
  before(:all) do
    @filename = 'test.txt'
  end
  after(:each) do
    Helpers::File.clear_test_data
  end

  it 'should delete file' do
    Helpers::File.touch @filename
    expect(repository.delete @filename).to be_truthy
    expect(Helpers::File.exists? @filename).to be_falsey
  end

  context 'write data' do
    it 'should write file with success and return filename' do
      expect(repository.write @filename, "fake data").to be == @filename
      expect(Helpers::File.exists? @filename).to be_truthy
    end
    it 'should write file and return nil on failure' do
      expect(repository.write "", "").to be_falsey
    end
  end

  context 'read data' do
    it 'should append a counter to filename if already exists on write' do
      repository.write @filename, "fake data"
      expect(repository.write @filename, "fake data").to be == @filename + "-1"
    end

    it 'should read a file with success' do
      repository.write @filename, "fake data"
      expect(repository.read @filename).to be == "fake data"
    end

    it 'should read a file with error and return nil' do
      expect(repository.read "nonesistent file").to be_falsey
    end
  end
end