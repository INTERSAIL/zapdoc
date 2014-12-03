require 'rails_helper'



#@jtodoIMP
RSpec.describe PlainFilesystemRepository do
  let (:repository) { ZapDoc.config.repository }
  after(:all) do
    Helpers::File.clear_test_data
  end

  it 'should delete file' do
    filename = 'test.txt'
    Helpers::File.touch filename

    expect(repository.delete filename).to be_truthy
    expect(Helpers::File.exists? filename).to be_falsey
  end

  it 'should write file with success and return filename' do

  end

  it 'should write file and return false on failure' do
  end
  it 'should append a counter to filename if already exists on write' do
  end
  it 'should read a file with success' do
  end
  it 'should read a file with error' do
  end
end