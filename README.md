# JSON Deep Parse

Deeply parse heavily escaped and nested JSON

Sometimes you have a big blob of JSON and you parse it using `JSON.parse(blob)` and everything is great.

Other times, you receive a big blob of JSON that was other blobs of JSON within other blobs of JSON and you have no control over the fact that the JSON was deeply escaped but you want it deeply parsed. This lib is a non performant way to do that.

## Installation

### Copy Paste

You probably don't need the dependency honestly, but this is available as a gem if you want it that way, scoot down to the next section.

Make a file in your app or lib and call it something cool like JSONDeepParse and then copy and paste the file from this lib.

### Gem

Add this line to your application's Gemfile:

```ruby
gem 'json_deep_parse'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install json_deep_parse

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/json_deep_parse. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the JsonDeepParse project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/json_deep_parse/blob/master/CODE_OF_CONDUCT.md).
