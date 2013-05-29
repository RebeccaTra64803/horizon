module ActiveEvent
  class SubscriptionContext
    def self.current
      @current ||= SubscriptionContext.new
    end
  end
end
