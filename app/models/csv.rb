# frozen_string_literal: true

module Csv
  def authors
    author_list = ''
    size = [0, (author_first_name.count - 1)].max
    (0..size).each do |i|
      author_list += author_name(i)
      author_list += if i == size
                       ''
                     else
                       ', '
                     end
    end
    author_list
  end

  def author_name(position)
    "#{author_first_name[position]} #{author_last_name[position]}"
  end

  def college_name(id)
    if id.nil?
      ''
    else
      College.find(id).name
    end
  end

  def colleges
    college_string = ''
    size = [0, (college_ids.count - 1)].max
    (0..size).each do |i|
      college_string += if college_ids[i] == 16
                          college_name(college_ids[i]) + ": #{other_college}"
                        else
                          college_name(college_ids[i])
                        end
      college_string += if i == size
                          ''
                        else
                          ' | '
                        end
    end
    college_string
  end

  def submitter_college
    college_string = ''
    college_string += if college == 16
                        college_name(college) + ": #{department}"
                      else
                        college_name(college)
                      end
    college_string
  end
end
