module Ketchup

  module Exception

    class Error
      include Mongoid::Document

      store_in :errors

      field :kind,        :type => String
      field :message,     :type => String
      field :backtrace,   :type => String
      field :happend_at,  :type => Time

      before_save :join_backtrace

      # Internal - Joins the backtrace array of an Exception into a String. 
      def join_backtrace
        self.backtrace = self.backtrace.join("\n") if self.backtrace.respond_to?(:join)
      end

    end

  end

end