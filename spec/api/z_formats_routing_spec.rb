require 'api_helper'

RSpec.describe 'Formats', type: :request do
  def expect_format(json, id, mime_type, default)
    sel = json.select { |j| j[:id] == id }

    expect(sel.count).to eq(1)
    expect(sel[0][:default]).to eq(default)
    expect(sel[0][:mime_type]).to eq(mime_type)
  end

  before(:all) do
    ZFormat.destroy_all
    @unknown = ZFormat.create!(description: 'Unknown format', mime_type: 'application/octet-stream', accepted_extensions: [], default: true)
    @pdf = ZFormat.create!(description: 'PDF', mime_type: 'application/pdf', accepted_extensions: ['pdf'], default: false)
    @p7m = ZFormat.create!(description: 'PKCS#7', mime_type: 'application/pkcs7-data', accepted_extensions: ['pdf'], default: false)
    @txt = ZFormat.create!(description: 'Plain Text', mime_type: 'text/plain', accepted_extensions: ['txt'], default: false)
  end

  it 'should list known formats' do
    get '/api/z_formats'

    expect(response).to be_success
    expect(json.count).to eq(4)
  end

  it 'list must include :unknown with mime_type application/octet-stream and default=true' do
    get '/api/z_formats'

    expect_format(json, @unknown.id, 'application/octet-stream', true)
  end

  it 'list must include :pdf with mime_type application/pdf' do
    get '/api/z_formats'

    expect_format(json, @pdf.id, 'application/pdf', false)
  end

  it 'list must include :p7m with mime_type application/pkcs7-data' do
    get '/api/z_formats'

    expect_format(json, @p7m.id, 'application/pkcs7-data', false)
  end

  it 'list must include :txt with mime_type text/plain' do
    get '/api/z_formats'

    expect_format(json, @txt.id, 'text/plain', false)
  end

  it 'should return the default format' do
    get '/api/z_formats/default'

    expect_format([json], @unknown.id, 'application/octet-stream', true)
  end
end