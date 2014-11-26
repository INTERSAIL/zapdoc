require 'rails_helper'

RSpec.shared_examples_for 'an item' do
  context 'Database Columns' do
    it { should have_db_column :id }
    it { should have_db_column :label }
    it { should have_db_column :custom_attributes }
    it { should have_db_column :tags }
    it { should have_db_column :revision }
    it { should have_db_column :format_identifier }
    it { should have_db_column :mime_type }
    it { should have_db_column :folder_id }
  end

  it 'have an id alias to identifier' do
    first_value = 1
    second_value = 2

    # first value to second value
    subject.id = first_value
    expect { subject.identifier = second_value }
    .to change { subject.id }
        .from(first_value)
        .to(second_value)

    #second value to first value
    expect { subject.id = first_value }
    .to change { subject.identifier }
        .from(second_value)
        .to(first_value)
  end
end