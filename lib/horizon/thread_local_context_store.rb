module Horizon
  class ThreadLocalContextStore
    def current_context=(context)
      Thread.current[:horizon_context] = context
    end

    def current_context
      Thread.current[:horizon_context] ||= Horizon::Context.new
    end
  end
end
