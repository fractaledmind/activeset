# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveSet::Processor::Filter::ActiveRecordAdapter do
  include_context 'for active record sets'

  let(:adapter) { described_class.new(active_record_set, instruction) }
  let(:instruction) { ActiveSet::Instructions::Entry.new(keypath, value) }

  describe '#process with an ActiveRecord Scope value' do
    subject { adapter.process[:set] }

    context 'when scope takes two values' do
      context 'on the base object' do
        before(:each) do
          foo.tap { |foo| foo.datetime = 1.day.from_now.to_datetime }.tap(&:save)
          bar.tap { |bar| bar.datetime = 1.day.ago.to_datetime }.tap(&:save)
        end

        let(:keypath) { [:datetime_between] }

        context 'and the value matches' do
          let(:value) { [Date.today.to_datetime, 2.days.from_now.to_datetime] }

          it { expect(subject.map(&:id)).to eq [foo.id] }
        end

        context 'and the value does not match' do
          let(:value) { [DateTime.new, DateTime.new] }

          it { expect(subject.map(&:id)).to eq [] }
        end
      end

      context 'on an associated object' do
        before(:each) do
          foo.assoc.tap { |foo_assoc| foo_assoc.datetime = 1.day.from_now.to_datetime }.tap(&:save)
          bar.assoc.tap { |bar_assoc| bar_assoc.datetime = 1.day.ago.to_datetime }.tap(&:save)
        end

        let(:keypath) { %i[assoc datetime_between] }

        context 'and the value matches' do
          let(:value) { [Date.today.to_datetime, 2.days.from_now.to_datetime] }

          it { expect(subject.map(&:id)).to eq [foo.id] }
        end

        context 'and the value does not match' do
          let(:value) { [DateTime.new, DateTime.new] }

          it { expect(subject.map(&:id)).to eq [] }
        end
      end
    end

    context 'when scope takes one value' do
      context 'on the base object' do
        before(:each) do
          foo.tap { |foo| foo.string = 'aaa' }.tap(&:save)
          bar.tap { |bar| bar.string = 'ZZZ' }.tap(&:save)
        end

        let(:keypath) { [:string_starts_with] }

        context 'and the value matches' do
          let(:value) { 'a' }

          it { expect(subject.map(&:id)).to eq [foo.id] }
        end

        context 'and the value does not match' do
          let(:value) { '-' }

          it { expect(subject.map(&:id)).to eq [] }
        end
      end

      context 'on an associated object' do
        before(:each) do
          foo.assoc.tap { |foo_assoc| foo_assoc.string = 'aaa' }.tap(&:save)
          bar.assoc.tap { |bar_assoc| bar_assoc.string = 'ZZZ' }.tap(&:save)
        end

        let(:keypath) { %i[assoc string_starts_with] }

        context 'and the value matches' do
          let(:value) { 'a' }

          it { expect(subject.map(&:id)).to eq [foo.id] }
        end

        context 'and the value does not match' do
          let(:value) { '-' }

          it { expect(subject.map(&:id)).to eq [] }
        end
      end
    end
  end
end
