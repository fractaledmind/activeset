# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveSet::SortProcessor::EnumerableAdapter do
  include_context 'for enumerable sets'

  let(:adapter) { described_class.new(instruction) }
  let(:instruction) { ActiveSet::Instructions::Entry.new(keypath, value) }

  describe '#process with String type attribute value' do
    subject { adapter.process(enumerable_set) }

    context 'on the base object' do
      before(:each) do
        foo.datetime = 1.day.from_now.to_datetime
        bar.datetime = 1.day.ago.to_datetime
      end

      context 'when direction is ASC' do
        context 'with default case-sensitive sort' do
          let(:keypath) { [:datetime] }
          let(:value) { :asc }

          it { expect(subject.map(&:id)).to eq [bar.id, foo.id] }
        end

        context 'with case-INsensitive sort' do
          let(:keypath) { ['datetime(i)'] }
          let(:value) { 'asc' }

          it { expect(subject.map(&:id)).to eq [bar.id, foo.id] }
        end
      end

      context 'when direction is DESC' do
        context 'with default case-sensitive sort' do
          let(:keypath) { [:datetime] }
          let(:value) { :desc }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end

        context 'with case-INsensitive sort' do
          let(:keypath) { ['datetime(i)'] }
          let(:value) { 'desc' }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end
    end

    context 'on an associated object' do
      before(:each) do
        foo.assoc.datetime = 1.day.from_now.to_datetime
        bar.assoc.datetime = 1.day.ago.to_datetime
      end

      context 'when direction is ASC' do
        context 'with default case-sensitive sort' do
          let(:keypath) { %w[assoc datetime] }
          let(:value) { :asc }

          it { expect(subject.map(&:id)).to eq [bar.id, foo.id] }
        end

        context 'with case-INsensitive sort' do
          let(:keypath) { %w[assoc datetime(i)] }
          let(:value) { 'asc' }

          it { expect(subject.map(&:id)).to eq [bar.id, foo.id] }
        end
      end

      context 'when direction is DESC' do
        context 'with default case-sensitive sort' do
          let(:keypath) { %w[assoc datetime] }
          let(:value) { :desc }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end

        context 'with case-INsensitive sort' do
          let(:keypath) { %w[assoc datetime(i)] }
          let(:value) { 'desc' }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end
    end
  end
end
