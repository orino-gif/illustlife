Rails.application.configure do
  config.cache_classes = false

  config.eager_load = false
  
  #ログレベル ( :debug | :info | :warn | :error | :fatal )
  config.log_level = :debug 

  config.consider_all_requests_local = true

  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  config.action_mailer.default_url_options = { host: '160.16.136.195', port: 3000 }

  config.action_mailer.delivery_method = :ses

  config.action_mailer.perform_caching = false

  config.active_support.deprecation = :log

  config.active_record.migration_error = :page_load

  config.active_record.verbose_query_logs = true

  config.assets.debug = true

  config.assets.quiet = true

  # config.action_view.raise_on_missing_translations = true

  config.file_watcher = ActiveSupport::EventedFileUpdateChecker
  
  #master.keyがない環境ではRails起動時にエラーになるように
  config.require_master_key = true
  
  #ホワイトリスト例外。0.0.0.0/0からのrender console要求を許可する。
  config.web_console.whitelisted_ips = '0.0.0.0/0'
  
  #メール送受信でエラーがあった場合に、エラー内容を出力する
  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.delivery_method = :smtp
	config.action_mailer.smtp_settings = {
	  port:                 587,
	  address:              'mail.so-net.ne.jp',
		domain:               'so-net.ne.jp',
		user_name:            'xr274375@fc5.so-net.ne.jp',
		password:             'orino1013',
		authentication:       'login'
	 }
end
