require 'rails_helper'

describe ZHierarchy, type: :model do
  before(:all) do
    @item = ZItem.new
    @hierarchy = ZHierarchy.new item: @item
  end

  it 'could be created with an item' do
    @hierarchy = ZHierarchy.new item: @item
    expect(@hierarchy.item).to be_equal(@item)
  end

  context 'root folders' do
    xit 'respond to folder methods only if you pass a folder' #handle error

    context 'with root folder' do
      before(:all) do
        @root = ZFolder.create label: ZFolder.root_label, z_item: nil
        @hierarchy.item = @root
      end

      it 'should return root folder' do
        expect(@hierarchy.root).to be == @root
      end

      it "should obtain if it's the root folder " do
        expect(@hierarchy.root?).to be_equal true

        @hierarchy.item = ZFolder.create z_item: @root
        expect(@hierarchy.root?).to be_equal false
      end
    end
    context 'without root folder' do
      it 'should return a new root folder' do
        expect(@hierarchy.root).to satisfy {|folder| folder.hierarchy.root? == true}
      end
    end
  end

  context 'default folder' do
    xit 'return the root folder if exists' #set_defaults
    xit "return itself if it's the root and it's a folder" #set_defaults
  end

  context 'folder structure' do
    it "should check if it's in a folder"
  end

  #@jtodoIMP finish this then put as mock to the folder class
end