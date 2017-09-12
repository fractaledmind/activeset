# frozen_string_literal: true

require 'spec_helper'
require 'ostruct'

RSpec.shared_context 'for enumerable sets' do
  let(:foo) do
    OpenStruct.new(id: 1,
                   string: 'foo',
                   symbol: :foo,
                   date: 1.day.from_now.to_date,
                   datetime: 1.day.from_now.to_datetime,
                   time: 1.day.from_now.to_time,
                   integer: 1,
                   float: 1.0,
                   bignum: 2**64,
                   boolean: true,
                   nil: nil)
  end
  let(:bar) do
    OpenStruct.new(id: 2,
                   string: 'bar',
                   symbol: :bar,
                   date: 1.day.ago.to_date,
                   datetime: 1.day.ago.to_datetime,
                   time: 1.day.ago.to_time,
                   integer: 2,
                   float: 2.0,
                   bignum: 3**64,
                   boolean: false,
                   nil: '')
  end
  before(:each) do
    foo.assoc = bar
    bar.assoc = foo
  end

  let(:enumerable_set) { [foo, bar] }
end
