require 'active_support/concern'

module Horizon
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

    def events_handled
      self.class.events_handled
    end

    def handlers
      @handlers ||= curry_handlers
    end

    def handle(event, *args)
      self.class.handlers[event].each do |handler|
        handler.call self, *args
      end
    end
  end
end
