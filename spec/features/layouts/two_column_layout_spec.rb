# frozen_string_literal: true

require 'rails_helper'

describe 'Two Column Layout Test', type: :feature, js: true do
  let(:submitter) { FactoryBot.build(:submitter) }

  context 'while submitting a new publication', skip: true do
    # context 'when there is just one author' do
    #   it 'adjusts layout from one to two columns based on screen width' do
    #     create_submitter(submitter)
    #     visit new_other_publication_path
    #
    #     two_column_layout_present
    #     columns_layout_correct_on_all_devices
    #   end
    # end
  end

  context 'while editing an existing publication', skip: true do
    skip true
  end

  context 'while viewing a publication', skip: true do
    skip true
  end

  context 'while entering in information as a new submitter' do
    it 'adjusts layout from one to two columns based on screen width' do
      visit root_path
      two_column_layout_present
      columns_layout_correct_on_all_devices
    end
  end

  def container_width
    page.evaluate_script("document.querySelector('.two-column-form').offsetWidth").to_i - 20
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
      item_width = page.evaluate_script('arguments[0].offsetWidth', item.native).to_i
      expect(item_width).to be_within(10).of(container_width)
    end
  end

  def columns_layout_correct_on_tablet
    # Tablet view: Expect items to take half container width, indicating a two-column layout
    resize_window_to_tablet
    all('.two-column-item').each do |item|
      item_width = page.evaluate_script('arguments[0].offsetWidth', item.native).to_i
      expect(item_width).to be_within(10).of(container_width * 0.45)
    end
  end

  def columns_layout_correct_on_desktop
    # Desktop view: Expect items to take half container width, indicating a two-column layout
    resize_window_to_desktop
    all('.two-column-item').each do |item|
      item_width = page.evaluate_script('arguments[0].offsetWidth', item.native).to_i
      expect(item_width).to be_within(10).of(container_width * 0.45)
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
