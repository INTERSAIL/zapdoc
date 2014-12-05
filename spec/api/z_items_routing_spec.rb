require 'api_helper'

RSpec.describe 'Items', type: :request do
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

  it 'should list all items in ROOT' do
    get "/api/z_items"

    expect(response).to be_success
    expect(json.count).to eq(3)
  end

  it 'should list all items in SUB1' do
    get "/api/z_items?folder_id=#{@sub.id}"

    expect(response).to be_success
    expect(json.count).to eq(2)
  end

  it 'should return the parent folder if not ROOT' do
    get "/api/z_items?folder_id=#{@sub.id}"

    expect(json.select { |j| j[:id] == @root.id }.count).to eq(1)
  end

  it 'should return root contents if folder_id=0' do
    get "/api/z_items?folder_id=0"

    expect(response).to be_success
    expect(json.select { |j| j[:id] == @root_doc1.id }.count).to eq(1)
  end

  it 'should return root contents if folder_id not specified' do
    get "/api/z_items"

    expect(response).to be_success
    expect(json.select { |j| j[:id] == @root_doc1.id }.count).to eq(1)
  end

  it 'should not return the parent folder if ROOT' do
    get "/api/z_items?folder_id=0"

    expect(json.select { |j| j[:id] == @root.id }.count).to eq(0)
  end

  it 'should return only parent folder if not ROOT and empty' do
    get "/api/z_items?folder_id=#{@sub2.identifier}"

    expect(json.count).to eq(1)
    expect(json[0][:id]).to eq(@root.identifier)
  end

  it 'should return 404 if a folder does not exists' do
    get '/api/z_items?folder_id=fake123'

    expect(response).to have_http_status :not_found
  end

  context 'check items attributes' do
    before(:all) { get '/api/z_items' }

    it 'should have all attribures for each item' do
      json.each do |j|
        check_attributes_for_item_info(j)
      end
    end
  end

  it 'should be possible to list only all folders in ROOT'
  it 'should be possible to list only all documents in ROOT'

  it 'should return 404 if document does not exists' do
    get '/api/z_items/fake_id'

    expect(response.status).to eq(404)
  end

  context 'get single item' do
    before(:all) {
      get "/api/z_items/#{@sub_doc1.id}"
    }

    it 'should have all attributes' do
      check_attributes_for_item_info(json)
    end
  end

  xit 'should be possible to get only document info without data'
  xit 'should be possible to get document data and info in a single request'
  xit 'should be possible to get only document data without info'

  context 'ZDocument: write' do
    xit 'should save a document given an identifier and a folder identifier'
    xit 'must specify the type of save from :info, :data, :all'
    xit 'document info must contain identifier'
    xit 'document info must contain a valid format_identifier'
    xit 'document info must contain mime_type if format_identifier is :unknown'
    xit 'param identifier must be equal to identifier in document info'
    xit 'should return a document info without data if save is success'
    xit 'should fail with 422 if a folder does not exists'
    xit 'if :info should save only document info without create a new file generating a new revision with the same file name'
    xit 'if :data should save only data in a new file generating a new revision with the same infos'
    xit 'if ·all should save data in a new file and generate a new revision updating infos and file name'
    xit 'if :info specified and input contains data should fail with 400'
    xit 'if :data specified and input does not contains data should fail with 400'
    xit 'if :all specified and input does not contains data should fail with 400'
    context 'a new document' do
      xit 'should create a new document if identifier is nil'
      xit 'if identifier is nil the save type must be :all'
      xit 'revision of saved document must be 1'
    end
    context 'an existing document' do
      xit 'if identifier does not exists, fails with 422'
      xit 'must generate a new revision with value incremented by 1'
    end
    context ':info' do
      xit 'label must be specified'
    end
    context ':data' do
      xit 'should set mime_type to application/pkcs7-data if format_identifier is :p7m'
      xit 'should set mime_type to application/pdf  if format_identifier is :pdf'
      xit 'if format_identifier is :unknown and mime_type is not specified must fail with 422'

      xit 'if format_identifier is :pdf and data is not a pdf must fail with 422'
      xit 'if format_identifier is :p7m and data is not a pkcs#7 must fail with 422'
      xit 'if format_identifier is :unknown data is not verified'
    end
  end

  context 'ZFolder' do
    xit 'should create a folder'
    xit 'to create a folder must specify identifier, folder identifier, label'
    xit 'should move a document into another folder'
  end

  it 'should get document in ROOT' do
    get "/api/z_items/#{@root_doc1.id}"
    expect(response).to be_success

    expect(json[:label]).to eq(@root_doc1.label)
  end
end