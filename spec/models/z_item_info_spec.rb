require 'rails_helper'

RSpec.describe ZItemInfo, type: :model do
  it_behaves_like 'z_item_info'

  pending 'can be created from z_document, copy all attributes'
  pending 'can be created from z_folder, copy all attributes'
  pending 'can be created from a collection of z_items, copy all attributes'
end