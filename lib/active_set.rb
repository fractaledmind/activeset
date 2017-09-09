# frozen_string_literal: true

require 'active_set/version'

class ActiveSet
  include Enumerable

  def initialize(set)
    @set = set
  end

  def each(&block)
    @set.each(&block)
  end
end
