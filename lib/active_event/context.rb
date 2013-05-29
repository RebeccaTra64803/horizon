require 'active_event/thread_local_context_factory'

module ActiveEvent
  class Context
    attr_reader :factory
    def self.factory
      @factory ||= ThreadLocalContextFactory.new
    end

    def self.current
      factory.current_context
    end

    def event_map
      @event_map ||= Hash.new { |h, k| h[k] = Set.new }
    end

    def add_handler(handler)
      handler.events_handled.each do |event|
        event_map[event] << handler
      end
    end

    def publish(event, *args)
      event_map[event].each do |handler|
        handler.handle event, *args
      end
    end
  end
end
