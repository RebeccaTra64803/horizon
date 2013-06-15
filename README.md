# Activeevent

Add domain events to your models.

## Installation

Add this line to your application's Gemfile:

    gem 'horizon'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install horizon

## Usage

First, publish some domain events:

```ruby
class Dog < ActiveRecord::Base
  include Horizon::Publisher

  def feed
    self.hungry = false
    publish :dog_fed, self
  end
end
```

Then, handle them:

```ruby
class DogOwnerNotifier
  include Horizon::Handler

  def dog_fed(dog)
    mail_owner(dog)
  end
  handler :dog_fed

  # or

  handler :dog_fed do |dog|
    mail_owner(dog)
  end

  # or

  handler dog_fed: :mail_owner

  # ...
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
