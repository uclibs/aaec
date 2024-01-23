require 'rails_helper'

RSpec.describe FeatureSpecHelpers::AuthorManagement do
  include described_class

  let(:mock_first_name_field0) { double('Capybara Node Element', value: 'FirstName0') }
  let(:mock_last_name_field0) { double('Capybara Node Element', value: 'LastName0') }
  let(:mock_first_name_field1) { double('Capybara Node Element', value: 'FirstName1') }
  let(:mock_last_name_field1) { double('Capybara Node Element', value: 'LastName1') }
  let(:mock_first_name_field2) { double('Capybara Node Element', value: 'FirstName2') }
  let(:mock_last_name_field2) { double('Capybara Node Element', value: 'LastName2') }


  let(:parent_element_with_button) { double('Capybara Node Element') }
  let(:parent_element_without_button) { double('Capybara Node Element') }

  let(:remove_button) { double('Capybara Node Element', text: 'Remove Author') }

  before do
    allow(remove_button).to receive(:click)

    allow(parent_element_without_button).to receive(:find).with('button', text: 'Remove Author', match: :first)
                                                          .and_raise(Capybara::ElementNotFound, 'Element not found')
    allow(parent_element_with_button).to receive(:find).with('button', text: 'Remove Author', match: :first).and_return(remove_button)

    allow(self).to receive(:first_name_fields).and_return([mock_first_name_field0, mock_first_name_field1, mock_first_name_field2])
    allow(self).to receive(:last_name_fields).and_return([mock_last_name_field0, mock_last_name_field1, mock_last_name_field2])
  end

  describe '#remove_author_at_index' do
    context 'when the author can be removed' do
      it 'removes the author at the specified index' do
        allow(mock_first_name_field1).to receive(:find).with(:xpath, '../..').and_return(parent_element_with_button)
        expect(remove_button).to receive(:click)
        remove_author_at_index(1) # The second author can be removed
      end
      it 'fails a test' do
        expect(true).to be_falsey
      end
    end
    context 'when the author cannot be removed' do
      it 'does not remove the first author' do
        allow(mock_first_name_field0).to receive(:find).with(:xpath, '../..').and_return(parent_element_without_button)
        expect(remove_button).not_to receive(:click)

        remove_author_at_index(0) # The first author cannot be removed
      end
    end

    it 'does nothing if the index is invalid' do
      expect(self).not_to receive(:find_parent_element)
      remove_author_at_index(100) # Assuming this is an invalid index
    end
  end

  describe '#check_field_values_by_index' do
    context 'when the field values match the expected values' do
      it 'returns true' do
        expect(self).to receive(:verify_field_value).with(fields: first_name_fields,
                                                          index: 0,
                                                          expected_value: 'FirstName0',
                                                          field_name: 'First name')
                                                    .and_return(true)
        expect(self).to receive(:verify_field_value).with(fields: last_name_fields,
                                                          index: 0,
                                                          expected_value: 'LastName0',
                                                          field_name: 'Last name')
                                                    .and_return(true)
        check_field_values_by_index(0, 'FirstName0', 'LastName0')
      end
    end
    context 'when the field values do not match the expected values' do
      it 'returns false' do
        expect(self).to receive(:verify_field_value).with(fields: first_name_fields,
                                                          index: 0,
                                                          expected_value: 'WrongName',
                                                          field_name: 'First name')
                                                    .and_return(false)
        expect(self).to receive(:verify_field_value).with(fields: last_name_fields,
                                                          index: 0,
                                                          expected_value: 'WrongName',
                                                          field_name: 'Last name')
                                                    .and_return(false)
        check_field_values_by_index(0, 'WrongName', 'WrongName')
      end
    end
    it 'does nothing if the index is invalid' do
      expect(self).not_to receive(:verify_field_value)
      check_field_values_by_index(100, 'Value', 'Value') # Invalid index
    end
  end
end
