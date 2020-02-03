# frozen_string_literal: true

college_array = []

College.all.each do |college|
  college_array.push(college.name)
end

College.create(name: 'Allied Health Sciences') if college_array.exclude? 'Allied Health Sciences'
College.create(name: 'Arts and Sciences') if college_array.exclude? 'Arts and Sciences'
College.create(name: 'Business') if college_array.exclude? 'Business'
College.create(name: 'Conservatory of Music') if college_array.exclude? 'Conservatory of Music'
College.create(name: 'Design, Architecture, Art, and Planning') if college_array.exclude? 'Design, Architecture, Art, and Planning'
College.create(name: 'Education, Criminal Justice, and Human Services') if college_array.exclude? 'Education, Criminal Justice, and Human Services'
College.create(name: 'Engineering and Applied Science') if college_array.exclude? 'Engineering and Applied Science'
College.create(name: 'The Graduate School') if college_array.exclude? 'The Graduate School'
College.create(name: 'Law') if college_array.exclude? 'Law'
College.create(name: 'Medicine') if college_array.exclude? 'Medicine'
College.create(name: 'Nursing') if college_array.exclude? 'Nursing'
College.create(name: 'Pharmacy') if college_array.exclude? 'Pharmacy'
College.create(name: 'UCBA') if college_array.exclude? 'UCBA'
College.create(name: 'UC Clermont') if college_array.exclude? 'UC Clermont'
College.create(name: 'UC Libraries') if college_array.exclude? 'UC Libraries'
College.create(name: 'Other') if college_array.exclude? 'Other'
