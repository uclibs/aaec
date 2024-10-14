# frozen_string_literal: true

# NOTE: This will add 20 of each publication to the first submitter created
add_publications = false

college_array = College.all.map(&:name)

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
College.create(name: 'UC Blue Ash') if college_array.exclude? 'UC Blue Ash'
College.create(name: 'UC Clermont') if college_array.exclude? 'UC Clermont'
College.create(name: 'UC Libraries') if college_array.exclude? 'UC Libraries'
College.create(name: 'Other') if college_array.exclude? 'Other'

if add_publications
  20.times do
    FactoryBot.create(:submitter)
    FactoryBot.create(:book)
    FactoryBot.create(:other_publication)
    FactoryBot.create(:journal_article)
    FactoryBot.create(:editing)
    FactoryBot.create(:artwork)
    FactoryBot.create(:book_chapter)
    FactoryBot.create(:photography)
    FactoryBot.create(:play)
    FactoryBot.create(:musical_score)
    FactoryBot.create(:physical_medium)
    FactoryBot.create(:digital_project)
    FactoryBot.create(:public_performance)
    FactoryBot.create(:film)
  end
end
