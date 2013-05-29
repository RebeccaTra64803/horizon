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

  class DogOwnerNotifier
    include ActiveEvent::Handler

    def dog_fed(dog)
      mail_owner(dog)
    end
    handler :dog_fed

    def mail_owner
    end
  end

  it "lets you publish and handle domain events" do
    context = ActiveEvent::Context.current
    handler = DogOwnerNotifier.new
    context.add_handler handler

    handler.stub(:mail_owner)

    dog = Dog.new
    dog.feed

    handler.should have_received(:mail_owner).with(dog)
  end
end
