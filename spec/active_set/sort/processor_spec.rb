# frozen_string_literal: true

require 'spec_helper'
require 'ostruct'

RSpec.describe ActiveSet::Sort::Processor do
  let(:foo) { OpenStruct.new(key: 'foo', association: OpenStruct.new(key: 'oof')) }
  let(:bar) { OpenStruct.new(key: 'bar', association: OpenStruct.new(key: 'rab')) }
  let(:baz) { OpenStruct.new(key: 'baz', association: OpenStruct.new(key: 'zab')) }
  let(:set) { [foo, bar, baz] }

  let(:processor) { described_class.new(set, sort_structure) }

  describe '#process' do
    subject { processor.process }

    context 'with attributes on the base resource' do
      context 'when direction is ASC' do
        let(:sort_structure) { { key: :asc } }

        it { should eq [bar, baz, foo] }
      end

      context 'when direction is DESC' do
        let(:sort_structure) { { key: 'desc' } }

        it { should eq [foo, baz, bar] }
      end
    end

    context 'with attributes on an associated resource' do
      context 'when direction is ASC' do
        let(:sort_structure) { { association: { key: 'asc' } } }

        it { should eq [foo, bar, baz] }
      end

      context 'when direction is DESC' do
        let(:sort_structure) { { association: { key: :desc } } }

        it { should eq [baz, bar, foo] }
      end
    end
  end
end
