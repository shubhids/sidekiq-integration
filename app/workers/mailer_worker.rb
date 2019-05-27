class MailerWorker
  include Sidekiq::Worker
  sidekiq_options retry: 1

  sidekiq_retries_exhausted do |msg, ex|
    Sidekiq.logger.warn "Failed #{msg['class']} with #{msg['args']}: #{msg['error_message']}"
  end

  def perform(mailer_class, mailer_method, *args)
  	begin
    	mailer_class.constantize.send(mailer_method, *args).deliver
  	rescue => e
  		fail e
  	end
  end
end
