require 'rails_helper'
RSpec.describe ZFormat, type: :model do
  context 'Database Mapping' do
    it { should have_db_column(:id).with_options primary: true }
    it { should have_db_column(:description).of_type :string }
    it { should have_db_column(:mime_type).of_type :string }
    it { should have_db_column(:accepted_extensions).of_type :text }
    it { should have_db_column(:default).of_type :boolean }


    it "validate presence of mime_type" do
      should validate_presence_of :mime_type
    end

    it "should allow only boolean values for default" do
      should allow_value(true, false).for :default
    end
  end
end