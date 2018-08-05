# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveSet::Processor::Sort::EnumerableAdapter do
  include_context 'for enumerable sets'

  let(:adapter) { described_class.new(enumerable_set, instructions) }
  let(:instructions) { ActiveSet::Instructions.new(keypath => value) }

  describe '#process with String type attribute value' do
    subject { adapter.process }

    context 'on the base object' do
      before(:each) do
        foo.boolean = true
        bar.boolean = false
      end

      context 'when direction is ASC' do
        context 'with default case-sensitive sort' do
          let(:keypath) { [:boolean] }
          let(:value) { :asc }

          it { expect(subject.map(&:id)).to eq [bar.id, foo.id] }
        end

        context 'with case-INsensitive sort' do
          let(:keypath) { ['boolean(i)'] }
          let(:value) { 'asc' }

          it { expect(subject.map(&:id)).to eq [bar.id, foo.id] }
        end
      end

      context 'when direction is DESC' do
        context 'with default case-sensitive sort' do
          let(:keypath) { [:boolean] }
          let(:value) { :desc }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end

        context 'with case-INsensitive sort' do
          let(:keypath) { ['boolean(i)'] }
          let(:value) { 'desc' }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end
    end

    context 'on an associated object' do
      before(:each) do
        foo.assoc.boolean = true
        bar.assoc.boolean = false
      end

      context 'when direction is ASC' do
        context 'with default case-sensitive sort' do
          let(:keypath) { %w[assoc boolean] }
          let(:value) { :asc }

          it { expect(subject.map(&:id)).to eq [bar.id, foo.id] }
        end

        context 'with case-INsensitive sort' do
          let(:keypath) { %w[assoc boolean(i)] }
          let(:value) { 'asc' }

          it { expect(subject.map(&:id)).to eq [bar.id, foo.id] }
        end
      end

      context 'when direction is DESC' do
        context 'with default case-sensitive sort' do
          let(:keypath) { %w[assoc boolean] }
          let(:value) { :desc }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end

        context 'with case-INsensitive sort' do
          let(:keypath) { %w[assoc boolean(i)] }
          let(:value) { 'desc' }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end
    end
  end
end
