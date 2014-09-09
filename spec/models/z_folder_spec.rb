require 'rails_helper'

RSpec.describe ZFolder, type: :model do
  context 'Class methods' do
    subject { ZFolder }
    it { should respond_to(:root) }
  end
end