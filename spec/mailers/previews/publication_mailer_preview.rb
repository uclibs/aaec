# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/publication_mailer
class PublicationMailerPreview < ActionMailer::Preview
  def send_publication_submit
    PublicationMailer.publication_submit(Submitter.first, OtherPublication.last)
  end
end
