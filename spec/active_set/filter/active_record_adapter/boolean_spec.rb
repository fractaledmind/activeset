# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveSet::FilterProcessor::ActiveRecordAdapter do
  include_context 'for active record sets'

  let(:adapter) { described_class.new(instruction) }
  let(:instruction) { ActiveSet::Instructions::Entry.new(keypath, value) }

  describe '#process with :boolean type attribute value' do
    subject { adapter.process(active_record_set) }

    context 'on the base object' do
      before(:each) do
        foo.tap { |foo| foo.boolean = true }.tap(&:save)
        bar.tap { |bar| bar.boolean = false }.tap(&:save)
      end

      context 'with default == operator' do
        let(:keypath) { [:boolean] }

        context 'and the value matches' do
          let(:value) { foo.boolean }

          it { expect(subject.map(&:id)).to eq [foo.id] }
        end

        context 'and the value does not match' do
          let(:value) { '___' }

          it { expect(subject.map(&:id)).to eq [] }
        end
      end
    end

    context 'on an associated object' do
      before(:each) do
        foo.assoc.tap { |foo_assoc| foo_assoc.boolean = true }.tap(&:save)
        bar.assoc.tap { |bar_assoc| bar_assoc.boolean = false }.tap(&:save)
      end

      context 'with default == operator' do
        let(:keypath) { %w[assoc boolean] }

        context 'and the value matches' do
          let(:value) { foo.assoc.boolean }

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
