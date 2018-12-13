# ActiveSet

[![Build Status](https://travis-ci.com/fractaledmind/activeset.svg?branch=master)](https://travis-ci.com/fractaledmind/activeset)
[![codecov](https://codecov.io/gh/fractaledmind/activeset/branch/master/graph/badge.svg)](https://codecov.io/gh/fractaledmind/activeset)

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
- "associated" attributes (i.e. either direct or computed attributes on objects associated with your data-objects)
- "called" attributes (i.e. Ruby methods with non-zero arity)

The syntax for the instructions hash is relatively simple:

```ruby
{
    attribute: 'value',
    association: {
        field: 'value'
    },
    'association.field' => 'value',
    'attribute(operator)' => 1.0,
    association: {
        'field(operator)': 'value'
    },
    'association.field(operator)' => 'value',
}
```

Every entry in the instructions hash is treated and processed as an independent operation, and all operations are _conjoined_ ("AND"-ed). At the moment, you cannot use disjointed ("OR"-ed) operations.

The logic of this method is to attempt to process every instruction with the ActiveRecordStrategy, marking all successful attempts. If we successfully processed every instruction, we simply returned the processed result. If there are any instructions that went unprocessed, we take only those instructions and process them against the set processed by the ActiveRecordStrategy.

This filtering operation does not preserve the order of the filters, enforces conjunction, and will discard any unprocessable instruction.

For ActiveRecord sets, the various ARel predicate methods are available as operators:

operator
------------
eq
not_eq
eq_any
not_eq_any
eq_all
not_eq_all
in
not_in
in_any
not_in_any
in_all
not_in_all
lt
lteq
lt_any
lteq_any
lt_all
lteq_all
gt
gteq
gt_any
gteq_any
gt_all
gteq_all
matches
does_not_match
matches_any
does_not_match_any
matches_all
does_not_match_all

## Sorting

`ActiveSet` allows for multi-dimensional, multi-directional sorting across the same kinds of attributes as filtering ("direct", "computed", "associated", and "called").

The syntax for the instructions hash is relatively simple:

```ruby
{
    attribute: :desc,
    association: {
        field: :asc
    }
}
```

The logic for this method is to check whether all of the instructions appear to be processable by the ActiveRecordStrategy, and if they are to attempt to sort using the ActiveRecordStrategy (with all of the instructions, as you can't split sorting instructions). We then double check that all of the instructions were indeed successfully processed by the ActiveRecordStrategy, and if they were, we return that result. Otherwise (if either some instructions don't appear to be processable by ActiveRecord or some instructions weren't processed by ActiveRecord), we sort with the EnumerableStrategy.

## Paginating

`ActiveSet` also allows for paginating both ActiveRecord or plain Ruby enumerable sets.

The syntax for the instructions hash remains relatively simple:

```ruby
{
    size: 25,
    page: 1
}
```

Unlike the filtering or sorting operations, you do not have to pass an instructions hash, as the operation will default to paginating with a `size` of 25 and starting on `page` 1.

Paginating as an operation works with "direct" instructions (that is, the instructions don't represent attribute paths or column structures; the instructions hash is a simple, flat hash), and the operation requires all instruction entries together (as opposed to filtering for example, where we can process each instruction entry separately).

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
