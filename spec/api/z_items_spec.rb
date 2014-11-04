require 'rails_helper'

RSpec.describe 'Items', type: :request do
  it 'should list all items in ROOT' do
    get "/api/z_items"
    expect(response.status).to eq(200)

    expect(json.count).to eq(3)
  end

  it 'should list all items in SUB1' do
    get "/api/z_items?folder_id=#{@sub.identifier}"
    expect(response.status).to eq(200)

    expect(json.count).to eq(2)
  end

  it 'should return the parent folder if not ROOT' do
    get "/api/z_items?folder_id=#{@sub.identifier}"

    expect(json.select { |j| j[:identifier] == ZFolder.root.identifier }.count).to eq(1)
  end

  it 'should return root contents if folder_id=0' do
    get "/api/z_items?folder_id=0"

    expect(response.status).to eq(200)

    expect(json.select { |j| j[:identifier] == @root_doc1.identifier}.count).to eq(1)
  end

  it 'should return root contents if folder_id not specified' do
    get "/api/z_items"

    expect(response.status).to eq(200)

    expect(json.select { |j| j[:identifier] == @root_doc1.identifier}.count).to eq(1)
  end

  it 'should not return the parent folder if ROOT' do
    get "/api/z_items?folder_id=0"

    expect(json.select { |j| j[:identifier] == ZFolder.root.identifier }.count).to eq(0)
  end

  it 'should return only parent folder if not ROOT and empty' do
    get "/api/z_items?folder_id=#{@sub2.identifier}"

    expect(json.count).to eq(1)
    expect(json[0][:identifier]).to eq(@root.identifier)
  end

  it 'should return 404 if a folder does not exists' do
    get '/api/z_items?folder_id=fake123'
    expect(response.status).to eq(404)
  end

  context 'check items attributes' do
    before(:all) { get '/api/z_items' }

    it 'should have all attribures for each item' do
      json.each do |j|
        check_attributes_for_item_info(j)
      end
    end

  end

  pending 'should be possible to list only all folders in ROOT'
  pending 'should be possible to list only all documents in ROOT'

  it 'should return 404 if document does not exists' do
    get '/api/z_items/fake_id'

    expect(response.status).to eq(404)
  end

  context 'get single item' do
    before(:all) {
      get "/api/z_items/#{@sub_doc1.identifier}"
    }

    it 'should have all attributes' do
      check_attributes_for_item_info(json)
    end
  end

  pending 'should be possible to get only document info without data'
  pending 'should be possible to get document data and info in a single request'
  pending 'should be possible to get only document data without info'

  context 'ZDocument: write' do
    pending 'should save a document given an identifier and a folder identifier'
    pending 'must specify the type of save from :info, :data, :all'
    pending 'document info must contain identifier'
    pending 'document info must contain a valid format_identifier'
    pending 'document info must contain mime_type if format_identifier is :unknown'
    pending 'param identifier must be equal to identifier in document info'
    pending 'should return a document info without data if save is success'
    pending 'should fail with 422 if a folder does not exists'
    pending 'if :info should save only document info without create a new file generating a new revision with the same file name'
    pending 'if :data should save only data in a new file generating a new revision with the same infos'
    pending 'if ·all should save data in a new file and generate a new revision updating infos and file name'
    pending 'if :info specified and input contains data should fail with 400'
    pending 'if :data specified and input does not contains data should fail with 400'
    pending 'if :all specified and input does not contains data should fail with 400'
    context 'a new document' do
      pending 'should create a new document if identifier is nil'
      pending 'if identifier is nil the save type must be :all'
      pending 'revision of saved document must be 1'
    end
    context 'an existing document' do
      pending 'if identifier does not exists, fails with 422'
      pending 'must generate a new revision with value incremented by 1'
    end
    context ':info' do
      pending 'label must be specified'
    end
    context ':data' do
      pending 'should set mime_type to application/pkcs7-data if format_identifier is :p7m'
      pending 'should set mime_type to application/pdf  if format_identifier is :pdf'
      pending 'if format_identifier is :unknown and mime_type is not specified must fail with 422'

      pending 'if format_identifier is :pdf and data is not a pdf must fail with 422'
      pending 'if format_identifier is :p7m and data is not a pkcs#7 must fail with 422'
      pending 'if format_identifier is :unknown data is not verified'
    end
  end

  context 'ZFolder' do
    pending 'should create a folder'
    pending 'to create a folder must specify identifier, folder identifier, label'
    pending 'should move a document into another folder'
  end

  it 'should get document in ROOT' do
    get "/api/z_items/#{@root_doc1.identifier}"
    expect(response.status).to eq(200)

    expect(json[:label]).to eq(@root_doc1.label)
  end
end