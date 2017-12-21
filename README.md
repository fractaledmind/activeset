# ActiveSet

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'activeset'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install activeset

## Usage

The `ActiveSet` class is an extension of `Enumerable` that adds methods for filtering, sorting, paginating, and transforming (right now; other methods are sure to follow).

Every convenience method added to the `ActiveSet` class is handled via a `Processor` class, and that `Processor` class will then use 1 or more `Adapter` classes to actually fulfill the functional contract.

an `Adapter` for a particular `Processor` simply handles doing the job of the processor for a particular kind of Set.

So, for example, the `Filter::Processor` will have an `EnumerableAdapter` (to work with generic enumerable sets) and an `ActiveRecordAdapter` (to work with active record relations).

When calling a convenience method on an instance of `ActiveSet`, you pass only 1 argument: what I am currently calling a `structure`, which is a plain-old-Ruby-hash. Each convenience method works with hashes of differing signatures.

e.g. `filter(attribute: 'value', association: { field: 'value' })` or `sort(attribute: :asc, association: { field: 'desc' })` or `paginate(page: 1, size: 10)`

## Future Feature Ideas

- allow for filtering thru `to-many` associations (maybe via `associations[any]` or `associations[all]` syntax)
- allow for filtering without typecasting the value (maybe via `key*` syntax)

## Notes

This library does not deal with typecasting string values; the values of your structures must be of the appropriate data-type.

This library does not work with `:time` fields in ActiveRecord relations.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fractaledmind/activeset.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
