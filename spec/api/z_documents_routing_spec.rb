require 'rails_helper'

RSpec.describe 'Documents', type: :request do
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