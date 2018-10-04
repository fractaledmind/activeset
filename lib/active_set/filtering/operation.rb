module Filtering
  class Operation
    def initialize(set, instructions_hash)
      @set = set
      @instructions_hash = instructions_hash
    end

    def execute
      p ['~', Foo.count]
      attribute_instructions = @instructions_hash
                                 .flatten_keys
                                 .map { |k, v| AttributeInstruction.new(k, v) }

      activerecord_filtered_set = attribute_instructions.reduce(@set) do |set, attribute_instruction|
        maybe_set_or_false = ActiveRecordStrategy.new(set, attribute_instruction).execute
        next set unless maybe_set_or_false
        attribute_instructions.delete_at(attribute_instructions.index(attribute_instruction))
        maybe_set_or_false
      end

      attribute_instructions.reduce(activerecord_filtered_set) do |set, attribute_instruction|
        maybe_set_or_false = EnumerableStrategy.new(set, attribute_instruction).execute
        maybe_set_or_false.presence || set
      end
    end
  end

  class EnumerableStrategy
    def initialize(set, attribute_instruction)
      @set = set
      @attribute_instruction = attribute_instruction
    end

    def execute
      return false unless @set.respond_to? :select

      @set.select do |item|
        @attribute_instruction.value_for(item: item)
                              .send(@attribute_instruction.operator,
                                    @attribute_instruction.value)
      end
    end
  end

  class ActiveRecordStrategy
    def initialize(set, attribute_instruction)
      @set = set
      @attribute_instruction = attribute_instruction
    end

    def execute
      return false unless @set.respond_to? :to_sql
      attribute_model = @attribute_instruction.associations_array
                                              .reduce(@set) do |obj, assoc|
                                                obj.reflections[assoc.to_s]&.klass
                                              end
      return false unless attribute_model && attribute_model.respond_to?(:attribute_names)
      return false unless attribute_model.attribute_names.include?(@attribute_instruction.attribute)

      statement = @set.eager_load(@attribute_instruction.associations_hash)
                      .where(
                        Arel::Nodes::InfixOperation.new(
                          @attribute_instruction.operator,
                          Arel::Table.new(attribute_model.table_name)[@attribute_instruction.attribute],
                          Arel.sql(ActiveRecord::Base.connection.quote(@attribute_instruction.value))
                        )
                      )

      return false if throws?(ActiveRecord::StatementInvalid) { statement.load }

      statement
    end
  end
end
