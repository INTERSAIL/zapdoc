require 'rails_helper'

def clearFolders
  ZFolder.destroy_all
end

describe ZHierarchy, type: :model do
  before(:all) do
    @item = ZItem.new
    @hierarchy = ZHierarchy.new item: @item
  end

  it 'can be created with an item' do
    @hierarchy = ZHierarchy.new item: @item
    expect(@hierarchy.item).to be_equal(@item)
  end

  context 'root folders' do
    it "should return false on root? if it's not a folder" do
      expect(@hierarchy.root?).to be_equal false
    end

    context 'with root folder' do
      before(:all) do
        clearFolders
        @root = @hierarchy.folder.create label: @hierarchy.folder.root_label, z_item: nil
        @hierarchy.item = @root
      end

      it 'should return root folder' do
        expect(@hierarchy.root).to be == @root
      end

      it "should obtain if it's the root folder ", test: :true do
        expect(@hierarchy.root?).to be_equal true

        @hierarchy.item = @hierarchy.folder.create z_item: @root
        expect(@hierarchy.root?).to be_equal false
      end

      context 'folder structure' do
        xit "should check for folder presence of item" do

        end
      end

      context 'default folder' do
        it 'should return root folder' do
          @hierarchy.item = @item
          expect(@hierarchy.default).to be == @root
        end

        it "should return nil if he's the root" do
          @hierarchy.item = @root
          expect(@hierarchy.default).to be == nil
        end
      end
    end

    context 'without root folder' do
      before(:all) do
        clearFolders
      end
      before(:each) do
        @hierarchy.folder.where(z_item_id: nil).destroy_all
        @hierarchy.item = @item
      end

      it 'should return a new root folder' do
        expect(@hierarchy.root).to satisfy do |folder|
          folder.hierarchy.root? == true
          folder.label == @hierarchy.folder.root_label
        end
      end

      context 'default folder' do
        it "should return new root" do
          expect(@hierarchy.default).to be == @hierarchy.root
        end
      end
    end
  end

  context 'folder structure' do
    xit "should check if it's in a folder"
  end
end