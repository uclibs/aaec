# frozen_string_literal: true

# The PublicationMailerPreview class is used to preview email templates for the PublicationMailer.
# It fetches a real Submitter and Publication from the database if they exist; otherwise, it uses mock objects.
# This is especially useful for visually testing email layouts and contents in the development environment.
#
# Preview all emails at http://localhost:3000/rails/mailers/publication_mailer
class PublicationMailerPreview < ActionMailer::Preview
  def publication_submit
    submitter = Submitter.first || mock_submitter
    publication = OtherPublication.last || mock_publication

    PublicationMailer.publication_submit(submitter, publication)
  end

  private

  # MockSubmitter serves as a stand-in for the Submitter model during testing.
  # It mimics the interface of the real Submitter model, providing the minimum
  # methods and attributes needed for the PublicationMailerPreview.
  class MockSubmitter
    attr_reader :first_name, :last_name, :email_address

    def initialize(first_name:, last_name:, email_address:)
      @first_name = first_name
      @last_name = last_name
      @email_address = email_address
    end
  end

  # MockPublication serves as a stand-in for the Publication model during testing.
  # It mimics the interface of the real Publication model, providing the minimum
  # methods and attributes needed for the PublicationMailerPreview.
  class MockPublication
    attr_reader :work_title, :author_first_name, :author_last_name

    def initialize(work_title:, author_first_name:, author_last_name:)
      @work_title = work_title
      @author_first_name = author_first_name
      @author_last_name = author_last_name
    end
  end

  def mock_submitter
    MockSubmitter.new(
      first_name: 'John',
      last_name: 'Doe',
      email_address: 'mock@test.com'
    )
  end

  def mock_publication
    MockPublication.new(
      work_title: 'Sample Work Title',
      author_first_name: ['Sample'],
      author_last_name: ['Author']
    )
  end
end
