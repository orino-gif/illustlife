creds = Aws::Credentials.new(Rails.application.credentials[:aws][:access_key_id], Rails.application.credentials[:aws][:secret_access_key])

Aws::Rails.add_action_mailer_delivery_method(
  :ses,
  credentials: creds,
  region: 'ap-us-east-1' #AWS SESで設定したregion 
)
