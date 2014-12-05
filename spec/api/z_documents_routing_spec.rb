require 'api_helper'

RSpec.describe 'Documents', type: :request do
  before(:all) do
    ZItem.destroy_all
    # directory structure:
    # - ROOT
    # -- ROOT:1
    # -- ROOT:SUB1
    # --- SUB1:1
    # -- ROOT:SUB2
    @root = ZHierarchy.root
    @root_doc1 = @root.documents.create!(label: 'ROOT:1', format_identifier: :txt)

    @sub = @root.folders.create!(label: 'ROOT:SUB1')
    @sub_doc1 = @sub.documents.create!(label: 'SUB1:1', format_identifier: :txt)

    @sub2 = @root.folders.create!(label: 'ROOT:SUB2')
  end

  it 'should list all documents in ROOT' do
    get "/api/z_documents"
    expect(response.status).to eq(200)

    expect(json.count).to eq(1)
  end

  it 'should list all documents in SUB1' do
    get "/api/z_documents?folder_id=#{@sub.identifier}"
    expect(response.status).to eq(200)

    expect(json.count).to eq(1)
  end

  context 'get single document' do
    before(:all) { get "/api/z_documents/#{@sub_doc1.identifier}" }

    it 'should have all attributes for an item info' do
      check_attributes_for_item_info(json)
    end

    it 'should have a format_identifier' do
      expect(json).to have_key(:format_identifier)
    end
  end

end