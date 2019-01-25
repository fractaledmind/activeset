class FilterEvaluator < Parslet::Transform
  rule(signal: simple(:signal)) do
    signal
  end

  rule(accessor: simple(:signal)) do |context|
    {
      lhs: access(context[:object], context[:signal]),
      op: '==',
      rhs: context[:value]
    }
  end
  rule(accessor: simple(:signal), operator: simple(:operator)) do |context|
    {
      lhs: access(context[:object], context[:signal]),
      op: context[:operator],
      rhs: context[:value]
    }
  end
  rule(accessor: simple(:signal), predicator: simple(:_)) do |context|
    {
      lhs: call(access(context[:object], context[:signal]), context[:value]),
      op: '==',
      rhs: true
    }
  end
  rule(accessor: simple(:signal), operator: simple(:operator), predicator: simple(:_)) do |context|
    {
      lhs: call(access(context[:object], context[:signal]), context[:value]),
      op: context[:operator],
      rhs: true
    }
  end

  rule(accessor: sequence(:signals)) do |context|
    {
      lhs: access(context[:object], context[:signals]),
      op: '==',
      rhs: context[:value]
    }
  end
  rule(accessor: sequence(:signals), operator: simple(:operator)) do |context|
    {
      lhs: access(context[:object], context[:signals]),
      op: context[:operator],
      rhs: context[:value]
    }
  end
  rule(accessor: sequence(:signals), predicator: simple(:_)) do |context|
    {
      lhs: call(access(context[:object], context[:signals]), context[:value]),
      op: '==',
      rhs: true
    }
  end
  rule(accessor: sequence(:signals), operator: simple(:operator), predicator: simple(:_)) do |context|
    {
      lhs: call(access(context[:object], context[:signals]), context[:value]),
      op: context[:operator],
      rhs: true
    }
  end

  rule(comparison: subtree(:comparison)) do |context|
    p context[:comparison]

    compare(context.dig(:comparison, :lhs), context.dig(:comparison, :op), context.dig(:comparison, :rhs))
  end

  def self.access(object, *signals)
    signals.reduce(object) { |memo, signal| call(memo, signal) }
  end

  def self.call(object, signal)
    signal ||= 'itself'
    object&.public_send(signal)
  end

  def self.compare(lhs, op, rhs)
    lhs&.public_send(op, rhs)
  end
end

# => {comparison: {accessor: {signal: "attribute"}}}
# => {comparison: {accessor: {signal: "attribute"}, operator: {signal: "operator"}}}
# => {comparison: {accessor: [{signal: "association"}, {signal: "attribute"}]}}
# => {comparison: {accessor: [{signal: "association"}, {signal: "attribute"}], operator: {signal: "operator"}}}

# => {comparison: {accessor: {signal: "attribute"}, predicator: "*"}}
#:  {comparison: {accessor: [{signal: "association"}, {signal: "attribute"}], predicator: "*"}}
#:  {accessor: {signal: "associations"}, enumeration: {enumerator: {signal: "enumerator"}}}
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

evaluator = FilterEvaluator.new
context = { object: OpenStruct.new(a: OpenStruct.new(b: 'abc')), value: 'abc' }
tree = {comparison: {accessor: {signal: "attr"}, operator: {signal: "!="}}}
evaluator.apply(tree, context)
FilterEvaluator.new.apply({comparison: {accessor: {signal: "attribute"}, operator: {signal: "operator"}}}, object: nil)
