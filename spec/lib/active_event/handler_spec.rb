require 'spec_helper'
require 'active_event/handler'

describe ActiveEvent::Handler do
  class MyHandler
    include ActiveEvent::Handler

    def my_event; end
    handler :my_event
  end

  describe '.handler' do
    it 'adds handlers' do
      MyHandler.events_handled.should == [:my_event]
    end
  end

  describe '#handlers' do
    it 'has curried handlers' do
      handler = MyHandler.new
      handler.stub(:my_event)

      handler.handlers[:my_event].first.call(4)

      handler.should have_received(:my_event).with(4)
    end
  end

  describe '.handlers' do
    it 'has uncurried handlers' do
      handler = MyHandler.new
      handler.stub(:my_event)

      MyHandler.handlers[:my_event].first.call(handler, 4)

      handler.should have_received(:my_event).with(4)
    end
  end
end
