require 'rails_helper'

RSpec.describe ZFolder, type: :model do
  context 'Database Mapping' do
    it { should inherit_from ZItem }

    it 'should have a relation with folder' do
      should have_many :folders
    end

    it 'should have a relation with document' do
      should have_many :documents
    end

    it 'should have a relation with item' do
      should have_many(:items).dependent :destroy
    end
  end

  context "hierarchy" do
    before(:all) do
      ZFolder.destroy_all
      @root = ZFolder.create! label: ZFolder.root_label, folder: nil
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
      class_mock = double
      expect(class_mock).to receive(:class).and_return hierarchy
      @root.hierarchy = class_mock

      @root.root
    end

    it "should create only one root" do
      folder = ZFolder.create label: ZFolder.root_label

      expect(folder.valid?).to be false
      expect(folder.errors.count).to be == 1

      folder.folder = @root
      expect(folder.valid?).to be true
    end
  end

  context 'should have documents' do
    before(:all) do
      # directory structure:
      # - ROOT
      # -- ROOT:1
      # -- ROOT:SUB1
      # --- SUB1:1
      # -- ROOT:SUB2
      ZItem.destroy_all

      @root = ZHierarchy.root

      @root_doc1 = @root.documents.create!(label: 'ROOT:1', format_identifier: :txt)

      @sub = @root.folders.create!(label: 'ROOT:SUB1')
      @sub_doc1 = @sub.documents.create!(label: 'SUB1:1', format_identifier: :txt)

      @sub2 = @root.folders.create!(label: 'ROOT:SUB2')
    end

    it 'should have 3 items' do
      expect(@root.items.count).to eq(3)
    end
    it 'should have 1 document' do
      expect(@root.documents.count).to eq(1)
    end
    it 'should have 2 folders' do
      expect(@root.folders.count).to eq(2)
    end
  end
end