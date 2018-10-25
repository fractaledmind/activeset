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

The `ActiveSet` class provides convenience methods for filtering, sorting, paginating, and transforming collections of data-objects, whether `ActiveRecord::Relation`s or Ruby `Array`s or custom classes that extend the `Enumerable` module.

When calling a convenience method on an instance of `ActiveSet`, you pass only 1 argument: a plain-old-Ruby-hash that encodes the instructions for that operation. Each convenience method works with hashes of differing signatures.

## Filtering

`ActiveSet` allows for you to filter your collection by:

- "direct" attributes (i.e. for an `ActiveRecord` model, a database attribute)
- "computed" attributes (i.e. Ruby getter-methods on your data-objects)
- "associated" attributes (i.e. either direct or computed attributes on objects associated with  your data-objects)
- "called" attributes (i.e. Ruby methods with non-zero arity)

The syntax for the instructions hash is relatively simple:

```ruby
{
    attribute: 'value',
    association: {
        field: 'value'
    }
}
```

Every entry in the instructions hash is treated and processed as an independent operation, and all operations are _conjoined_ ("AND"-ed). At the moment, you cannot use disjointed ("OR"-ed) operations.

## Sorting

## Paginating

e.g. `filter(attribute: 'value', association: { field: 'value' })` or `sort(attribute: :asc, association: { field: 'desc' })` or `paginate(page: 1, size: 10)`

## Future Feature Ideas

- allow for filtering thru `to-many` associations (maybe via `associations[any]` or `associations[all]` syntax)
- allow for filtering without typecasting the value (maybe via `key*` syntax)

## Notes

This library does not deal with typecasting string values; the values of your structures must be of the appropriate data-type.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fractaledmind/activeset.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


attribute_types = %i[binary boolean date datetime decimal float integer string text time]
