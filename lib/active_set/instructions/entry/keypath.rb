# frozen_string_literal: true

require 'active_support/core_ext/array/wrap'
require 'active_support/core_ext/object/try'

class ActiveSet
  class Instructions
    class Entry
      class KeyPath
        attr_reader :path

        def initialize(path)
          # `path` can be an Array (e.g. [:parent, :child, :grandchild])
          # or a String (e.g. 'parent.child.grandchild')
          @path = Array.wrap(path).map(&:to_s).flat_map { |x| x.split('.') }
        end

        def attribute
          attribute = @path.last
          return attribute.sub(operator_regex, '') if attribute&.match operator_regex
          attribute
        end

        def operator
          attribute = @path.last
          return attribute[operator_regex, 1] if attribute&.match operator_regex
          '=='
        end

        def associations_array
          return [] unless @path.any?
          @path.slice(0, @path.length - 1)
        end

        def associations_hash
          return {} unless @path.any?
          associations_array.reverse.reduce({}) { |a, e| { e => a } }
        end

        def value_for(item:)
          resource_for(item: item).send(attribute)
        rescue
          nil
        end

        def resource_for(item:)
          associations_array.reduce(item, :try)
        rescue
          nil
        end

        def titleized
          @path.map(&:titleize).join(' ')
        end

        private

        def operator_regex
          /\((.*?)\)/
        end
      end
    end
  end
end
