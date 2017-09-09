# frozen_string_literal: true

require_relative './base_processor'

class PaginateProcessor < BaseProcessor
  def process
    pagesize = @structure[:size] || 25
    return @set if @set.count < pagesize
    @set.each_slice(pagesize).take(@structure[:page]).last
  end
end
