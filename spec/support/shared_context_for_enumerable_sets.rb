# frozen_string_literal: true

require 'spec_helper'
require 'ostruct'

RSpec.shared_context 'for enumerable sets' do
  let(:foo) do
    OpenStruct.new(id: 1,
                   assoc: OpenStruct.new)
  end
  let(:bar) do
    OpenStruct.new(id: 2,
                   assoc: OpenStruct.new)
  end

  let(:enumerable_set) { [foo, bar] }
end
