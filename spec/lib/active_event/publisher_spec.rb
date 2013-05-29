require 'spec_helper'
require 'active_event/publisher'

describe ActiveEvent::Publisher do
  class MyPublisher
    include ActiveEvent::Publisher
  end

  it 'can publish events' do
    publisher = MyPublisher.new
    context = double(:context).as_null_object
    ActiveEvent::Context.current = context

    publisher.publish(:my_event, 4)
    context.should have_received(:publish).with(:my_event, 4)
  end
end
