# frozen_string_literal: true

require 'spec_helper'
require 'ostruct'

RSpec.describe ActiveSet::FilterProcessor do
  let(:processor) { described_class.new(set, filter_structure) }

  context 'when set is Enumerable' do
    include_context 'for enumerable sets'

    let(:set) { enumerable_set }

    describe '#process' do
      subject { processor.process }

      context 'with a complex query' do
        context 'of symbol keys' do
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
            context 'on a base attribute' do
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

            context 'on an association\'s attribute' do
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

        context 'of string keys' do
          context 'that matches' do
            let(:filter_structure) do
              {
                'string' => bar.string,
                'symbol' => bar.symbol,
                'date' => bar.date,
                'datetime' => bar.datetime,
                'time' => bar.time,
                'integer' => bar.integer,
                'float' => bar.float,
                'bignum' => bar.bignum,
                'boolean' => bar.boolean,
                'assoc' => {
                  'string' => bar.assoc.string,
                  'symbol' => bar.assoc.symbol,
                  'date' => bar.assoc.date,
                  'datetime' => bar.assoc.datetime,
                  'time' => bar.assoc.time,
                  'integer' => bar.assoc.integer,
                  'float' => bar.assoc.float,
                  'bignum' => bar.assoc.bignum,
                  'boolean' => bar.assoc.boolean
                }
              }
            end

            it { should eq [bar] }
          end

          context 'that does not match' do
            context 'on a base attribute' do
              let(:filter_structure) do
                {
                  'string' => '___',
                  'symbol' => bar.symbol,
                  'date' => bar.date,
                  'datetime' => bar.datetime,
                  'time' => bar.time,
                  'integer' => bar.integer,
                  'float' => bar.float,
                  'bignum' => bar.bignum,
                  'boolean' => bar.boolean,
                  'assoc' => {
                    'string' => bar.assoc.string,
                    'symbol' => bar.assoc.symbol,
                    'date' => bar.assoc.date,
                    'datetime' => bar.assoc.datetime,
                    'time' => bar.assoc.time,
                    'integer' => bar.assoc.integer,
                    'float' => bar.assoc.float,
                    'bignum' => bar.assoc.bignum,
                    'boolean' => bar.assoc.boolean
                  }
                }
              end

              it { should eq [] }
            end

            context 'on an association\'s attribute' do
              let(:filter_structure) do
                {
                  'string' => bar.string,
                  'symbol' => bar.symbol,
                  'date' => bar.date,
                  'datetime' => bar.datetime,
                  'time' => bar.time,
                  'integer' => bar.integer,
                  'float' => bar.float,
                  'bignum' => bar.bignum,
                  'boolean' => bar.boolean,
                  'assoc' => {
                    'string' => '___',
                    'symbol' => bar.assoc.symbol,
                    'date' => bar.assoc.date,
                    'datetime' => bar.assoc.datetime,
                    'time' => bar.assoc.time,
                    'integer' => bar.assoc.integer,
                    'float' => bar.assoc.float,
                    'bignum' => bar.assoc.bignum,
                    'boolean' => bar.assoc.boolean
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

  context 'when set is ActiveRecord::Relationd' do
    include_context 'for active record sets'

    let(:set) { active_record_set }

    describe '#process' do
      subject { processor.process }

      context 'with a complex query' do
        context 'of symbol keys' do
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

        context 'of string keys' do
          context 'that matches' do
            let(:filter_structure) do
              {
                'string' => bar.string,
                'date' => bar.date,
                'datetime' => bar.datetime,
                'integer' => bar.integer,
                'float' => bar.float,
                'boolean' => bar.boolean,
                'assoc' => {
                  'string' => bar.assoc.string,
                  'date' => bar.assoc.date,
                  'datetime' => bar.assoc.datetime,
                  'integer' => bar.assoc.integer,
                  'float' => bar.assoc.float,
                  'boolean' => bar.assoc.boolean
                }
              }
            end

            it { expect(subject.map(&:id)).to eq [bar.id] }
          end

          context 'that does not match' do
            context 'on a base attribute' do
              let(:filter_structure) do
                {
                  'string' => '___',
                  'date' => bar.date,
                  'datetime' => bar.datetime,
                  'integer' => bar.integer,
                  'float' => bar.float,
                  'boolean' => bar.boolean,
                  'assoc' => {
                    'string' => bar.assoc.string,
                    'date' => bar.assoc.date,
                    'datetime' => bar.assoc.datetime,
                    'integer' => bar.assoc.integer,
                    'float' => bar.assoc.float,
                    'boolean' => bar.assoc.boolean
                  }
                }
              end

              it { should eq [] }
            end

            context 'on an association\'s attribute' do
              let(:filter_structure) do
                {
                  'string' => bar.string,
                  'date' => bar.date,
                  'datetime' => bar.datetime,
                  'integer' => bar.integer,
                  'float' => bar.float,
                  'boolean' => bar.boolean,
                  'assoc' => {
                    'string' => '___',
                    'date' => bar.assoc.date,
                    'datetime' => bar.assoc.datetime,
                    'integer' => bar.assoc.integer,
                    'float' => bar.assoc.float,
                    'boolean' => bar.assoc.boolean
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
end
