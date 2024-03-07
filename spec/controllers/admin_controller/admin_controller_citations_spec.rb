# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdminController, type: :controller do
  describe 'GET #citations' do
    context 'when departments are present in a college' do
      before do
        session[:admin] = true
        mock_college = double('College', id: 1)
        allow(College).to receive(:find_each).and_yield(mock_college)

        mock_publication1 = double('Publication', college_ids: [1], uc_department: 'Physics', author_last_name: ['Newton'], author_first_name: ['Isaac'], work_title: 'Principia Mathematica')
        mock_publication2 = double('Publication', college_ids: [1], uc_department: 'Mathematics', author_last_name: ['Euler'], author_first_name: ['Leonhard'], work_title: 'Introductio in analysin infinitorum')
        mock_publication3 = double('Publication', college_ids: [1], uc_department: 'Chemistry', author_last_name: ['Curie'], author_first_name: ['Marie'], work_title: 'Research on Radioactive Substances')

        allow(controller).to receive(:fetch_all_records).and_return([mock_publication1, mock_publication2, mock_publication3])
      end

      it 'correctly sorts departments within the college' do
        get :citations

        department_order = assigns(:college_array).find { |element| element[0] == 1 }[1].keys
        expect(department_order).to eq(['Chemistry', 'Mathematics', 'Physics'])
      end
    end

    context 'when publications are present in a department' do
    context 'with multiple authors where the first author is the same' do
      before do
        session[:admin] = true
        mock_college = double('College', id: 1)
        allow(College).to receive(:find_each).and_yield(mock_college)

        # Publications with the same first author, different second authors
        mock_publication1 = double('Publication',
                                   college_ids: [1], uc_department: 'Literature',
                                   author_last_name: ['Smith', 'Anderson'], author_first_name: ['John', 'Michael'], work_title: 'Book One')
        mock_publication2 = double('Publication',
                                   college_ids: [1], uc_department: 'Literature',
                                   author_last_name: ['Smith', 'Bell'], author_first_name: ['John', 'Peter'], work_title: 'Book Two')

        allow(controller).to receive(:fetch_all_records).and_return([mock_publication1, mock_publication2])
      end

      it 'correctly sorts publications within departments by all authors' do
        get :citations

        sorted_publications_literature = assigns(:college_array).find { |element| element[0] == 1 }[1]['Literature']
        expect(sorted_publications_literature.map(&:work_title)).to eq(['Book One', 'Book Two'])
      end
    end
    context 'with a single author having multiple publications' do
      before do
        session[:admin] = true
        mock_college = double('College', id: 1)
        allow(College).to receive(:find_each).and_yield(mock_college)

        # Multiple publications by the same author
        mock_publication1 = double('Publication',
                                   college_ids: [1], uc_department: 'Science',
                                   author_last_name: ['Curie'], author_first_name: ['Marie'], work_title: 'Research Findings')
        mock_publication2 = double('Publication',
                                   college_ids: [1], uc_department: 'Science',
                                   author_last_name: ['Curie'], author_first_name: ['Marie'], work_title: 'Early Experiments')

        allow(controller).to receive(:fetch_all_records).and_return([mock_publication1, mock_publication2])
      end

      it 'sorts publications by the same author within departments by work title' do
        get :citations

        sorted_publications_science = assigns(:college_array).find { |element| element[0] == 1 }[1]['Science']
        expect(sorted_publications_science.map(&:work_title)).to eq(['Early Experiments', 'Research Findings'])
      end
    end
    end

    context 'when logged in as a submitter' do
      before do
        session[:admin] = false
        session[:submitter_id] = FactoryBot.create(:submitter).id
      end

      it 'raises a 404 error' do
        expect { get :citations }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
