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

  def author_comma(publication, position)
    publication.author_last_name[position] + ', ' + publication.author_first_name[position]
  end

  def publications_id(id)
    publications_path + '/' + id.to_s
  end
end
