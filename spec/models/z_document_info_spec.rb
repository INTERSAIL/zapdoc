require 'rails_helper'

RSpec.describe ZDocumentInfo, type: :model do
  it_behaves_like 'z_item_info'

  it { should respond_to(:format_identifier) }
  it { should respond_to(:mime_type) }
end