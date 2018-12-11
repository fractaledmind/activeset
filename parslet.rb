class FilterParser < Parslet::Parser
  # Single character rules
  rule(:lparen)      { str('(') }
  rule(:rparen)      { str(')') }
  rule(:lbracket)    { str('[') }
  rule(:rbracket)    { str(']') }
  rule(:dot)         { str('.') }
  rule(:star)        { str('*') }

  # Grammar parts
  rule(:signal)      { match('\w').repeat(1).as(:signal) }
  rule(:predicator)  { star.as(:predicator) }
  rule(:accessor)    { (signal >> (dot >> signal).repeat).as(:accessor) }
  rule(:enumerator)  { lbracket >> signal.as(:enumerator) >> rbracket }
  rule(:operator)    { lparen >> signal.as(:operator) >> rparen }
  rule(:comparison)  { (accessor >> (operator | predicator).maybe).as(:comparison) }
  rule(:enumeration) { (enumerator >> (operator | predicator | (dot >> comparison))).as(:enumeration) }
  rule(:expression) do
    comparison | enumeration | (accessor >> enumeration)
  end

  root :expression
end

module AST
  module Visitable
    def accept(visitor)
      visitor.visit(self)
    end
  end

  class Visitor
    def visit(_subject)
      fail NotImpelementedError.new
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

      def accept(visitor)
        @operand.call(*@args)
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

      def accept(visitor)
        object.public_send(signal)
      end

      private

      def object
        @object_operand.visit
      end

      def signal
        @signal_operand.visit
      end
    end

    class Comparison
      include Visitable

      def initialize(left_object_operand, operator_signal_operand, right_object_operand)
        @left_object_operand = left_object_operand
        @operator_signal_operand = operator_signal_operand
        @right_object_operand = right_object_operand
      end

      def accept(visitor)
        left.public_send(operator, right)
      end

      private

      def left
        @left_object_operand.visit
      end

      def right
        @right_object_operand.visit
      end

      def operator
        @operator_signal_operand.visit
      end
    end

    class Enumeration
      include Visitable

      def initialize(enumerable_object_operand, signal_operand, executable_operand)
        @enumerable_object_operand = enumerable_object_operand
        @signal_operand = signal_operand
        @executable_operand = executable_operand
      end

      def accept(visitor)
        enumerable.public_send(signal) { |i| executable(i) }
      end

      private

      def enumerable
        @enumerable_object_operand.visit
      end

      def signal
        @signal_operand.visit
      end

      def executable(item)
        @executable_operand.args = item
        @executable_operand.visit
      end
    end

    class Negation
      include Visitable

      def initialize(object_operand)
        @object_operand = object_operand
      end

      def accept(visitor)
        !object
      end

      private

      def object
        @object_operand.visit
      end
    end
  end

  class Visitor < ::Visitor
    def visit(subject)
      method_name = "visit_#{subject.class}"
      public_send(method_name, subject)
    end
  end
end

parser = FilterParser.new
parser.parse('attribute')
# => {comparison: {accessor: {signal: "attribute"}}}
parser.parse('attribute(operator)')
# => {comparison: {accessor: {signal: "attribute"}, operator: {signal: "operator"}}}
parser.parse('attribute*')
# => {comparison: {accessor: {signal: "attribute"}, predicator: "*"}}
parser.parse('association.attribute')
# => {comparison: {accessor: [{signal: "association"}, {signal: "attribute"}]}}
parser.parse('association.attribute(operator)')
#:  {comparison: {accessor: [{signal: "association"}, {signal: "attribute"}], operator: {signal: "operator"}}}
parser.parse('association.attribute*')
#:  {comparison: {accessor: [{signal: "association"}, {signal: "attribute"}], predicator: "*"}}
parser.parse('associations[enumerator]')
#:  {accessor: {signal: "associations"}, enumeration: {enumerator: {signal: "enumerator"}}}
parser.parse('associations[enumerator](operator)')
#:  {accessor: {signal: "associations"}, enumeration: {enumerator: {signal: "enumerator"}, operator: {signal: "operator"}}}
parser.parse('associations[enumerator]*')
#:  {accessor: {signal: "associations"}, enumeration: {enumerator: {signal: "enumerator"}, predicator: "*"}}
parser.parse('associations[enumerator].attribute')
#:  {accessor: {signal: "associations"}, enumeration: {enumerator: {signal: "enumerator"}, comparison: {accessor: {signal: "attribute"}}}}
parser.parse('associations[enumerator].attribute(operator)')
#:  {accessor: {signal: "associations"}, enumeration: {enumerator: {signal: "enumerator"}, comparison: {accessor: {signal: "attribute"}, operator: {signal: "operator"}}}}
parser.parse('associations[enumerator].attribute*')
#:  {accessor: {signal: "associations"}, enumeration: {enumerator: {signal: "enumerator"}, comparison: {accessor: {signal: "attribute"}, predicator: "*"}}}
parser.parse('[enumerator]')
#:  {enumeration: {enumerator: {signal: "enumerator"}}}
parser.parse('[enumerator](operator)')
#:  {enumeration: {enumerator: {signal: "enumerator"}, operator: {signal: "operator"}}}
parser.parse('[enumerator]*')
#:  {enumeration: {enumerator: {signal: "enumerator"}, predicator: "*"}}
parser.parse('[enumerator].attribute')
#:  {enumeration: {enumerator: {signal: "enumerator"}, comparison: {accessor: {signal: "attribute"}}}}
parser.parse('[enumerator].attribute(operator)')
#:  {enumeration: {enumerator: {signal: "enumerator"}, comparison: {accessor: {signal: "attribute"}, operator: {signal: "operator"}}}}
parser.parse('[enumerator].attribute*')
#:  {enumeration: {enumerator: {signal: "enumerator"}, comparison: {accessor: {signal: "attribute"}, predicator: "*"}}}

# edgecases
# - what if db field but rb operator?
# - what if value is `nil`?


# { attribute(operator): value }
  # Operation::Compare.new(
  #   Operation::Access.new(
  #     Operand::Object.new(obj),
  #     Operand::Signal.new(attribute)
  #   ),
  #   Operand::Signal.new(operator),
  #   Operand::Object.new(value)
  # )

# { attribute*: predicate }
  # Operation::Compare.new(
  #   Operation::Access.new(
  #     Operation::Access.new(
  #       Operand::Object.new(obj),
  #       Operand::Signal.new(attribute)
  #     ),
  #     Operand::Signal.new(predicate)
  #   ),
  #   Operand::Signal.new('=='),
  #   Operand::Object.new(true)
  # )

# { association.attribute: value }
  # Operation::Compare.new(
  #   Operation::Access.new(
  #     Operation::Access.new(
  #       Operand::Object.new(obj),
  #       Operand::Signal.new(association)
  #     ),
  #     Operand::Signal.new(attribute)
  #   ),
  #   Operand::Signal.new('=='),
  #   Operand::Object.new(value)
  # )

# { association.attribute(operator): value }
  # Operation::Compare.new(
  #   Operation::Access.new(
  #     Operation::Access.new(
  #       Operand::Object.new(obj),
  #       Operand::Signal.new(association)
  #     ),
  #     Operand::Signal.new(attribute)
  #   ),
  #   Operand::Signal.new(operator),
  #   Operand::Object.new(value)
  # )

# { association.attribute*: predicate }
  # Operation::Compare.new(
  #   Operation::Access.new(
  #     Operation::Access.new(
  #       Operation::Access.new(
  #         Operand::Object.new(obj),
  #         Operand::Signal.new(association)
  #       ),
  #       Operand::Signal.new(attribute)
  #     ),
  #     Operand::Signal.new(predicate)
  #   ),
  #   Operand::Signal.new('=='),
  #   Operand::Object.new(true)
  # )

# { associations[enumerator]: value }
  # Operation::Enumerate.new(
  #   Operation::Access.new(
  #     Operand::Object.new(obj),
  #     Operand::Signal.new(associations)
  #   ),
  #   Operand::Signal.new(enumerator),
  #   Operand::Executable.new(lambda do |item|
  #     Operation::Compare.new(
  #       Operand::Object.new(item),
  #       Operand::Signal.new('=='),
  #       Operand::Object.new(value)
  #     )
  #   end)
  # )

# { associations[enumerator](operator): value }
  # Operation::Enumerate.new(
  #   Operation::Access.new(
  #     Operand::Object.new(obj),
  #     Operand::Signal.new(associations)
  #   ),
  #   Operand::Signal.new(enumerator),
  #   Operand::Executable.new(lambda do |item|
  #     Operation::Compare.new(
  #       Operand::Object.new(item),
  #       Operand::Signal.new(operator),
  #       Operand::Object.new(value)
  #     )
  #   end)
  # )

# { associations[enumerator]*: predicate }
  # Operation::Enumerate.new(
  #   Operation::Access.new(
  #     Operand::Object.new(obj),
  #     Operand::Signal.new(associations)
  #   ),
  #   Operand::Signal.new(enumerator),
  #   Operand::Executable.new(lambda do |item|
  #     Operation::Compare.new(
  #       Operation::Access.new(
  #         Operand::Object.new(item),
  #         Operand::Signal.new(predicate)
  #       )
  #       Operand::Signal.new('=='),
  #       Operand::Object.new(true)
  #     )
  #   end)
  # )

# { associations[enumerator].attribute: value }
  # Operation::Enumerate.new(
  #   Operation::Access.new(
  #     Operand::Object.new(obj),
  #     Operand::Signal.new(associations)
  #   ),
  #   Operand::Signal.new(enumerator),
  #   Operand::Executable.new(lambda do |item|
  #     Operation::Compare.new(
  #       Operation::Access.new(
  #         Operand::Object.new(item),
  #         Operand::Signal.new(attribute)
  #       ),
  #       Operand::Signal.new('=='),
  #       Operand::Object.new(value)
  #     )
  #   end)
  # )

# { associations[enumerator].attribute(operator): value }
  # Operation::Enumerate.new(
  #   Operation::Access.new(
  #     Operand::Object.new(obj),
  #     Operand::Signal.new(associations)
  #   ),
  #   Operand::Signal.new(enumerator),
  #   Operand::Executable.new(lambda do |item|
  #     Operation::Compare.new(
  #       Operation::Access.new(
  #         Operand::Object.new(item),
  #         Operand::Signal.new(attribute)
  #       ),
  #       Operand::Signal.new(operator),
  #       Operand::Object.new(value)
  #     )
  #   end)
  # )

# { associations[enumerator].attribute*: predicate }
  # Operation::Enumerate.new(
  #   Operation::Access.new(
  #     Operand::Object.new(obj),
  #     Operand::Signal.new(associations)
  #   ),
  #   Operand::Signal.new(enumerator),
  #   Operand::Executable.new(lambda do |item|
  #     Operation::Compare.new(
  #       Operation::Access.new(
  #         Operation::Access.new(
  #           Operand::Object.new(item),
  #           Operand::Signal.new(attribute)
  #         ),
  #         Operand::Signal.new(predicate)
  #       )
  #       Operand::Signal.new('=='),
  #       Operand::Object.new(true)
  #     )
  #   end)
  # )
