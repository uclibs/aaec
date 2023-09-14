# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PublicationsHelper, type: :helper do
  let(:other_publication) { FactoryBot.create(:other_publication) }

  describe '#create_citation' do
    let(:publication) do
      double(
        author_first_name: ['John'],
        author_last_name: ['Doe'],
        other_title: 'A Study in Ruby',
        work_title: 'Programming 101',
        location: 'San Francisco',
        city: '',
        publisher: 'Ruby Press',
        volume: '1',
        issue: '2',
        date: '',
        publication_date: '2021',
        page_numbers: '10-20',
        doi: '',
        url: 'http://example.com'
      )
    end

    context 'when all attributes are present' do
      it 'returns the complete citation string' do
        expect(helper.create_citation(publication)).to eq(
          'Doe, John. “A Study in Ruby”. <i>Programming 101</i>, San Francisco, Ruby Press, vol. 1, no. 2, 2021, pp. 10-20. http://example.com.'
        )
      end
    end

    context 'when some attributes are missing' do
      it 'returns a citation string without the missing attributes' do
        allow(publication).to receive(:other_title).and_return(nil)
        expect(helper.create_citation(publication)).to eq(
          'Doe, John. <i>Programming 101</i>, San Francisco, Ruby Press, vol. 1, no. 2, 2021, pp. 10-20. http://example.com.'
        )
      end
    end

    context 'when publication is nil' do
      it 'returns nil' do
        expect(helper.create_citation(nil)).to be_nil
      end
    end

    context 'when multiple authors are present' do
      it 'correctly formats multiple authors' do
        allow(publication).to receive(:author_first_name).and_return(%w[John Jane])
        allow(publication).to receive(:author_last_name).and_return(%w[Doe Smith])
        expect(helper.create_citation(publication)).to include('Doe, John and Jane Smith.')
      end
    end

    context 'when volume is present but issue is blank' do
      it 'returns the correct string' do
        allow(publication).to receive(:issue).and_return('')
        expect(helper.create_citation(publication)).to include(', vol. 1, ')
      end
    end

    context 'when DOI is present' do
      it 'includes DOI in the citation' do
        allow(publication).to receive(:doi).and_return('doi:12345')
        expect(helper.create_citation(publication)).to include('. doi:12345.')
      end
    end

    context 'when location and city both have values' do
      it 'includes only the city' do
        allow(publication).to receive(:city).and_return('CA')
        allow(publication).to receive(:location).and_return('San Francisco')
        expect(helper.create_citation(publication)).to_not include('San Francisco')
        expect(helper.create_citation(publication)).to include('CA')
      end
    end

    context 'when neither DOI nor URL are present' do
      it 'omits both from the citation' do
        allow(publication).to receive(:doi).and_return('')
        allow(publication).to receive(:url).and_return('')
        expect(helper.create_citation(publication)).not_to include('http://')
        expect(helper.create_citation(publication)).not_to include('doi:')
      end
    end

    context 'when both DOI and URL are present' do
      it 'prioritizes DOI over URL' do
        allow(publication).to receive(:doi).and_return('doi:12345')
        expect(helper.create_citation(publication)).to include('. doi:12345.')
        expect(helper.create_citation(publication)).not_to include('http://example.com')
      end
    end

    context 'when page_numbers are blank' do
      it 'omits page numbers from the citation' do
        allow(publication).to receive(:page_numbers).and_return('')
        expect(helper.create_citation(publication)).not_to include('pp.')
      end
    end

    context 'when special characters are present in the title' do
      it 'correctly encodes and displays special characters' do
        allow(publication).to receive(:other_title).and_return('Study’s in Ruby')
        # Uses the rounded apostrophe character ’ instead of the straight apostrophe '
        expect(helper.create_citation(publication)).to include('Study’s in Ruby')
      end
    end

    context 'when emojis are present in the title' do
      it 'correctly includes emojis' do
        allow(publication).to receive(:other_title).and_return('Study in Ruby 😃')
        expect(helper.create_citation(publication)).to include('Study in Ruby 😃')
      end
    end

    context 'when HTML-like tags are present in the title' do
      it 'correctly encodes and displays HTML-like tags' do
        allow(publication).to receive(:other_title).and_return('Study in <Ruby>')
        expect(helper.create_citation(publication)).to include('Study in <Ruby>')
      end
    end

    context 'when invalid data types are present' do
      it 'handles it gracefully' do
        allow(publication).to receive(:publication_date).and_return(12_345)
        # We received a number instead of a date-time here. It should not be included in the citation.
        expect { helper.create_citation(publication) }.to_not raise_error
        expect(helper.create_citation(publication)).not_to include('12345')
      end
    end

    context 'when title contains extra spaces' do
      it 'trims the spaces' do
        allow(publication).to receive(:other_title).and_return('  A Study in Ruby  ')
        expect(helper.create_citation(publication)).to eq(
          'Doe, John. “A Study in Ruby”. <i>Programming 101</i>, San Francisco, Ruby Press, vol. 1, no. 2, 2021, pp. 10-20. http://example.com.'
        )
      end
    end
  end
end
