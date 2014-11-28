require 'rails_helper'

describe ZHierarchy, type: :model do
  let(:item) { ZItem.new }
  let(:hierarchy) { ZHierarchy.new item: item }

  it 'can be created with an item' do
    hierarchy = ZHierarchy.new item: item
    expect(hierarchy.item).to be_equal(item)
  end

  context 'root folder' do
    it 'should return a new root folder if does not exists' do #root
      # expect(hierarchy.root).to satisfy {|folder| folder.root? == true}
    end

    xit 'should return the root folder if exists' do #root

    end

    it "should obtain if it's the root folder " do
      root_folder = ZFolder.create label: ZFolder.root_label
      hierarchy.item = root_folder
      expect(hierarchy.root?).to be_equal true
      hierarchy.item = ZFolder.create z_item: root_folder
      expect(hierarchy.root?).to be_equal false
      #@jtodoIMP fix this
    end

    xit 'respond to folder methods only if you pass a folder' #handle error

  end

  context 'default folder' do
    xit 'return the root folder if exists' #set_defaults
    xit "return itself if it's the root and it's a folder" #set_defaults
  end

  context 'folder structure' do
    it "should check if it's in a folder"
  end

end