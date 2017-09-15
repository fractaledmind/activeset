# frozen_string_literal: true

require 'spec_helper'
require 'ostruct'

RSpec.describe ActiveSet::FilterProcessor do
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
        context 'that matches' do
          let(:filter_structure) do
            {
              string: foo.string,
              symbol: foo.symbol,
              date: foo.date,
              datetime: foo.datetime,
              time: foo.time,
              integer: foo.integer,
              float: foo.float,
              bignum: foo.bignum,
              boolean: foo.boolean,
              assoc: {
                string: foo.assoc.string,
                symbol: foo.assoc.symbol,
                date: foo.assoc.date,
                datetime: foo.assoc.datetime,
                time: foo.assoc.time,
                integer: foo.assoc.integer,
                float: foo.assoc.float,
                bignum: foo.assoc.bignum,
                boolean: foo.assoc.boolean
              }
            }
          end

          it { should eq [foo] }
        end

        context 'that does not match' do
          context 'on the base object' do
            let(:filter_structure) do
              {
                string: '___',
                symbol: foo.symbol,
                date: foo.date,
                datetime: foo.datetime,
                time: foo.time,
                integer: foo.integer,
                float: foo.float,
                bignum: foo.bignum,
                boolean: foo.boolean,
                assoc: {
                  string: foo.assoc.string,
                  symbol: foo.assoc.symbol,
                  date: foo.assoc.date,
                  datetime: foo.assoc.datetime,
                  time: foo.assoc.time,
                  integer: foo.assoc.integer,
                  float: foo.assoc.float,
                  bignum: foo.assoc.bignum,
                  boolean: foo.assoc.boolean
                }
              }
            end

            it { should eq [] }
          end

          context 'on an associated object' do
            let(:filter_structure) do
              {
                string: foo.string,
                symbol: foo.symbol,
                date: foo.date,
                datetime: foo.datetime,
                time: foo.time,
                integer: foo.integer,
                float: foo.float,
                bignum: foo.bignum,
                boolean: foo.boolean,
                assoc: {
                  string: '___',
                  symbol: foo.assoc.symbol,
                  date: foo.assoc.date,
                  datetime: foo.assoc.datetime,
                  time: foo.assoc.time,
                  integer: foo.assoc.integer,
                  float: foo.assoc.float,
                  bignum: foo.assoc.bignum,
                  boolean: foo.assoc.boolean
                }
              }
            end

            it { should eq [] }
          end
        end
      end
    end
  end

  context 'when set is ActiveRecord::Relation' do
    include_context 'for active record sets'

    let(:set) { active_record_set }

    describe '#process' do
      subject { processor.process }

      context 'with a complex query' do
        context 'that matches' do
          let(:filter_structure) do
            {
              string: foo.string,
              date: foo.date,
              datetime: foo.datetime,
              integer: foo.integer,
              float: foo.float,
              boolean: foo.boolean,
              assoc: {
                string: foo.assoc.string,
                date: foo.assoc.date,
                datetime: foo.assoc.datetime,
                integer: foo.assoc.integer,
                float: foo.assoc.float,
                boolean: foo.assoc.boolean
              }
            }
          end

          it { expect(subject.map(&:id)).to eq [foo.id] }
        end

        context 'that does not match' do
          context 'on a base attribute' do
            let(:filter_structure) do
              {
                string: '___',
                date: foo.date,
                datetime: foo.datetime,
                integer: foo.integer,
                float: foo.float,
                boolean: foo.boolean,
                assoc: {
                  string: foo.assoc.string,
                  date: foo.assoc.date,
                  datetime: foo.assoc.datetime,
                  integer: foo.assoc.integer,
                  float: foo.assoc.float,
                  boolean: foo.assoc.boolean
                }
              }
            end

            it { should eq [] }
          end

          context 'on an association\'s attribute' do
            let(:filter_structure) do
              {
                string: foo.string,
                date: foo.date,
                datetime: foo.datetime,
                integer: foo.integer,
                float: foo.float,
                boolean: foo.boolean,
                assoc: {
                  string: '___',
                  date: foo.assoc.date,
                  datetime: foo.assoc.datetime,
                  integer: foo.assoc.integer,
                  float: foo.assoc.float,
                  boolean: foo.assoc.boolean
                }
              }
            end

            it { should eq [] }
          end
        end
      end
    end
  end
end
