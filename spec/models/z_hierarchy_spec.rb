require 'rails_helper'

def clearFolders
  ZFolder.destroy_all
end

describe ZHierarchy, type: :model do
  before(:all) do
    @item = ZItem.new
    @hierarchy = ZHierarchy.new item: @item
  end

  #@jtodoLOW remove after change of initialize
  it 'can be created with an item' do
    @hierarchy = ZHierarchy.new item: @item
    expect(@hierarchy.item).to be_equal @item
  end

  context 'root folders' do
    it "should return false on root? if it's not a folder" do
      expect(@hierarchy.root?).to be_equal false
    end

    context 'with root folder' do
      before(:all) do
        clearFolders
        @root = @hierarchy.folder_class.create! label: @hierarchy.folder_class.root_label, folder: nil
        @hierarchy.item = @root
      end

      it 'should return root folder' do
        expect(@hierarchy.root).to be == @root
      end

      it "should obtain if it's the root folder" do
        expect(@hierarchy).to be_root

        @hierarchy.item = @hierarchy.folder_class.create! folder: @root, label: "ROOT-1"
        expect(@hierarchy).to_not be_root
      end

      context 'default folder' do
        it 'should return root folder' do
          @hierarchy.item = @item
          expect(@hierarchy.default).to be == @root
        end

        it "should return nil if he's the root" do
          @hierarchy.item = @root
          expect(@hierarchy.default).to be_nil
        end
      end
    end

    context 'without root folder' do
      before(:all) do
        clearFolders
      end
      before(:each) do
        @hierarchy.folder_class.where(z_item_id: nil).destroy_all
        @hierarchy.item = @item
      end

      it 'should return a new root folder' do
        expect(@hierarchy.root).to satisfy do |folder|
          folder.hierarchy.root? &&
          folder.label == @hierarchy.folder_class.root_label
        end
      end

      context 'default folder' do
        it "should return new root folder" do
          expect(@hierarchy.default).to be == @hierarchy.root
        end
      end
    end
  end

  #@deprecated
  # it "ask for item method if doesn't find it on himself" do
  #   item = double ZItem
  #   lambda = ->(){}
  #   expect(item).to receive("nonexistent_method").once.with(["param"], lambda)
  #   hierarchy = ZHierarchy.new item: item
  #
  #   hierarchy.send "nonexistent_method", "param", &lambda
  # end
end