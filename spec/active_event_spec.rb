require 'spec_helper'
require 'active_event'

describe "active_event" do
  class Dog
    include ActiveEvent::Publisher
    attr_accessor :hungry
    alias_method :hungry?, :hungry

    def initialize
      self.hungry = true
    end

    def feed
      return unless hungry?

      self.hungry = false
      publish :dog_fed, self
    end
  end

  it "helps you publish domain events" do
    dog = Dog.new

    dog.feed
  end
end
