module ActiveEvent
  class ThreadLocalContextStore
    def current_context=(context)
      Thread.current[:active_event_context] = context
    end

    def current_context
      Thread.current[:active_event_context] ||= ActiveEvent::Context.new
    end
  end
end
