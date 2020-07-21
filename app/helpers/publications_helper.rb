# frozen_string_literal: true

module PublicationsHelper
  def all_authors(publication)
    author_list = ''
    size = [0, (publication.author_first_name.count - 1)].max
    (0..size).each do |i|
      author_list += author_name(publication, i)
      author_list += if i != size
                       ', '
                     else
                       ' '
                     end
    end
    author_list
  end

  def author_citation(publication)
    author_list = ''
    size = [0, (publication.author_first_name.count - 1)].max
    if size.zero?
      author_list += author_name_citation(publication, 0)
    else
      (0..size).each do |i|
        next unless i != size

        author_list += author_name_citation(publication, i)
        author_list += if i != size
                         if i == (size - 1)
                           ", #{author_name_citation(publication, size)}"
                         else
                           ', '
                         end
                       else
                         ''
                       end
      end
    end
    author_list
  end

  def authors_array(publication)
    author_array = []
    size = [0, (publication.author_first_name.count - 1)].max
    (0..size).each do |i|
      author_array << (Truncato.truncate author_name(publication, i), max_length: 12)
    end
    author_array
  end

  def author_name(publication, position)
    publication.author_first_name[position] + ' ' + publication.author_last_name[position]
  end

  def author_name_citation(publication, position)
    publication.author_last_name[position] + ', ' + publication.author_first_name[position][0]
  end

  def author_comma(publication, position)
    publication.author_last_name[position] + ', ' + publication.author_first_name[position]
  end

  def publications_id(id)
    publications_path + '/' + id.to_s
  end

  def create_citation(publication)
    return if publication.nil?

    return_string = ''
    return_string += author_citation(publication) + '. '
    # return_string += "(#{publication.publication_date.last(4)}). " if (publication.publication_date != '' if publication.respond_to? :publication_date)
    return_string += '<i>' + publication.work_title
    # return_string += ": #{publication.other_title}" unless publication.other_title.blank?
    return_string += '</i>'
    if (publication.page_numbers != '' if publication.respond_to? :page_numbers)
      return_string += ' ('
      return_string += "Vol. #{publication.volume}, " if (publication.volume != '' if publication.respond_to? :volume)
      return_string += "pp. #{publication.page_numbers}). "
    else
      return_string += '. '
    end
    if (publication.date != '' if publication.respond_to? :date) && (publication.location != '' if publication.respond_to? :location)
      return_string += "#{publication.location}, #{publication.date.last(4)}."
    elsif (publication.date != '' if publication.respond_to? :date)
      return_string += "(#{publication.date.last(4)}). "
    elsif (publication.location != '' if publication.respond_to? :location)
      return_string += "#{publication.location}. "
    end
    return_string += "#{publication.publisher}. " if (publication.publisher != '' if publication.respond_to? :publisher)
    return_string += "#{publication.name_of_site}. " if (publication.name_of_site != '' if publication.respond_to? :name_of_site)
    if (publication.doi != '' if publication.respond_to? :doi)
      return_string += "#{publication.doi}. "
    elsif (publication.url != '' if publication.respond_to? :url)
      return_string += "#{publication.url}. "
    end
    return_string
  end
end
