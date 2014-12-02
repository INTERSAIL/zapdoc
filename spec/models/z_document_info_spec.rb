require 'rails_helper'

RSpec.describe ZDocumentInfo, type: :model do
  it { should inherit_from ZItemInfo }

  it { should respond_to(:format_identifier) }
  it { should respond_to(:mime_type) }
end