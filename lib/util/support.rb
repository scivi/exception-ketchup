module Ketchup
  module Exception
    module SupportedMongos
      extend ActiveSupport::Concern

      # Checks which Mongoid is used and adjusts the store in a collection
      # method.
      included do
        major,minor,path = Mongoid::VERSION.split(".")
        if major.match(/3/)
          store_in collection: Ketchup::Exception.exception_collection
        elsif major.match(/2/)
          store_in Ketchup::Exception.exception_collection
        end

      end

    end
  end
end