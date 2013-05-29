require 'spec_helper'
require 'active_event/handler_context'

describe ActiveEvent::Context do
  let(:context) { ActiveEvent::Context.new }
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
end