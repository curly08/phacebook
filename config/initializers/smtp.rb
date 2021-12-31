ActionMailer::Base.smtp_settings = {
  domain: 'evening-gorge-63419.herokuapp.com',
  address:        "smtp.sendgrid.net",
  port:            587,
  authentication: :plain,
  user_name:      'apikey',
  password:       ENV['SENDGRID_API_KEY']
}
