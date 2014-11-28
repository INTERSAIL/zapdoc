require 'rails_helper'

describe ZHierarchy, type: :model do
  before(:all) do
    @item = ZItem.new
    @hierarchy = ZHierarchy.new item: @item
  end

  it 'can be created with an item' do
    @hierarchy = ZHierarchy.new item: @item
    expect(@hierarchy.item).to be_equal(@item)
  end

  context 'with root folder' do
    it 'should respond to root only if you pass a folder as item' do
      expect{@hierarchy.root}.to raise_error(ArgumentError)
    end

    it 'should respond to root? only if you pass a folder as item' do
      expect{@hierarchy.root?}.to raise_error(ArgumentError)
    end

    context 'with root folder' do
      before(:all) do
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

      context 'default folder' do
        it 'should return root folder' do
          expect(@hierarchy.default).to be == @root
        end

        it "should return self if he's the root" do
          @hierarchy.item = @root
          expect(@hierarchy.default).to be == @root
        end
      end
    end

    context 'without root folder' do
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

  #@jtodoIMP finish this then put as mock to the folder class
end