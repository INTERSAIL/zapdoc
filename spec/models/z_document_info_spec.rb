require 'rails_helper'
#@jtodoIMP
RSpec.describe ZDocumentInfo, type: :model do
  it { should inherit_from ZItemInfo }

  xit { should respond_to(:format_identifier) }
  xit { should respond_to(:mime_type) }
end