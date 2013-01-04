module Ketchup

  module Handler

    extend self

    def action(*args)
      options = args.extract_options!
      handler = args.first
      self.send(handler, options)
    end

    private

    def mail(args={})
      error = args[:exception]
      host = args[:host]
      Ketchup::Exception::Mailer.notification_email(error,host).deliver   
    end

    def database(args)
      error = args[:exception]
      attributes = {
        :kind => error.class.name,
        :message => error.message,
        :happend_at => Time.now
      }
      if error.respond_to?(:backtrace)
        attributes.merge!(:backtrace => error.backtrace)
      end
      Ketchup::Exception::Error.create(attributes)
    end

  end

end