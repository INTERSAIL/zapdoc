require 'rails_helper'

#@jtodoIMP
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

  it 'should write file with success and return filename' do
    expect(repository.write @filename, "fake data").to be == @filename
    expect(Helpers::File.exists? @filename).to be_truthy
  end

  it 'should write file and return false on failure' do
    expect(repository.write "", "").to be == false
    
  end
  it 'should append a counter to filename if already exists on write' do

  end
  it 'should read a file with success' do
  end
  it 'should read a file with error' do
  end
end