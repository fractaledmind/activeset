# frozen_string_literal: true

class ActiveSet
  class Instructions
    class Entry
      class Value
        attr_reader :raw

        def initialize(value)
          @raw = value
        end
      end
    end
  end
end
