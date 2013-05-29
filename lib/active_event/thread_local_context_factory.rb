module ActiveEvent
  class ThreadLocalContextFactory
    def current_context
      Thread.current[:active_event_context] ||= ActiveEvent::Context.new
    end
  end
end
