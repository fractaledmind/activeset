# frozen_string_literal: true

# Returns a Numeric for `value` that respects sort-order
# can be used in Enumerable#sort_by
#
# transform_to_sortable_numeric(1)
# => 1
# transform_to_sortable_numeric('aB09ü')
# => (24266512014313/250000000000)
# transform_to_sortable_numeric(true)
# => 1
# transform_to_sortable_numeric(Date.new(2000, 12, 25))
# => 977720400000

def transform_to_sortable_numeric(value)
  return value if value.is_a?(Numeric)
  return 1 if value == true
  return 0 if value == false

  if value.is_a?(String) || value.is_a?(Symbol)
    return value
            .to_s                                         # 'aB09ü'
            .split('')                                    # ["a", "B", "0", "9", "ü"]
            .map { |char| char.ord.to_s.rjust(3, '0') }   # ["097", "066", "048", "057", "252"]
            .insert(1, '.')                               # ["097", ".", "066", "048", "057", "252"]
            .reduce(&:concat)                             # "097.066048057252"
            .to_r                                         # (24266512014313/250000000000)
  end

  # https://stackoverflow.com/a/30604935/2884386
  return (value.to_time.to_f * 1000).round if value.respond_to?(:to_time)

  # :nocov:
  value
  # :nocov:
end
