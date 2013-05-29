require 'active_support/concern'
require 'active_event/context'

module ActiveEvent
  module Publisher
    extend ActiveSupport::Concern

    def publish(event, *args)
      ActiveEvent::Context.current.publish event, *args
    end
  end
end
