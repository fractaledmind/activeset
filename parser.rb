def log(msg)
  p ' ' * (caller.size - 40) + msg
end

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

module AST
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

class EnumerableVisitor
end

module O
  ENUMERATOR_RE = /\[(.*?)\]/.freeze
  OPERATOR_RE = /\((.*?)\)$/.freeze
  LITERATE_RE = /\*$/.freeze
  ACCESSOR_RE = /\./.freeze
  PREDICATES = {
    'eq': ['=='],
    'not_eq': ['!='],
    'lt': ['<'],
    'lteq': ['<='],
    'gt': ['>'],
    'gteq': ['>='],
    'start': ['start_with?'],
    'end': ['end_with?'],
    'contain': ['include?'],
    'is_null': ['==', ->(_) { nil }],
    'not_null': ['!=', ->(_) { nil }],
    'is_true': ['==', ->(_) { true }],
    'is_false': ['==', ->(_) { false }],
    'matches': ['match', ->(v) { v.to_s.tr('%', '*').gsub('_', '{1}') }],
    'does_not_match': ['match', ->(v) { v.to_s.tr('%', '*').gsub('_', '{1}') }, ->(b) { !b }],
    'not_start': ['start_with?', nil, ->(b) { !b }],
    'not_end': ['end_with?', nil, ->(b) { !b }],
    'not_contain': ['include?', nil, ->(b) { !b }]
  }.freeze

  def self.call(obj, signal)
    method_name = signal.presence || 'itself'
    log("call(#{obj}, #{method_name})")
    obj.public_send(method_name)
  end

  def self.compare(lhs, op, rhs)
    log("compare(#{lhs}, #{op}, #{rhs})")
    operator_method, value_mutator, result_mutator = PREDICATES[op.to_sym]
    rhs = value_mutator.call(rhs) if value_mutator
    output = lhs.public_send(operator_method, rhs)
    output = result_mutator.call(output) if result_mutator
    log("#{operator_method}(#{lhs}, #{rhs.inspect}) ==> #{output}")
    output
  end

  def self.enumerate(enum, signal, &block)
    log("enumerate(#{enum}, #{signal})")
    enum.public_send(signal, &block)
  end
end

def interpret(obj, instruction, value)
  log("interpret(#{obj}, #{instruction}, #{value})")

  if instruction =~ O::ENUMERATOR_RE
    enum_path, enumerator, obj_path = instruction.to_s.partition O::ENUMERATOR_RE
    enumerator = enumerator[O::ENUMERATOR_RE, 1]
    enumerable = O.call(obj, enum_path)
    O.enumerate(enumerable, enumerator) do |i|
      parse(i, obj_path, value)
    end
  elsif instruction =~ O::ACCESSOR_RE
    obj_path, _, attr_path = instruction.to_s.rpartition O::ACCESSOR_RE
    comparand = obj_path.to_s.split(O::ACCESSOR_RE).reject(&:blank?).reduce(obj) { |o, a| O.call(o, a) }
    parse(comparand, attr_path, value)
  elsif instruction =~ O::LITERATE_RE
    obj_path, = instruction.to_s.partition O::LITERATE_RE
    attribute = O.call(obj, obj_path)
    boolean = O.call(attribute, value)
    O.compare(boolean, '==', true)
  else
    obj_path, operator, = instruction.to_s.partition O::OPERATOR_RE
    attribute = O.call(obj, obj_path)
    operator = operator[O::OPERATOR_RE, 1] || '=='
    O.compare(attribute, operator, value)
  end
end

class Parser
  ENUMERATOR_RE = /\[(.*?)\]/.freeze
  OPERATOR_RE = /\((.*?)\)$/.freeze
  LITERATE_RE = /\*$/.freeze
  ACCESSOR_RE = /\./.freeze

  def parse(obj, instruction, value)
    log("parse(#{obj}, #{instruction}, #{value})")

    if instruction =~ ENUMERATOR_RE
      enum_path, enumerator, obj_path = instruction.to_s.partition ENUMERATOR_RE
      enumerator = enumerator[ENUMERATOR_RE, 1]
      enumerable = O.call(obj, enum_path)
      O.enumerate(enumerable, enumerator) do |i|
        parse(i, obj_path, value)
      end
    elsif instruction =~ ACCESSOR_RE
      obj_path, _, attr_path = instruction.to_s.rpartition ACCESSOR_RE
      comparand = obj_path.to_s.split(ACCESSOR_RE).reject(&:blank?).reduce(obj) { |o, a| O.call(o, a) }
      parse(comparand, attr_path, value)
    elsif instruction =~ LITERATE_RE
      obj_path, = instruction.to_s.partition LITERATE_RE
      attribute = O.call(obj, obj_path)
      boolean = O.call(attribute, value)
      O.compare(boolean, '==', true)
    else
      obj_path, operator, = instruction.to_s.partition OPERATOR_RE
      attribute = O.call(obj, obj_path)
      operator = operator[O::OPERATOR_RE, 1] || '=='
      O.compare(attribute, operator, value)
    end
  end
end

set = [
  OpenStruct.new(i: 0, s: nil,
                 one: OpenStruct.new(i: 10, s: '12'),
                 many: [
                  OpenStruct.new(i: 20, s: 'qwe'),
                  OpenStruct.new(i: 21, s: 'rty'),
                 ]),
  OpenStruct.new(i: 1, s: 'abc',
                 one: OpenStruct.new(i: 11, s: '34'),
                 many: [
                  OpenStruct.new(i: 22, s: 'uio'),
                  OpenStruct.new(i: 23, s: 'p[]'),
                 ]),
  OpenStruct.new(i: 2, s: 'def',
                 one: OpenStruct.new(i: 12, s: '56'),
                 many: [
                  OpenStruct.new(i: 24, s: 'asd'),
                  OpenStruct.new(i: 25, s: 'fgh'),
                 ]),
  OpenStruct.new(i: 3, s: 'ghi',
                 one: OpenStruct.new(i: 13, s: '78'),
                 many: [
                  OpenStruct.new(i: 26, s: 'jkl'),
                  OpenStruct.new(i: 27, s: ';z'),
                 ]),
  OpenStruct.new(i: 4, s: 'jkl',
                 one: OpenStruct.new(i: 14, s: '90'),
                 many: [
                  OpenStruct.new(i: 28, s: 'xcv'),
                  OpenStruct.new(i: 29, s: 'bnm'),
                 ]),
  OpenStruct.new(i: 5, s: 'mno',
                 one: OpenStruct.new(i: 15, s: ''),
                 many: [
                  OpenStruct.new(i: 30, s: ',./'),
                  OpenStruct.new(i: 31, s: ''),
                 ]),
]

# { attribute: value }
# { attribute(operator): value }
# { attribute*: predicate }
# { association.attribute: value }
# { association.attribute(operator): value }
# { association.attribute*: predicate }
# { associations[enumerator]: value }
# { associations[enumerator](operator): value }
# { associations[enumerator]*: predicate }
# { associations[enumerator].attribute: value }
# { associations[enumerator].attribute(operator): value }
# { associations[enumerator].attribute*: predicate }

def filter_set(set, instructions)
  instructions.reduce(set) do |filtered, instruction|
    filtered.select { |item| parse(item, *instruction) }
  end
end

filter_set([OpenStruct.new(many: [1,2,3]), OpenStruct.new(many: [3,4,5])], { 'many[any?]*': :odd? })
