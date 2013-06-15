require 'spec_helper'
require 'horizon/context'

describe Horizon::Context do
  let(:context) { Horizon::Context.new }
  let(:handler) { double(:handler, events_handled: [:my_event]).as_null_object }

  it 'maps published events to handlers' do
    context.add_handler(handler)

    context.publish(:my_event, 4)

    handler.should have_received(:handle).with(:my_event, 4)
  end

  it 'does not send events to handlers that they do not handle' do
    context.add_handler(handler)

    context.publish(:my_other_event, 4)

    handler.should_not have_received(:handle)
  end

  describe '.current' do
    it 'defaults to dispatching thread local contexts' do
      context = Horizon::Context.current

      Horizon::Context.current.should == context
      thread = Thread.new { Horizon::Context.current.should_not == context }
      thread.join
    end

    it 'can be reset' do
      context = Horizon::Context.current

      Horizon::Context.reset!

      Horizon::Context.current.should be
      Horizon::Context.current.should_not == context
    end

    it 'can be overridden' do
      context = double :context
      Horizon::Context.current = context

      Horizon::Context.current == context
    end
  end
end
