class LinkMailer < ActionMailer::Base
  default :from => 'demo4582@gmail.com'

  def share_by_email(links, contacts, subject )
    # I am overriding the 'to' default\
    @links = links
    content_type = "text/html"
    mail(to: contacts, subject: subject, content_type: "text/html")
  end
end
