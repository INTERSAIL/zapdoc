require 'rails_helper'

RSpec.describe 'Formats', type: :request do
  def expect_format(json, identifier, mime_type, default)
    sel = json.select { |j| j[:identifier] == identifier.to_s }

    expect(sel.count).to eq(1)
    expect(sel[0][:default]).to eq(default)
    expect(sel[0][:mime_type]).to eq(mime_type)
  end

  it 'should list known formats' do
    get '/api/z_formats'
    expect(response.status).to eq(200)

    expect(json.count).to eq(4)
  end

  it 'list must include :unknown with mime_type application/octet-stream and default=true' do
    get '/api/z_formats'
    expect_format(json, :unknown, 'application/octet-stream', true)
  end

  it 'list must include :pdf with mime_type application/pdf' do
    get '/api/z_formats'
    expect_format(json, :pdf, 'application/pdf', false)
  end

  it 'list must include :p7m with mime_type application/pkcs7-data' do
    get '/api/z_formats'
    expect_format(json, :p7m, 'application/pkcs7-data', false)
  end

  it 'list must include :txt with mime_type text/plain' do
    get '/api/z_formats'
    expect_format(json, :txt, 'text/plain', false)
  end

  it 'should return the default format' do
    get '/api/z_formats/default'
    expect_format([json], :unknown, 'application/octet-stream', true)
  end
end