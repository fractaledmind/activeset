# frozen_string_literal: true

require 'active_support/core_ext/array/wrap'

class Hash
  # Returns a flat hash where all nested keys are collapsed into an array of keys.
  #
  #   hash = { person: { name: { first: 'Rob' }, age: '28' } }
  #   hash.flatten_keys_to_array
  #   => {[:person, :name, :first] => "Rob", [:person, :age]=>"28" }
  #   hash
  #   => { person: { name: { first: 'Rob' }, age: '28' } }
  def flatten_keys_to_array
    _flatten_keys(self)
  end
  alias flatten_keys flatten_keys_to_array

  # Returns a flat hash where all nested keys are collapsed into a dot-separated string of keys.
  #
  #   hash = { person: { name: { first: 'Rob' }, age: '28' } }
  #   hash.flatten_keys_to_dotpath
  #   => { 'person.name.first' => "Rob", [:person, :age]=>"28" }
  #   hash
  #   => { person: { name: { first: 'Rob' }, age: '28' } }
  def flatten_keys_to_dotpath
    _flatten_keys(self, ->(*keys) { keys.join('.') })
  end

  # Returns a flat hash where all nested keys are collapsed into a dast-separated string of keys.
  #
  #   hash = { person: { name: { first: 'Rob' }, age: '28' } }
  #   hash.flatten_keys_to_html_attribute
  #   => { 'person-name-first' => "Rob", [:person, :age]=>"28" }
  #   hash
  #   => { person: { name: { first: 'Rob' }, age: '28' } }
  def flatten_keys_to_html_attribute
    _flatten_keys(self, ->(*keys) { keys.join('-') })
  end

  # Returns a flat hash where all nested keys are collapsed into a string of keys fitting the Rails request param pattern.
  #
  #   hash = { person: { name: { first: 'Rob' }, age: '28' } }
  #   hash.flatten_keys_to_rails_param
  #   => { 'person[name][first]' => "Rob", [:person, :age]=>"28" }
  #   hash
  #   => { person: { name: { first: 'Rob' }, age: '28' } }
  def flatten_keys_to_rails_param
    _flatten_keys(self, ->(*keys) { keys.map(&:to_s).reduce { |memo, key| memo + "[#{key}]" } })
  end

  private

  # refactored little from https://stackoverflow.com/a/23861946/2884386
  def _flatten_keys(input, keypath_gen = ->(*keys) { keys }, keys = [], output = {})
    return output.merge!(keypath_gen.call(*keys) => input) unless input.is_a? Hash

    input.each { |k, v| _flatten_keys(v, keypath_gen, keys + Array(k), output) }

    output
  end
end
