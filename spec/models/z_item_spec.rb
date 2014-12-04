require 'rails_helper'

RSpec.describe ZItem, :type => :model do
  context 'Database Mapping' do
    it { should have_db_column(:id).of_type :uuid }
    it { should have_db_column(:label).of_type :string }
    it { should have_db_column(:custom_attributes).of_type :hstore }
    it { should have_db_column(:tags).of_type :text }
    it { should have_db_column(:revision).of_type :integer }
    it { should have_db_column(:format_identifier).of_type :string }
    it { should have_db_column(:mime_type).of_type :string }
    it { should have_db_column(:z_item_id).of_type :uuid }
    it { should implement_sti }
    it { should have_timestamps }

    it 'should have an id alias to identifier' do
      should have_an_alias_attribute :id,:identifier
    end

    #@jtodoIMP add check for historicize

    it 'should have a relation with folder' do
      should belong_to :folder
    end

    it 'should have a relation with history' do
      should have_many(:histories).dependent :destroy
    end

    it 'should validate presence of label' do
      should validate_presence_of :label
    end

    it 'should validate persisted revision record' do
      item = ZItem.create! label: '1'
      expect {item.should validate_presence_of :revision}
      expect {item.should validate_numericality_of :revision}
    end
  end

  #@jtodoLOW too many responsability for revision handling
  #@jtodoLOW should extract to class for Single Responsability
  context 'revision' do
    it 'should have revision 1 on creation' do
      item = ZItem.create!(label: '1')
      expect(item.revision).to eq(1)
    end

    context 'with two revisions' do
      let(:item) { ZItem.create! label: '1' }
      before(:each) do
        item.update_attribute :label, '2'
      end

      it 'should update revision after save' do
        expect(item.revision).to eq 2
      end

      it 'should create history on save' do
        expect(item.histories.count).to eq 1
      end

      it 'should create an history item on save' do
        expect(item.histories.nil?).to be false
      end
    end
  end

  context 'hierarchy mapping' do
    it 'should be initialized with ZHierarchy as default' do
      expect(subject.hierarchy).to be_instance_of ZHierarchy
      expect(subject.hierarchy.item).to be_equal subject
    end

    it 'should get a default folder' do
      hierarchy = double ZHierarchy
      expect(hierarchy).to receive(:default).once

      item = ZItem.new label: '1', hierarchy: hierarchy
    end

    context 'folder structure' do
      it "should have query scope for folder with in_folder" do
        root_folder = ZHierarchy.root
        item = ZItem.create! label: "1", folder: root_folder

        expect(ZItem.in_folder root_folder).to include item
        expect(ZItem.in_folder(ZFolder.create! label: :label, folder: root_folder) ).to be_empty
      end
    end
  end

  context 'type handling' do
    it 'should have query scope for mime_type with of_type' do
      mime_type = "image/png"

      item = ZItem.create! label: "1", mime_type: mime_type
      expect(ZItem.of_type mime_type).to include item
      expect(ZItem.of_type :none).to be_empty
    end
  end
end
