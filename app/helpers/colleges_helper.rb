# frozen_string_literal: true

module CollegesHelper
  def all_colleges(colleges)
    college_list = ''
    size = [0, (colleges.count - 1)].max
    (0..size).each do |i|
      college_list += college_name(colleges[i])
      college_list += if i == size
                        ''
                      else
                        ', '
                      end
    end
    college_list
  end

  def check_other_college(publication)
    return_string = ''
    return_string = ": #{publication.other_college}" if 16.in? publication.college_ids
    return_string
  end

  def college_name(id)
    College.name_for(id)
  end

  def college_array(publication)
    size = [0, (publication.college_ids.count - 1)].max
    (0..size).map do |i|
      if publication.college_ids[i] == 16
        college_name(publication.college_ids[i]) + ": #{publication.other_college}"
      else
        college_name(publication.college_ids[i])
      end
    end
  end
end
