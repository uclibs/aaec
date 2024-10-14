# frozen_string_literal: true

# PublicationsHelper Module
#
# This helper module provides utility functions for handling publications, particularly for formatting and creating
# publication details such as authors, citations, and other publication attributes.
#
# Methods:
#   - all_authors(publication)          : Constructs a string of all authors for a given publication
#   - author_citation(publication)      : Constructs a citation style string for authors
#   - authors_array(publication)        : Returns an array of truncated author names for a given publication
#   - author_name(publication, position): Returns the name of an author at a specific position
#   - author_name_citation(publication, position): Returns the citation style name of an author at a specific position
#   - author_comma(publication, position): Returns the name of an author at a specific position with a comma between the last and first name
#   - publications_id(id)                : Returns the full URL for a given publication ID
#   - create_citation(publication)       : Constructs a full citation string for a given publication
#   - author_or_artist_label             : Returns either 'Artist' or 'Author' based on the context
#
# Private Methods:
#   - preprocess_attr(publication, *attrs) : Utility method to preprocess attributes for a given publication
#

module PublicationsHelper
  # Constructs a string of all authors for a given publication.
  #
  # @param [Object] publication
  # @return [String] A string of all authors separated by commas
  def all_authors(publication)
    author_list = ''
    last_author_index = [0, (publication.author_first_name.count - 1)].max
    (0..last_author_index).each do |i|
      author_list += author_name(publication, i)
      author_list += if i == last_author_index
                       ' '
                     else
                       ', '
                     end
    end
    author_list
  end

  # Constructs a citation-style string for authors.
  #
  # @param [Object] publication
  # @return [String] A string representation of authors in citation format
  def author_citation(publication)
    return '' if publication.blank? || publication.author_first_name.nil? || publication.author_last_name.nil?
    return ', ' if publication.author_first_name.blank? && publication.author_last_name.blank?

    last_author_index = publication.author_first_name.count - 1

    # Handle cases with only one author
    return author_name_citation(publication, 0) if last_author_index.zero?

    # Create a list of author names for all but the last author
    author_list = (0...last_author_index).map do |i|
      author_name_citation(publication, i)
    end.join(', ')

    # Append the last author's name in "First Last" format
    author_list + " and #{author_name(publication, last_author_index)}"
  end

  # Returns an array of truncated author names for a given publication.
  #
  # @param [Object] publication
  # @return [Array] An array of author names truncated to 12 characters
  def authors_array(publication)
    return [] if publication.blank? || publication.author_first_name.nil? || publication.author_last_name.nil?

    last_author_index = [0, (publication.author_first_name.count - 1)].max
    (0..last_author_index).map do |i|
      (Truncato.truncate author_name(publication, i), max_length: 12)
    end
  end

  # Returns the full name of an author at a specific position.
  #
  # @param [Object] publication
  # @param [Integer] position The index of the author in the list
  # @return [String] Full name of the author
  def author_name(publication, position)
    "#{publication.author_first_name[position]} #{publication.author_last_name[position]}"
  end

  # Returns the name of an author at a specific position in citation format.
  #
  # @param [Object] publication
  # @param [Integer] position The index of the author in the list
  # @return [String] Full name of the author in citation format
  def author_name_citation(publication, position)
    "#{publication.author_last_name[position]}, #{publication.author_first_name[position]}"
  end

  # Returns the name of an author at a specific position with a comma in between the last name and first name.
  #
  # @param [Object] publication
  # @param [Integer] position The index of the author in the list
  # @return [String] Full name of the author with a comma
  def author_comma(publication, position)
    "#{publication.author_last_name[position]}, #{publication.author_first_name[position]}"
  end

  # Returns the full URL for a given publication ID.
  #
  # @param [Integer] id The ID of the publication
  # @return [String] The full URL for the publication
  def publications_id(id)
    "#{publications_path}/#{id}"
  end

  # Constructs a full citation string for a given publication.
  #
  # @param [Object] publication
  # @return [String] A string representing the full citation
  def create_citation(publication)
    return if publication.nil?

    return_string = "#{author_citation(publication)}. "

    # Prefer the city over the location
    city_or_location = preprocess_attr(publication, :city, :location)

    # Prefer the publication date over the date
    publication_date_or_date = preprocess_attr(publication, :publication_date, :date)

    # Prefer the DOI over the URL
    doi_or_url = preprocess_attr(publication, :doi, :url)

    attributes_to_check = [
      { attr: preprocess_attr(publication, :other_title), format: '“%s”. ' },
      { attr: preprocess_attr(publication, :work_title), format: '<i>%s</i>' },
      { attr: city_or_location, format: ', %s' },
      { attr: preprocess_attr(publication, :publisher), format: ', %s' },
      { attr: preprocess_attr(publication, :volume), format: ', vol. %s' },
      { attr: preprocess_attr(publication, :issue), format: ', no. %s' },
      { attr: publication_date_or_date, format: ', %s' },
      { attr: preprocess_attr(publication, :page_numbers), format: ', pp. %s' },
      { attr: doi_or_url, format: '. %s' }
    ].compact

    attributes_to_check.each do |item|
      return_string << (item[:format] % item[:attr]) if item[:attr]
    end

    return_string.chomp!(', ')
    return_string << '.'

    return_string
  end

  # Returns either 'Artist' or 'Author' based on the controller context.
  #
  # @return [String] Either 'Artist' or 'Author'
  def author_or_artist_label
    params['controller'] == 'artworks' ? 'Artist' : 'Author'
  end

  private

  # Utility method to preprocess attributes for a given publication.
  #
  # @param [Object] publication
  # @param [Array] attrs List of attribute names to preprocess
  # @return [String, nil] Preprocessed attribute value or nil if not found
  def preprocess_attr(publication, *attrs)
    attrs.each do |attr|
      if publication.respond_to?(attr) && publication.send(attr).present?
        value = publication.send(attr)
        return value.is_a?(String) ? value.strip : nil
      end
    end
    nil
  end
end
