require 'rails_helper'

RSpec.describe ZFolder, type: :model do

  #@jtodoIMP test for unique root and is_root
  it 'has root_label' do
    expect(ZFolder.root_label).not_to be_empty
  end

  # context 'should have documents' do
  #   before(:all) do
  #     ZItem.destroy_all
  #     f = ZFolder.root
  #     f.folders.create!(label: 'F1')
  #     f.documents.create!(label: 'D1')
  #     @root = f
  #   end
  #
  #   it 'should have 2 items' do
  #     expect(@root.items.count).to eq(2)
  #   end
  #   it 'should have 1 document' do
  #     expect(@root.documents.count).to eq(1)
  #   end
  #   it 'should have 1 folder' do
  #     expect(@root.folders.count).to eq(1)
  #   end
  # end
  #
  # it 'should exists a root folder' do
  #   expect(ZFolder.root).to_not be_nil
  # end
  #
  # it 'root folder must have its folder set to nil' do
  #   expect(ZFolder.root.folder).to be_nil
  # end
end