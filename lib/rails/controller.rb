# Controller extension to provide exception handling.
#
# @author Daniel Schmidt
module Ketchup

  module Exception

    module Controller
      extend ActiveSupport::Concern

      module ClassMethods

        # Private class methods and class variables. 

        # All errors to be rescued in a special way.
        mattr_reader :rescue_errors

        # INTERNAL - A setter to define errors which are treated in a special way.
        #
        # error_conf - An Array consisting of Hashes with :error,:with keys.
        #      error - The Expection to be rescued.
        #      with  - A Symbol of method name which handles the rescue. 
        # Example:
        #
        # {:error => NoMethodError, :with => :catch_no_methods}
        # 
        def rescue_errors=(error_conf)
          @@rescue_errors = [] if @@rescue_errors.nil? 
          error_conf.each do |conf|
            @@rescue_errors << conf
          end
        end

        # PUBLIC - class method to provide exception handling support. 
        #
        # It takes an optional configuration block:
        # 
        # Example:
        # 
        # class MainController < ApplicationController
        # 
        #   ketchup_exceptions do
        #       c.resuce_errors = [
        #         {:error => RestClient::ServerBrokeConnection, :with => :server_not_responding}
        #       ]
        #       c.before_respond  = :log_error
        #       c.after_rescue    = :respond_with_error
        #   end
        #
        # It assigns all rescue_errors configurations to rescue_from and a 
        # controller extension method to #around_filter.
        def ketchup_exceptions(*args)
          yield(self) if block_given?
          around_action :ketchup
        end
      end

      # INTERNAL - The method which is called by #around_filter
      # 
      # Finds the error configuration:
      #   :error    - Class of the Error
      #   :with     - Proc or method name to call. If this is ommited be sure to 
      #               implement an respond_with_error(err) method.
      #   :remember - Boolean. If true error will be saved in database
      #               Default true
      #   :notify   - Boolean.
      #               Default true
      #               It sends an email to any reciepient which is defined during
      #               Ketchup configuration. If deliver_mail in Ketchup configuration is
      #               set to false, sending mail is ignored
      #   :log      - Boolean.
      #               Default true
      #               Call the proc that is defined in log_error
      #
      def ketchup(&block)
        yield
      rescue => err
        if Ketchup::Exception.environment.include?(Rails.env.to_sym)
          # Default error configuration
          default_conf = { :with => :respond_with_error, :remember => true, :notify => true, :log => true }
          # Find specific error configuration
          conf = self.class.rescue_errors.find { |error_conf| error_conf[:error] == err.class }
          conf = default_conf.merge(conf || {})
          # save to database
          handle_persistence(conf[:remember], err)
          # send an email
          handle_mail(conf[:notify], err)
          # log error
          handle_logging(conf[:log], err)
          # Run error handler
          if conf[:with].is_a? Proc
            conf[:with].call(err)
          else
            self.send(conf[:with], err)
          end
        else
          raise err
        end
      end

      private 

      def handle_mail(mail_flag, err)
        if Ketchup::Exception.deliver_mail
          Ketchup::Handler.action(:mail, {:exception => err, :host => request.host_with_port}) if mail_flag
        end
      end

      def handle_persistence(persist_flag, err)
        if Ketchup::Exception.persist
          Ketchup::Handler.action(:database, :exception => err) if persist_flag
        end
      end

      def handle_logging(log_flag, err)
        Ketchup::Exception.log_error.call(err) if log_flag 
      end

    end

  end

end
