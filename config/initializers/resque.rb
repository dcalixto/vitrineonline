#require 'resque/server'
#require 'resque_web'


#config.active_job.queue_adapter = :sidekiq


ActionMailer::Base.register_interceptor(SidekiqSendMail::MailInterceptor)
