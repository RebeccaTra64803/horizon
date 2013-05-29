require 'active_support/concern'

module ActiveEvent
  module Handler
    extend ActiveSupport::Concern

    module ClassMethods
      def handlers
        @handlers ||= Hash.new { |h, k| h[k] = [] }
      end

      def events_handled
        handlers.keys
      end

      def handler(event)
        handlers[event] << lambda { |handler, *args| handler.send event, *args }
      end
    end

    def handlers
      @handlers ||= curry_handlers
    end

    def curry_handlers
      Hash[
        self.class.handlers.map { |event, lambdas|
          [event, lambdas.map { |l| lambda { |*args| l.call self, *args } }]
        }
      ]
    end
  end
end
