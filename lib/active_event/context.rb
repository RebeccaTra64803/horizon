require 'active_event/thread_local_context_store'

module ActiveEvent
  class Context
    attr_reader :store
    def self.store
      @store ||= ThreadLocalContextStore.new
    end

    def self.current
      store.current_context
    end

    def self.current=(context)
      store.current_context = context
    end

    def self.reset!
      store.current_context = nil
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
