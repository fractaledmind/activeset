# frozen_string_literal: true

# Returns a Boolean for whether the block raises the Exception expected
#
# throws?(StandardError) { raise }
# => true
# throws?(NameError) { raise NameError }
# => true
# throws?(NoMethodError) { raise NameError }
# => false
# throws?(StandardError) { 'foo' }
# => false

def throws?(exception) # &block
  yield
  false
rescue Exception => e
  e.is_a? exception
end
