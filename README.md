# Rails::AddOns
Short description and motivation.

## Usage
How to use my plugin.

### with bootstrap-sass

You have to add

    //= require bootstrap-sprockets

to your applications javascript include file to use bootstrap-sass.

### Update path to 1.0.0

You may want to add

    //= require tether

to your applications javascript include file, as it was removed.

### Update path to 2.0.0

ServiceController::Base now uses the verbs new and create instead of invoke and call. Furthermore @resource is dropped in favor of @service. Please modify your controllers and views and routing accordingly.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'rails-add_ons'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install rails-add_ons
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
