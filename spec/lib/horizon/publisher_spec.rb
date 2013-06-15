require 'spec_helper'
require 'horizon/publisher'

describe Horizon::Publisher do
  class MyPublisher
    include Horizon::Publisher
  end

  it 'can publish events' do
    publisher = MyPublisher.new
    context = double(:context).as_null_object
    Horizon::Context.current = context

    publisher.publish(:my_event, 4)
    context.should have_received(:publish).with(:my_event, 4)
  end
end
