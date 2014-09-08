require 'rails_helper'

RSpec.describe 'Listing all items', type: :request do
  before(:all) do
    ZItem.destroy_all

    @root = ZFolder.root
    @root_doc1 = @root.documents.create(label: 'ROOT:1')

    @sub = @root.folders.create!(label: 'ROOT:SUB1')
    @sub_doc1 = @sub.documents.create!(label: 'SUB1:1')
  end

  it 'should list all items in ROOT' do
    get "/api/z_items"
    expect(response.status).to eq(200)

    expect(json.count).to eq(2)
  end

  it 'should list all items in SUB1' do
    get "/api/z_items?folder_id=#{@sub.id}"
    expect(response.status).to eq(200)

    expect(json.count).to eq(1)
  end

  it 'should get document in ROOT' do
    get "/api/z_items/#{@root_doc1.id}"
    expect(response.status).to eq(200)

    expect(json[:label]).to eq(@root_doc1.label)
  end
end