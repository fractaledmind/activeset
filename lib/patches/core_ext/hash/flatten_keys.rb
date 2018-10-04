# frozen_string_literal: true

require 'active_support/core_ext/array/wrap'

class Hash
  # Returns a flat hash where all nested keys are collapsed into a an array of keys.
  #
  #   hash = { person: { name: { first: 'Rob' }, age: '28' } }
  #   hash.flatten_keys   # => {[:person, :name, :first]=>"Rob", [:person, :age]=>"28"}
  #   hash                # => { person: { name: { first: 'Rob' }, age: '28' } }
  def flatten_keys
    _flatten_keys(self)
  end

  # Replaces current hash with a flat hash where all nested keys are collapsed into a an array of keys.
  # Returns +nil+ if no changes were made, otherwise returns the hash.
  #
  #   hash = { person: { name: { first: 'Rob' }, age: '28' } }
  #   hash.flatten_keys!   # => {[:person, :name, :first]=>"Rob", [:person, :age]=>"28"}
  #   hash                 # => {[:person, :name, :first]=>"Rob", [:person, :age]=>"28"}
  # :nocov:
  def flatten_keys!
    replace(_flatten_keys(self))
  end
  # :nocov:

  private

  def _flatten_keys(h, keys = [], res = {})
    return res.merge!(keys => h) unless h.is_a? Hash
    h.each { |k, r| _flatten_keys(r, keys + Array.wrap(k), res) }
    res
  end
end
