# frozen_string_literal: true

module Paginating
  class Operation
    def initialize(set, instructions_hash)
      @set = set
      @instructions_hash = instructions_hash
    end

    def execute
      [ActiveRecordStrategy, EnumerableStrategy].each do |strategy|
        maybe_set_or_false = strategy.new(@set, operation_instructions).execute
        break(maybe_set_or_false) if maybe_set_or_false
      end
    end

    def operation_instructions
      @instructions_hash.symbolize_keys.tap do |h|
        h[:page] = page_operation_instruction(h[:page])
        h[:size] = size_operation_instruction(h[:size])
        h[:count] = count_operation_instruction(@set)
      end
    end

    private

    def page_operation_instruction(initial)
      return 1 unless initial
      return 1 if initial.to_i <= 0

      initial.to_i
    end

    def size_operation_instruction(initial)
      return 25 unless initial
      return 25 if initial.to_i <= 0

      initial.to_i
    end

    def count_operation_instruction(set)
      if set.is_a?(ActiveRecord::Relation)
        maybe_count_or_hash = set.count(:all)
        count = if maybe_count_or_hash.is_a?(Hash)
                  maybe_count_or_hash.count
                else
                  maybe_count_or_hash
                end
        return count
      end

      set.count
    end
  end

  class EnumerableStrategy
    def initialize(set, operation_instructions)
      @set = set
      @operation_instructions = operation_instructions
    end

    def execute
      return [] if @set.count <= @operation_instructions[:size] &&
                   @operation_instructions[:page] > 1

      @set[page_start..page_end] || []
    end

    private

    def page_start
      return 0 if @operation_instructions[:page] == 1

      @operation_instructions[:size] * (@operation_instructions[:page] - 1)
    end

    def page_end
      return page_start if @operation_instructions[:size] == 1

      page_start + @operation_instructions[:size] - 1
    end
  end

  class ActiveRecordStrategy
    def initialize(set, operation_instructions)
      @set = set
      @operation_instructions = operation_instructions
    end

    def execute
      return false unless @set.respond_to? :to_sql
      return @set.none if @set.length <= @operation_instructions[:size] &&
                          @operation_instructions[:page] > 1

      @set.limit(@operation_instructions[:size]).offset(page_offset)
    end

    private

    def page_offset
      return 0 if @operation_instructions[:page] == 1

      @operation_instructions[:size] * (@operation_instructions[:page] - 1)
    end
  end
end
