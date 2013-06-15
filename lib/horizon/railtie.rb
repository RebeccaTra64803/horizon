module Horizon
  class Railtie < Rails::Railtie
    # initializer "horizon.set_up_subscriber" do
    #   suffix = /\.horizon\Z/
    #   ActiveSupport::Notifications.subscribe suffix do |event, *args|
    #     event_name = event.gsub(suffix, '').to_sym
    #     SubscriptionContext.current.publish event_name, *args
    #   end
    # end
  end
end
