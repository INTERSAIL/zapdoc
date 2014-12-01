require 'rails_helper'

RSpec.describe ZFolder, type: :model do
  context 'Database Mapping' do
    it 'should have a relation with folder' do
      should have_many(:folders)
    end

    it 'should have a relation with document' do
      should have_many(:documents)
    end

    it 'should have a relation with item' do
      should have_many(:items)
    end
  end

  context "hierarchy" do
    before(:all) do
      @root = ZFolder.create label: ZFolder.root_label, folder: nil
    end

    it 'has root_label' do
      expect(ZFolder.root_label).not_to be_empty
    end

    it "should ask if it's root?" do
      hierarchy = double ZHierarchy
      expect(hierarchy).to receive(:root?).once
      @root.hierarchy = hierarchy

      @root.root?
    end

    it "should ask for the root folder" do
      hierarchy = double ZHierarchy
      expect(hierarchy).to receive(:root).once
      @root.hierarchy = hierarchy

      @root.root
    end

    it "should create only one root" do
      folder = ZFolder.create label: ZFolder.root_label

      expect(folder.valid?).to be false
      expect(folder.errors.count).to be == 1

      folder.folder = @root
      expect(folder.valid?).to be true
    end

    #@jtodoIMP fix this tests then go with the history
    context 'should have documents' do
      # directory structure:
      # - ROOT
      # -- ROOT:1
      # -- ROOT:SUB1
      # --- SUB1:1
      # -- ROOT:SUB2

    #   before(:all) do
    #     ZItem.destroy_all
    #
    #     @root_doc1 = @root.documents.create(label: 'ROOT:1', format_identifier: :txt, data: 'Hello world!')
    #
    #     @sub = @root.folders.create!(label: 'ROOT:SUB1')
    #     @sub_doc1 = @sub.documents.create!(label: 'SUB1:1', format_identifier: :txt, data: 'Hello world!')
    #
    #     @sub2 = @root.folders.create(label: 'ROOT:SUB2')
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
    #
    # context "attaching data to a folder" do
    #   it "should attach a folder to a folder" do
    #     child_folder = @root.folders.create label: "root_child_1"
    #     expect(child_folder.folder).to be == @root
    #     expect(child_folder.class.name).to be == ZFolder.name
    #   end
    #
    #   it "should attach a document to a folder" do
    #     child_document = @root.documents.create label: "document root_child_1"
    #     expect(child_document.folder).to be == @root
    #     expect(child_document.class.name).to be == ZDocument.name
    #   end
    end
  end
end