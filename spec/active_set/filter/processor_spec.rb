# frozen_string_literal: true

require 'spec_helper'
require 'ostruct'

RSpec.describe ActiveSet::Filter::Processor do
  let(:foo) { OpenStruct.new(key: 'foo', association: OpenStruct.new(key: 'oof')) }
  let(:bar) { OpenStruct.new(key: 'bar', association: OpenStruct.new(key: 'rab')) }
  let(:baz) { OpenStruct.new(key: 'baz', association: OpenStruct.new(key: 'zab')) }
  let(:set) { [foo, bar, baz] }

  let(:processor) { described_class.new(set, filter_structure) }

  describe '#process' do
    subject { processor.process }

    context 'with attributes on the base resource' do
      context 'when value matches' do
        let(:filter_structure) { { key: bar.key } }

        it { should eq [bar] }
      end

      context 'when value doesn\'t match' do
        let(:filter_structure) { { key: '___' } }

        it { should eq [] }
      end
    end

    context 'with attributes on an associated resource' do
      context 'when value matches' do
        let(:filter_structure) { { association: { key: foo.association.key } } }

        it { should eq [foo] }
      end

      context 'when value doesn\'t match' do
        let(:filter_structure) { { association: { key: '___' } } }

        it { should eq [] }
      end
    end
  end
end
