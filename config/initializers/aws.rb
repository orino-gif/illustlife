# config/initializers/aws_ses.rb
Aws::Rails.add_action_mailer_delivery_method(:aws_sdk, { region: 'us-east-1' })
