module Ketchup

  module Exception

    class Mailer < ::ActionMailer::Base

      def notification_email(err,host)
        @message = err.message
        @host = host
        if err.backtrace.respond_to?(:join)
          @backtrace = err.backtrace.join("\n").gsub("\r","")
        else
          @backtrace = err.backtrace
        end
        recipients = Ketchup::Exception.recipients  
        mail(:to => recipients,:subject => Ketchup::Exception.subject,
             :template_path => Ketchup::Exception.template_path,
             :template_name => Ketchup::Exception.template_name,
             :from => Ketchup::Exception.sender)
      end
    end

  end

end