class FilterTransformerToAST < Parslet::Transform
  rule(signal: simple(:signal)) do
    AST::Operand::Signal.new(signal)
  end
  rule(accessor: simple(:accessor)) do
    AST::Operation::Access.new(
      AST::Operand::Object.new(object),
      accessor)
  end
  rule(comparison: simple(:comparison)) do
    AST::Operation::Comparison.new(
      comparison,
      AST::Operand::Signal.new('=='),
      AST::Operand::Object.new(value)
    )
  end
end

module AST
  module Visitable
    def accept(visitor)
      visitor.visit(self)
    end
  end

  class Operand
    include Visitable

    def initialize(operand)
      @operand = operand
    end

    class Object < Operand
    end

    class Signal < Operand
    end

    class Enumerable < Operand
    end

    class Executable
      include Visitable
      attr_accessor :args

      def initialize(operand, *args)
        @operand = operand
        @args = args
      end
    end
  end

  module Operation
    class Access
      include Visitable

      def initialize(object_operand, signal_operand)
        @object_operand = object_operand
        @signal_operand = signal_operand
      end
    end

    class Comparison
      include Visitable

      def initialize(left_object_operand, operator_signal_operand, right_object_operand)
        @left_object_operand = left_object_operand
        @operator_signal_operand = operator_signal_operand
        @right_object_operand = right_object_operand
      end
    end

    class Enumeration
      include Visitable

      def initialize(enumerable_object_operand, signal_operand, executable_operand)
        @enumerable_object_operand = enumerable_object_operand
        @signal_operand = signal_operand
        @executable_operand = executable_operand
      end
    end

    class Negation
      include Visitable

      def initialize(object_operand)
        @object_operand = object_operand
      end
    end
  end
end
