# frozen_string_literal: true

require 'active_support/core_ext/array/wrap'
require 'active_support/core_ext/object/try'

module Structure
  class Path
    attr_reader :path

    def initialize(path)
      # `path` can be an Array (e.g. [:parent, :child, :grandchild])
      # or a String (e.g. 'parent.child.grandchild')
      @path = path.is_a?(String) ? path.split('.') : Array.wrap(path).map(&:to_s)
    end

    def attribute
      attribute = @path.last
      return attribute.sub(operator_regex, '') if attribute.match operator_regex
      attribute
    end

    def operator
      attribute = @path.last
      return attribute[operator_regex, 1] if attribute.match operator_regex
      '=='
    end

    def to_a
      @path.slice(0, @path.length - 1)
    end

    def to_h
      to_a.reverse.reduce({}) { |a, e| { e => a } }
    end

    def value_for(item:)
      resource_for(item: item).send(attribute)
    rescue
      nil
    end

    def resource_for(item:)
      to_a.reduce(item, :try)
    rescue
      nil
    end

    private

    def operator_regex
      /\((.*?)\)/
    end
  end
end
