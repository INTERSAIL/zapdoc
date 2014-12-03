require 'rails_helper'
#@jtodoIMP
RSpec.describe ZItemInfo, type: :model do
  context 'Database Mapping' do
    it { should respond_to(:label) }
    it { should respond_to(:type) }
    it { should respond_to(:created_at) }
    it { should respond_to(:revision) }

    it { should_not be_persisted }

  end

  pending 'can be created from z_document, copy all attributes'
  pending 'can be created from z_folder, copy all attributes'
  pending 'can be created from a collection of z_items, copy all attributes'

end