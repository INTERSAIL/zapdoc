require 'rails_helper'
#@jtodoIMP
RSpec.describe PlainFilesystemRepository do
  before(:all) do
    FileUtils.rm_f(Dir[File.join(ZapDoc.config.repository.path, '[^.]*')])
  end

  it 'should delete file' do
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