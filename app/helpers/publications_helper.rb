# frozen_string_literal: true

module PublicationsHelper
  def all_authors(publication)
    author_list = ''
    size = [0, (publication.author_first_name.count - 1)].max
    (0..size).each do |i|
      author_list += author_name(publication, i)
      author_list += if i == size
                       ' '
                     else
                       ', '
                     end
    end
    author_list
  end

  def author_citation(publication)
    return '' if publication.blank? || publication.author_first_name.nil? || publication.author_last_name.nil?

    author_list = ''
    size = [0, (publication.author_first_name.count - 1)].max
    if size.zero?
      author_list += author_name_citation(publication, 0)
    else
      (0..size).each do |i|
        next unless i != size

        author_list += author_name_citation(publication, i)
        author_list += if i == size
                         ''
                       elsif i == (size - 1)
                         " and #{author_name(publication, size)}"
                       else
                         ', '
                       end
      end
    end
    author_list
  end

  def authors_array(publication)
    return [] if publication.blank? || publication.author_first_name.nil? || publication.author_last_name.nil?

    author_array = []
    size = [0, (publication.author_first_name.count - 1)].max
    (0..size).each do |i|
      author_array << (Truncato.truncate author_name(publication, i), max_length: 12)
    end
    author_array
  end

  def author_name(publication, position)
    "#{publication.author_first_name[position]} #{publication.author_last_name[position]}"
  end

  def author_name_citation(publication, position)
    "#{publication.author_last_name[position]}, #{publication.author_first_name[position]}"
  end

  def author_comma(publication, position)
    "#{publication.author_last_name[position]}, #{publication.author_first_name[position]}"
  end

  def publications_id(id)
    "#{publications_path}/#{id}"
  end

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

  def author_or_artist_label
    params['controller'] == 'artworks' ? 'Artist' : 'Author'
  end

  private

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
