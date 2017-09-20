# frozen_string_literal: true

require 'spec_helper'
require 'ostruct'

RSpec.describe ActiveSet::SortProcessor do
  let(:processor) { described_class.new(set, filter_structure) }

  context 'when set is Enumerable' do
    include_context 'for enumerable sets'

    before(:each) do
      foo.tap do |foo|
        foo.bignum = 2**64
        foo.boolean = true
        foo.date = 1.day.from_now.to_date
        foo.datetime = 1.day.from_now.to_datetime
        foo.float = 1.11
        foo.integer = 1
        foo.nil = nil
        foo.string = 'aaa'
        foo.symbol = :aaa
        foo.time = 1.day.from_now.to_time
      end
      foo.assoc = foo

      bar.tap do |bar|
        bar.bignum = 3**64
        bar.boolean = false
        bar.date = 1.day.ago.to_date
        bar.datetime = 1.day.ago.to_datetime
        bar.float = 2.22
        bar.integer = 2
        bar.nil = ''
        bar.string = 'zzz'
        bar.symbol = :zzz
        bar.time = 1.day.ago.to_time
      end
      bar.assoc = bar
    end

    let(:set) { enumerable_set }

    describe '#process' do
      subject { processor.process }

      context 'with a complex query' do
        context do
          let(:filter_structure) do
            {
              string: :asc,
              assoc: {
                string: :asc
              }
            }
          end

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end

        context do
          let(:filter_structure) do
            {
              string: :asc,
              assoc: {
                string: :desc
              }
            }
          end

          it { expect(subject.map(&:id)).to eq [bar.id, foo.id] }
        end
      end
    end
  end

  context 'when set is ActiveRecord::Relation' do
    include_context 'for active record sets'

    before(:each) do
      foo.tap { |foo| foo.string = 'aaa' }.tap(&:save)
      bar.tap { |bar| bar.string = 'ZZZ' }.tap(&:save)
      foo.assoc.tap { |foo_assoc| foo_assoc.string = 'aaa' }.tap(&:save)
      bar.assoc.tap { |bar_assoc| bar_assoc.string = 'ZZZ' }.tap(&:save)
    end

    let(:set) { active_record_set }

    describe '#process' do
      subject { processor.process }

      context 'with a complex query' do
        context 'both ASC and both case-sensitive' do
          let(:filter_structure) do
            {
              string: :asc,
              assoc: {
                string: :asc
              }
            }
          end

          it { expect(subject.map(&:id)).to eq [bar.id, foo.id] }
        end

        context 'both ASC and both case-insensitive' do
          let(:filter_structure) do
            {
              'string(i)': :asc,
              assoc: {
                'string(i)': :asc
              }
            }
          end

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end

        context 'one ASC and one DESC and both case-insensitive' do
          let(:filter_structure) do
            {
              'string(i)': :asc,
              assoc: {
                'string(i)': :desc
              }
            }
          end

          it { expect(subject.map(&:id)).to eq [bar.id, foo.id] }
        end
      end
    end
  end
end
