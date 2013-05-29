require 'active_support/concern'

module ActiveEvent
  module Publisher
    extend ActiveSupport::Concern

    def publish(event, *args)

    end
  end
end
