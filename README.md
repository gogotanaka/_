# Kasen

![kasen.png](https://qiita-image-store.s3.amazonaws.com/0/30440/7ac5c816-ad6d-dd62-1783-a2c435455fde.png)

下線(Kasen) ... Underscore.

```ruby
require 'kasen'
[[1, 2], [3, 4]].map &_[1]
# is equivalent for
[[1, 2], [3, 4]].map { |ary| ary[1] }

['0', '1', '2'].select &_.to_i.zero?
# is equivalent for
['0', '1', '2'].select { |s| s.to_i.zero? },

[['1', '2'], ['3', '4']].map { |ary| ary.select { |n| n.to_i.eql?(1) } },
# is equivalent for
[['1', '2'], ['3', '4']].map(&_.select(&_.to_i.eql?(1)))
```

note: you can use `k` instead of `_` in IRB.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kasen'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kasen

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## License

MIT license (© 2015 Kazuki Tanaka)
