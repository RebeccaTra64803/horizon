module ActiveEvent
  class Railtie < Rails::Railtie
    # initializer "active_event.set_up_subscriber" do
    #   suffix = /\.active_event\Z/
    #   ActiveSupport::Notifications.subscribe suffix do |event, *args|
    #     event_name = event.gsub(suffix, '').to_sym
    #     SubscriptionContext.current.publish event_name, *args
    #   end
    # end
  end
end
