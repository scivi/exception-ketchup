require "rubygems"
require "bundler/setup"

%w(action_controller/railtie
   action_mailer/railtie
   mongoid).each { |library| require library }

require_relative 'util/handler'

# Exception handler for Ovulasens. It consists of a general 
# configuration file, a Controller extension, a Mailer and 
# MongoDB database Model.
#
# @author Daniel Schmidt
module Ketchup

  module Exception

    # Load handler to send mail or create database error entry. 
    autoload :Handler, 'util/handler'

    # Setup ketchup. The config file should be in config/initializers.
    def self.setup(&block)
      yield(self)
    end

    @@sender = ""

    # Enables or disables exception mailing. If mailing is disabled
    # the :notify parameter in #rescue_errors will be ignored.
    # Defaults to true (mailing is enabled.)
    mattr_accessor :deliver_mail
    @@deliver_mail = true

    # Enables or disables persisting of errors. If persisting is disabled
    # the :remember parameter in #rescue_errors will be ignored.
    # Defaults to true (persisting is enabled.)
    mattr_accessor :persist
    @@persist = true

    # The Rails env to use. Optional for configuration. Have to be symbols.
    mattr_writer :environment
    @@environment = [:production]

    def self.environment
      if @@environment.is_a?(Symbol) or @@environment.is_a?(String)
        return [@@environment]
      else
        return @@environment
      end
    end

    # A comma seperated list or an array of email
    # addresses to which the exception notification 
    # should be mailed. 
    mattr_writer :recipients
    @@recipients = []

    # A comma seperated list or an array of email
    # addresses to which the exception notification 
    # should be mailed. 
    def self.recipients
      if @@deliver_mail
        raise "[Ketchup] You have to provide at least one recipient!" if @@recipients.empty?
      end
      return @@recipients.join(",") if @@recipients.respond_to?(:join)
      return @@recipients
    end

    # The senders address. Required for configuration
    def self.sender=(sender)
      @@sender = sender
    end

    def self.sender
      if @@deliver_mail
        STDOUT.write "[Ketchup] You have to provide a sender email." if @@sender.empty?
      end
      #return "hulla@hui.com"
      return @@sender
    end

    # Define a log error proc. This method should take one argument which is 
    # the error that was raised.
    mattr_accessor :log_error
    @@log_error = lambda do |error|
      Rails::logger.info("!!! CATCH ERROR: #{error.message}")   
      Rails::logger.info(error.backtrace.join("\n")) 
    end

    # Subject to use for email. 
    mattr_accessor :subject
    @@subject = ""

    # The path to the mail template
    mattr_accessor :template_path
    @@template_path = ""

    # The template name for OvuException::Ketchup::Mailer.
    # Optional for configuration.
    mattr_accessor :template_name
    @@template_name = "exception"

    # The collection the execption informations should be saved in
    mattr_accessor :exception_collection
    @@exception_collection = :errors

  end
end

# require extensions.
require_relative "rails/error"
require_relative "rails/controller"
require_relative "rails/mailer.rb"

ActionController::Base.class_eval do
  include Ketchup::Exception::Controller
end