# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveSet::SortProcessor::ActiveRecordAdapter do
  include_context 'for active record sets'

  let(:adapter) { described_class.new(keypath, value) }

  describe '#process with :string type attribute value' do
    subject { adapter.process(active_record_set) }

    context 'on the base object' do
      before(:each) do
        foo.tap { |foo| foo.string = 'aaa' }.tap(&:save)
        bar.tap { |bar| bar.string = 'ZZZ' }.tap(&:save)
      end

      context 'when direction is ASC' do
        context 'with default case-sensitive sort' do
          let(:keypath) { [:string] }
          let(:value) { :asc }

          it { expect(subject.map(&:id)).to eq [bar.id, foo.id] }
        end

        context 'with case-INsensitive sort' do
          let(:keypath) { ['string(i)'] }
          let(:value) { 'asc' }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end

      context 'when direction is DESC' do
        context 'with default case-sensitive sort' do
          let(:keypath) { [:string] }
          let(:value) { :desc }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end

        context 'with case-INsensitive sort' do
          let(:keypath) { ['string(i)'] }
          let(:value) { 'desc' }

          it { expect(subject.map(&:id)).to eq [bar.id, foo.id] }
        end
      end
    end

    context 'on an associated object' do
      before(:each) do
        foo.assoc.tap { |foo_assoc| foo_assoc.string = 'aaa' }.tap(&:save)
        bar.assoc.tap { |bar_assoc| bar_assoc.string = 'ZZZ' }.tap(&:save)
      end

      context 'when direction is ASC' do
        context 'with default case-sensitive sort' do
          let(:keypath) { %w[assoc string] }
          let(:value) { :asc }

          it { expect(subject.map(&:id)).to eq [bar.id, foo.id] }
        end

        context 'with case-INsensitive sort' do
          let(:keypath) { %w[assoc string(i)] }
          let(:value) { 'asc' }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end

      context 'when direction is DESC' do
        context 'with default case-sensitive sort' do
          let(:keypath) { %w[assoc string] }
          let(:value) { :desc }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end

        context 'with case-INsensitive sort' do
          let(:keypath) { %w[assoc string(i)] }
          let(:value) { 'desc' }

          it { expect(subject.map(&:id)).to eq [bar.id, foo.id] }
        end
      end
    end
  end
end
