# frozen_string_literal: true

require 'rails_helper'

describe 'Form Layout Test', type: :feature, js: true do
  let(:submitter) { FactoryBot.build(:submitter) }

  context 'while entering in information as a new submitter' do
    it 'adjusts layout from one to two columns based on screen width' do
      visit root_path
      mobile_has_one_column
      tablet_has_two_columns
      desktop_has_two_columns
    end
  end

  context 'while adding a new author' do
    it 'adjusts layout from one to two columns based on screen width' do
      create_submitter(submitter)
      visit new_book_path
      click_button('Add Author')
      click_button('Add Author')
      mobile_has_one_column
      tablet_has_two_columns
      desktop_has_three_columns
    end
  end

  def container_width
    page.evaluate_script("document.querySelector('.form-container').offsetWidth").to_i
  end

  def delete_button_width
    page.evaluate_script("document.querySelector('.form-delete-button') ? document.querySelector('.form-delete-button').offsetWidth : 0").to_i
  end

  def mobile_has_one_column
    # Mobile view: Expect items to take full container width, indicating a one-column layout
    resize_window_to_mobile

    verify_one_column_widths
    verify_one_column_heights
  end

  def tablet_has_two_columns
    # Tablet view: Expect items to take about half the container width, indicating a two-column layout
    # The delete button on author form-items will be on a separate line so not counted in the width.
    resize_window_to_tablet

    verify_two_column_item_widths
    verify_two_column_item_heights
  end

  def desktop_has_two_columns
    # Desktop view: Expect items to take half container width, indicating a two-column layout
    # There is no delete button, so it is not counted in the width.
    resize_window_to_desktop

    verify_two_column_item_widths
    verify_two_column_item_heights
  end

  def desktop_has_three_columns
    # Desktop view: Each form-item should take up half of the
    # container width, minus the width of the delete button
    resize_window_to_desktop
    click_button('Add Author')

    verify_three_column_item_widths
    verify_three_column_item_heights
  end

  def verify_one_column_widths
    expected_item_width = container_width - 10 # Subtract padding

    all('.form-item').each do |item|
      item_width = page.evaluate_script('arguments[0].offsetWidth', item.native).to_i
      expect(item_width).to be_within(5).of(expected_item_width)
    end
  end

  def verify_one_column_heights
    heights = retrieve_item_offsets

    expect(heights[0]).not_to eq(heights[1])
  end

  def verify_two_column_item_widths
    expected_item_width = calculate_expected_item_width(intake_field_count: 2, gap_count: 1)

    all('.form-item').each do |item|
      item_width = page.evaluate_script('arguments[0].offsetWidth', item.native).to_i

      expect(item_width).to be_within(5).of(expected_item_width)
    end
  end

  def verify_two_column_item_heights
    heights = retrieve_item_offsets
    expect(heights[0]).to eq(heights[1])
    expect(heights[1]).not_to eq(heights[2])
  end

  def verify_three_column_item_widths
    expected_item_width = calculate_expected_item_width(intake_field_count: 2, gap_count: 2)

    all('.form-item').each do |item|
      item_width = page.evaluate_script('arguments[0].offsetWidth', item.native).to_i

      expect(item_width).to be_within(5).of(expected_item_width)
    end
  end

  def verify_three_column_item_heights
    heights = retrieve_item_offsets
    puts "heights: #{heights}"
    expect(heights[0..2].uniq.size).to eq(1)
    expect(heights[2]).not_to eq(heights[3])
  end

  # Returns an array of the heights (y-values) of the bottoms of each of the children
  # for the form-container.
  # This is used to determine if the form-items are on the same line or not.
  # I am using the bottom because the heights of the items are not consistent
  # and they are aligned by their bottoms.
  def retrieve_item_offsets
    script = "  Array.from(document.querySelector('.form-container').children).map(function(child) {return child.offsetTop + child.clientHeight; });"
    page.evaluate_script(script)
  end

  def calculate_expected_item_width(intake_field_count:, gap_count: 0, space_between_items: 10)
    total_gap_width = space_between_items * gap_count
    available_width_for_items = container_width - total_gap_width - delete_button_width

    available_width_for_items / intake_field_count
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
