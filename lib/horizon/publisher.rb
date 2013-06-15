require 'active_support/concern'
require 'horizon/context'

module Horizon
  module Publisher
    extend ActiveSupport::Concern

    def publish(event, *args)
      Horizon::Context.current.publish event, *args
    end
  end
end
