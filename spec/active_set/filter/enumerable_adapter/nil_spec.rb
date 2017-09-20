# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveSet::FilterProcessor::EnumerableAdapter do
  include_context 'for enumerable sets'

  let(:adapter) { described_class.new(instruction) }
  let(:instruction) { ActiveSet::Instructions::Entry.new(keypath, value) }

  describe '#process with NilClass type attribute value' do
    subject { adapter.process(enumerable_set) }

    context 'on the base object' do
      before(:each) do
        foo.nil = nil
        bar.nil = ''
      end

      context 'with default == operator' do
        let(:keypath) { [:nil] }

        context 'and the value matches' do
          let(:value) { foo.nil }

          it { expect(subject.map(&:id)).to eq [foo.id] }
        end

        context 'and the value does not matches' do
          let(:value) { '___' }

          it { expect(subject.map(&:id)).to eq [] }
        end
      end
    end

    context 'on an associated object' do
      before(:each) do
        foo.assoc.nil = nil
        bar.assoc.nil = ''
      end

      context 'with default == operator' do
        let(:keypath) { %w[assoc nil] }

        context 'and the value matches' do
          let(:value) { foo.assoc.nil }

          it { expect(subject.map(&:id)).to eq [foo.id] }
        end

        context 'and the value does not match' do
          let(:value) { '___' }

          it { expect(subject.map(&:id)).to eq [] }
        end
      end
    end
  end
end
