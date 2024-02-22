# frozen_string_literal: true

require 'rails_helper'

describe 'Two Column Layout Test', type: :feature, js: true do
  let(:submitter) { FactoryBot.build(:submitter) }

  context 'when there is just one author' do
    it 'adjusts layout from one to two columns based on screen width' do
      create_submitter(submitter)
      visit new_other_publication_path

      two_column_layout_present
      columns_layout_correct_on_all_devices
    end
  end

  def two_column_layout_present
    expect(page).to have_css('.two-column-item', minimum: 1)
  end
  def columns_layout_correct_on_all_devices
    columns_layout_correct_on_mobile
    columns_layout_correct_on_tablet
    columns_layout_correct_on_desktop
  end

  def columns_layout_correct_on_mobile
    # Mobile view: Expect items to take full container width, indicating a one-column layout
    resize_window_to_mobile
    all('.two-column-item').each do |item|
      expect(item[:style]).not_to include('width: 50%')
      expect(find('.two-column-item')[:style]).to include('width: 100%')
    end
  end

  def columns_layout_correct_on_tablet
    # Tablet view: Expect items to take full container width, indicating a one-column layout
    resize_window_to_tablet
    all('.two-column-item').each do |item|
      expect(item[:style]).not_to include('width: 50%')
      expect(item[:style]).to include('width: 100%')
    end
  end

  def columns_layout_correct_on_desktop
    # Desktop view: Expect items to take half container width, indicating a two-column layout
    resize_window_to_desktop
    all('.two-column-item').each do |item|
      expect(item[:style]).not_to include('width: 100%')
      expect(item[:style]).to include('width: 50%')
    end
  end

  def resize_window_to_mobile
    page.driver.browser.manage.window.resize_to(360, 640) # Mobile dimensions
  end

  def resize_window_to_tablet
    page.driver.browser.manage.window.resize_to(768, 1024) # Tablet dimensions
  end

  def resize_window_to_desktop
    page.driver.browser.manage.window.resize_to(1024, 768) # Desktop dimensions
  end
end
