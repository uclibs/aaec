# frozen_string_literal: true

collegeArray = []

College.all.each { |college|
    collegeArray.push(college.name)
}

if collegeArray.exclude? 'Allied Health Sciences' then College.create(name: 'Allied Health Sciences') end
if collegeArray.exclude? 'Arts and Sciences' then College.create(name: 'Arts and Sciences') end
if collegeArray.exclude? 'Business' then College.create(name: 'Business') end
if collegeArray.exclude? 'Conservatory of Music' then College.create(name: 'Conservatory of Music') end
if collegeArray.exclude? 'Design, Architecture, Art, and Planning' then College.create(name: 'Design, Architecture, Art, and Planning') end
if collegeArray.exclude? 'Education, Criminal Justice, and Human Services' then College.create(name: 'Education, Criminal Justice, and Human Services') end
if collegeArray.exclude? 'Engineering and Applied Science' then College.create(name: 'Engineering and Applied Science') end
if collegeArray.exclude? 'The Graduate School' then College.create(name: 'The Graduate School') end
if collegeArray.exclude? 'Law' then College.create(name: 'Law') end
if collegeArray.exclude? 'Medicine' then College.create(name: 'Medicine') end
if collegeArray.exclude? 'Nursing' then College.create(name: 'Nursing') end
if collegeArray.exclude? 'Pharmacy' then College.create(name: 'Pharmacy') end
if collegeArray.exclude? 'UCBA' then College.create(name: 'UCBA') end
if collegeArray.exclude? 'UC Clermont' then College.create(name: 'UC Clermont') end
if collegeArray.exclude? 'UC Libraries' then College.create(name: 'UC Libraries') end
if collegeArray.exclude? 'Other' then College.create(name: 'Other') end