# edgecases
# - what if db field but rb operator?
# - what if value is `nil`?

# { attribute: value }
  # Operation::Compare.new(
  #   Operation::Access.new(
  #     Operand::Object.new(obj),
  #     Operand::Signal.new(attribute)
  #   ),
  #   Operand::Signal.new('=='),
  #   Operand::Object.new(value)
  # )

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

# set.filter => { itself[select]: value}
# filterer = Operation::Enumerate.new(Operand::Enumerable.new([1,2,3]), Operand::Signal.new(:select), Operand::Executable.new(->(i) { Operation::Compare.new(Operand::Object.new(i), Operand::Signal.new('>'), Operand::Object.new(1)).visit }))
