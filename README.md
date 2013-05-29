# Activeevent

Add domain events to your models.

## Installation

Add this line to your application's Gemfile:

    gem 'activeevent'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install activeevent

## Usage

First, publish some domain events:

```ruby
class Dog < ActiveRecord::Base
  include ActiveEvent::Publisher

  def feed
    self.hungry = false
    publish :dog_fed, self
  end
end
```

Then, handle them:

```ruby
class DogOwnerNotifier
  include ActiveEvent::Handler

  def dog_fed(dog)
    mail_owner(dog)
  end
  handle :dog_fed

  # or

  handle :dog_fed do |dog|
    mail_owner(dog)
  end

  # or

  handle dog_fed: :mail_owner

  # ...
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
