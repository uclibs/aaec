# frozen_string_literal: true

module CollegesHelper
  def all_colleges(colleges)
    college_list = ''
    size = [0, (colleges.count - 1)].max
    (0..size).each do |i|
      college_list += college_name(colleges[i])
      college_list += if i != size
                        ', '
                      else
                        ' '
                      end
    end
    college_list
  end

  def college_name(id)
    if id.nil?
      ''
    else
      College.find(id).name
    end
  end
end
