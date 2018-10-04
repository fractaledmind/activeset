# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveSet do
  before(:all) do
    @foo_1 = FactoryGirl.create(:foo, string: 'a', integer: 1, boolean: true,
                                date: 1.day.from_now.to_date, datetime: 1.day.from_now.to_datetime,
                                decimal: 1.1, float: 1.1, time: 1.hour.from_now.to_time.to_s[12..-1],
                                assoc: FactoryGirl.create(:assoc, string: 'ra', integer: 9))
    @foo_2 = FactoryGirl.create(:foo, string: 'a', integer: 2, boolean: true,
                                date: 1.day.ago.to_date, datetime: 1.day.ago.to_datetime,
                                decimal: 2.2, float: 2.2, time: 2.hours.from_now.to_time.to_s[12..-1],
                                assoc: FactoryGirl.create(:assoc, string: 'ra', integer: 8))
    @foo_3 = FactoryGirl.create(:foo, string: 'z', integer: 1, boolean: true,
                                date: 1.day.from_now.to_date, datetime: 1.day.from_now.to_datetime,
                                decimal: 1.1, float: 1.1, time: 1.hour.ago.to_time.to_s[12..-1],
                                assoc: FactoryGirl.create(:assoc, string: 'rz', integer: 9))
    @foo_4 = FactoryGirl.create(:foo, string: 'z', integer: 2, boolean: true,
                                date: 1.day.ago.to_date, datetime: 1.day.ago.to_datetime,
                                decimal: 2.2, float: 2.2, time: 2.hours.ago.to_time.to_s[12..-1],
                                assoc: FactoryGirl.create(:assoc, string: 'rz', integer: 8))
    @foo_5 = FactoryGirl.create(:foo, string: 'A', integer: 1, boolean: false,
                                date: 1.week.from_now.to_date, datetime: 1.week.from_now.to_datetime,
                                decimal: 1.1, float: 1.1, time: 1.hour.from_now.to_time.to_s[12..-1],
                                assoc: FactoryGirl.create(:assoc, string: 'rA', integer: 9))
    @foo_6 = FactoryGirl.create(:foo, string: 'A', integer: 2, boolean: false,
                                date: 1.week.ago.to_date, datetime: 1.week.ago.to_datetime,
                                decimal: 2.2, float: 2.2, time: 2.hours.from_now.to_time.to_s[12..-1],
                                assoc: FactoryGirl.create(:assoc, string: 'rA', integer: 8))
    @foo_7 = FactoryGirl.create(:foo, string: 'Z', integer: 1, boolean: false,
                                date: 1.week.from_now.to_date, datetime: 1.week.from_now.to_datetime,
                                decimal: 1.1, float: 1.1, time: 1.hour.ago.to_time.to_s[12..-1],
                                assoc: FactoryGirl.create(:assoc, string: 'rZ', integer: 9))
    @foo_8 = FactoryGirl.create(:foo, string: 'Z', integer: 2, boolean: false,
                                date: 1.week.ago.to_date, datetime: 1.week.ago.to_datetime,
                                decimal: 2.2, float: 2.2, time: 2.hours.ago.to_time.to_s[12..-1],
                                assoc: FactoryGirl.create(:assoc, string: 'rZ', integer: 8))
    @active_set = ActiveSet.new(Foo.all)
    @all_foos = Foo.all.to_a
  end
  after(:all) { Foo.delete_all }

  describe '#sort' do
    let(:result) { @active_set.sort(instructions) }

    context 'with BINARY type' do
      context '{ binary: :asc }' do
        let(:instructions) do
          { 'binary': :asc }
        end

        it { expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort! }
      end

      context '{ computed_binary: :asc }' do
        let(:instructions) do
          { 'computed_binary': :asc }
        end

        it { expect(result.map(&:computed_binary)).to eq @all_foos.map(&:computed_binary).sort! }
      end

      context '{ binary: :desc }' do
        let(:instructions) do
          { 'binary': :desc }
        end

        it { expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!.reverse! }
      end

      context '{ computed_binary: :desc }' do
        let(:instructions) do
          { 'computed_binary': :desc }
        end

        it { expect(result.map(&:computed_binary)).to eq @all_foos.map(&:computed_binary).sort!.reverse! }
      end

      context '{ assoc: { binary: :asc } }' do
        let(:instructions) do
          { assoc: { 'binary': :asc } }
        end

        it { expect(result.map { |x| x.assoc&.binary }).to eq @all_foos.map { |x| x.assoc&.binary }.sort! }
      end

      context '{ assoc: { computed_binary: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_binary': :asc } }
        end

        it { expect(result.map { |x| x.assoc&.computed_binary }).to eq @all_foos.map { |x| x.assoc&.computed_binary }.sort! }
      end

      context '{ assoc: { binary: :desc } }' do
        let(:instructions) do
          { assoc: { 'binary': :desc } }
        end

        it { expect(result.map { |x| x.assoc&.binary }).to eq @all_foos.map { |x| x.assoc&.binary }.sort!.reverse! }
      end

      context '{ assoc: { computed_binary: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_binary': :desc } }
        end

        it { expect(result.map { |x| x.assoc&.computed_binary }).to eq @all_foos.map { |x| x.assoc&.computed_binary }.sort!.reverse! }
      end
    end

    context 'with BOOLEAN type' do
      context '{ boolean: :asc }' do
        let(:instructions) do
          { 'boolean': :asc }
        end

        it { expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 } }
      end

      context '{ computed_boolean: :asc }' do
        let(:instructions) do
          { 'computed_boolean': :asc }
        end

        it { expect(result.map(&:computed_boolean)).to eq @all_foos.map(&:computed_boolean).sort_by { |bool| bool ? 1 : 0 } }
      end

      context '{ boolean: :desc }' do
        let(:instructions) do
          { 'boolean': :desc }
        end

        it { expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }.reverse! }
      end

      context '{ computed_boolean: :desc }' do
        let(:instructions) do
          { 'computed_boolean': :desc }
        end

        it { expect(result.map(&:computed_boolean)).to eq @all_foos.map(&:computed_boolean).sort_by { |bool| bool ? 1 : 0 }.reverse! }
      end

      context '{ assoc: { boolean: :asc } }' do
        let(:instructions) do
          { assoc: { 'boolean': :asc } }
        end

        it { expect(result.map { |x| x.assoc&.boolean }).to eq @all_foos.map { |x| x.assoc&.boolean }.sort_by { |bool| bool ? 1 : 0 } }
      end

      context '{ assoc: { computed_boolean: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_boolean': :asc } }
        end

        it { expect(result.map { |x| x.assoc&.computed_boolean }).to eq @all_foos.map { |x| x.assoc&.computed_boolean }.sort_by { |bool| bool ? 1 : 0 } }
      end

      context '{ assoc: { boolean: :desc } }' do
        let(:instructions) do
          { assoc: { 'boolean': :desc } }
        end

        it { expect(result.map { |x| x.assoc&.boolean }).to eq @all_foos.map { |x| x.assoc&.boolean }.sort_by { |bool| bool ? 1 : 0 }.reverse! }
      end

      context '{ assoc: { computed_boolean: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_boolean': :desc } }
        end

        it { expect(result.map { |x| x.assoc&.computed_boolean }).to eq @all_foos.map { |x| x.assoc&.computed_boolean }.sort_by { |bool| bool ? 1 : 0 }.reverse! }
      end
    end

    context 'with DATE type' do
      context '{ date: :asc }' do
        let(:instructions) do
          { 'date': :asc }
        end

        it { expect(result.map(&:date)).to eq @all_foos.map(&:date).sort! }
      end

      context '{ computed_date: :asc }' do
        let(:instructions) do
          { 'computed_date': :asc }
        end

        it { expect(result.map(&:computed_date)).to eq @all_foos.map(&:computed_date).sort! }
      end

      context '{ date: :desc }' do
        let(:instructions) do
          { 'date': :desc }
        end

        it { expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!.reverse! }
      end

      context '{ computed_date: :desc }' do
        let(:instructions) do
          { 'computed_date': :desc }
        end

        it { expect(result.map(&:computed_date)).to eq @all_foos.map(&:computed_date).sort!.reverse! }
      end

      context '{ assoc: { date: :asc } }' do
        let(:instructions) do
          { assoc: { 'date': :asc } }
        end

        it { expect(result.map { |x| x.assoc&.date }).to eq @all_foos.map { |x| x.assoc&.date }.sort! }
      end

      context '{ assoc: { computed_date: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_date': :asc } }
        end

        it { expect(result.map { |x| x.assoc&.computed_date }).to eq @all_foos.map { |x| x.assoc&.computed_date }.sort! }
      end

      context '{ assoc: { date: :desc } }' do
        let(:instructions) do
          { assoc: { 'date': :desc } }
        end

        it { expect(result.map { |x| x.assoc&.date }).to eq @all_foos.map { |x| x.assoc&.date }.sort!.reverse! }
      end

      context '{ assoc: { computed_date: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_date': :desc } }
        end

        it { expect(result.map { |x| x.assoc&.computed_date }).to eq @all_foos.map { |x| x.assoc&.computed_date }.sort!.reverse! }
      end
    end

    context 'with DATETIME type' do
      context '{ datetime: :asc }' do
        let(:instructions) do
          { 'datetime': :asc }
        end

        it { expect(result.map(&:datetime)).to eq @all_foos.map(&:datetime).sort! }
      end

      context '{ computed_datetime: :asc }' do
        let(:instructions) do
          { 'computed_datetime': :asc }
        end

        it { expect(result.map(&:computed_datetime)).to eq @all_foos.map(&:computed_datetime).sort! }
      end

      context '{ datetime: :desc }' do
        let(:instructions) do
          { 'datetime': :desc }
        end

        it { expect(result.map(&:datetime)).to eq @all_foos.map(&:datetime).sort!.reverse! }
      end

      context '{ computed_datetime: :desc }' do
        let(:instructions) do
          { 'computed_datetime': :desc }
        end

        it { expect(result.map(&:computed_datetime)).to eq @all_foos.map(&:computed_datetime).sort!.reverse! }
      end

      context '{ assoc: { datetime: :asc } }' do
        let(:instructions) do
          { assoc: { 'datetime': :asc } }
        end

        it { expect(result.map { |x| x.assoc&.datetime }).to eq @all_foos.map { |x| x.assoc&.datetime }.sort! }
      end

      context '{ assoc: { computed_datetime: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_datetime': :asc } }
        end

        it { expect(result.map { |x| x.assoc&.computed_datetime }).to eq @all_foos.map { |x| x.assoc&.computed_datetime }.sort! }
      end

      context '{ assoc: { datetime: :desc } }' do
        let(:instructions) do
          { assoc: { 'datetime': :desc } }
        end

        it { expect(result.map { |x| x.assoc&.datetime }).to eq @all_foos.map { |x| x.assoc&.datetime }.sort!.reverse! }
      end

      context '{ assoc: { computed_datetime: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_datetime': :desc } }
        end

        it { expect(result.map { |x| x.assoc&.computed_datetime }).to eq @all_foos.map { |x| x.assoc&.computed_datetime }.sort!.reverse! }
      end
    end

    context 'with DECIMAL type' do
      context '{ decimal: :asc }' do
        let(:instructions) do
          { 'decimal': :asc }
        end

        it { expect(result.map(&:decimal)).to eq @all_foos.map(&:decimal).sort! }
      end

      context '{ computed_decimal: :asc }' do
        let(:instructions) do
          { 'computed_decimal': :asc }
        end

        it { expect(result.map(&:computed_decimal)).to eq @all_foos.map(&:computed_decimal).sort! }
      end

      context '{ decimal: :desc }' do
        let(:instructions) do
          { 'decimal': :desc }
        end

        it { expect(result.map(&:decimal)).to eq @all_foos.map(&:decimal).sort!.reverse! }
      end

      context '{ computed_decimal: :desc }' do
        let(:instructions) do
          { 'computed_decimal': :desc }
        end

        it { expect(result.map(&:computed_decimal)).to eq @all_foos.map(&:computed_decimal).sort!.reverse! }
      end

      context '{ assoc: { decimal: :asc } }' do
        let(:instructions) do
          { assoc: { 'decimal': :asc } }
        end

        it { expect(result.map { |x| x.assoc&.decimal }).to eq @all_foos.map { |x| x.assoc&.decimal }.sort! }
      end

      context '{ assoc: { computed_decimal: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_decimal': :asc } }
        end

        it { expect(result.map { |x| x.assoc&.computed_decimal }).to eq @all_foos.map { |x| x.assoc&.computed_decimal }.sort! }
      end

      context '{ assoc: { decimal: :desc } }' do
        let(:instructions) do
          { assoc: { 'decimal': :desc } }
        end

        it { expect(result.map { |x| x.assoc&.decimal }).to eq @all_foos.map { |x| x.assoc&.decimal }.sort!.reverse! }
      end

      context '{ assoc: { computed_decimal: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_decimal': :desc } }
        end

        it { expect(result.map { |x| x.assoc&.computed_decimal }).to eq @all_foos.map { |x| x.assoc&.computed_decimal }.sort!.reverse! }
      end
    end

    context 'with FLOAT type' do
      context '{ float: :asc }' do
        let(:instructions) do
          { 'float': :asc }
        end

        it { expect(result.map(&:float)).to eq @all_foos.map(&:float).sort! }
      end

      context '{ computed_float: :asc }' do
        let(:instructions) do
          { 'computed_float': :asc }
        end

        it { expect(result.map(&:computed_float)).to eq @all_foos.map(&:computed_float).sort! }
      end

      context '{ float: :desc }' do
        let(:instructions) do
          { 'float': :desc }
        end

        it { expect(result.map(&:float)).to eq @all_foos.map(&:float).sort!.reverse! }
      end

      context '{ computed_float: :desc }' do
        let(:instructions) do
          { 'computed_float': :desc }
        end

        it { expect(result.map(&:computed_float)).to eq @all_foos.map(&:computed_float).sort!.reverse! }
      end

      context '{ assoc: { float: :asc } }' do
        let(:instructions) do
          { assoc: { 'float': :asc } }
        end

        it { expect(result.map { |x| x.assoc&.float }).to eq @all_foos.map { |x| x.assoc&.float }.sort! }
      end

      context '{ assoc: { computed_float: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_float': :asc } }
        end

        it { expect(result.map { |x| x.assoc&.computed_float }).to eq @all_foos.map { |x| x.assoc&.computed_float }.sort! }
      end

      context '{ assoc: { float: :desc } }' do
        let(:instructions) do
          { assoc: { 'float': :desc } }
        end

        it { expect(result.map { |x| x.assoc&.float }).to eq @all_foos.map { |x| x.assoc&.float }.sort!.reverse! }
      end

      context '{ assoc: { computed_float: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_float': :desc } }
        end

        it { expect(result.map { |x| x.assoc&.computed_float }).to eq @all_foos.map { |x| x.assoc&.computed_float }.sort!.reverse! }
      end
    end

    context 'with INTEGER type' do
      context '{ integer: :asc }' do
        let(:instructions) do
          { 'integer': :asc }
        end

        it { expect(result.map(&:integer)).to eq @all_foos.map(&:integer).sort! }
      end

      context '{ computed_integer: :asc }' do
        let(:instructions) do
          { 'computed_integer': :asc }
        end

        it { expect(result.map(&:computed_integer)).to eq @all_foos.map(&:computed_integer).sort! }
      end

      context '{ integer: :desc }' do
        let(:instructions) do
          { 'integer': :desc }
        end

        it { expect(result.map(&:integer)).to eq @all_foos.map(&:integer).sort!.reverse! }
      end

      context '{ computed_integer: :desc }' do
        let(:instructions) do
          { 'computed_integer': :desc }
        end

        it { expect(result.map(&:computed_integer)).to eq @all_foos.map(&:computed_integer).sort!.reverse! }
      end

      context '{ assoc: { integer: :asc } }' do
        let(:instructions) do
          { assoc: { 'integer': :asc } }
        end

        it { expect(result.map { |x| x.assoc&.integer }).to eq @all_foos.map { |x| x.assoc&.integer }.sort! }
      end

      context '{ assoc: { computed_integer: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_integer': :asc } }
        end

        it { expect(result.map { |x| x.assoc&.computed_integer }).to eq @all_foos.map { |x| x.assoc&.computed_integer }.sort! }
      end

      context '{ assoc: { integer: :desc } }' do
        let(:instructions) do
          { assoc: { 'integer': :desc } }
        end

        it { expect(result.map { |x| x.assoc&.integer }).to eq @all_foos.map { |x| x.assoc&.integer }.sort!.reverse! }
      end

      context '{ assoc: { computed_integer: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_integer': :desc } }
        end

        it { expect(result.map { |x| x.assoc&.computed_integer }).to eq @all_foos.map { |x| x.assoc&.computed_integer }.sort!.reverse! }
      end
    end

    context 'with STRING type' do
      context '{ string: :asc }' do
        let(:instructions) do
          { 'string': :asc }
        end

        it { expect(result.map(&:string)).to eq @all_foos.map(&:string).sort! }
      end

      context '{ computed_string: :asc }' do
        let(:instructions) do
          { 'computed_string': :asc }
        end

        it { expect(result.map(&:computed_string)).to eq @all_foos.map(&:computed_string).sort! }
      end

      context '{ string: :desc }' do
        let(:instructions) do
          { 'string': :desc }
        end

        it { expect(result.map(&:string)).to eq @all_foos.map(&:string).sort!.reverse! }
      end

      context '{ computed_string: :desc }' do
        let(:instructions) do
          { 'computed_string': :desc }
        end

        it { expect(result.map(&:computed_string)).to eq @all_foos.map(&:computed_string).sort!.reverse! }
      end

      context '{ assoc: { string: :asc } }' do
        let(:instructions) do
          { assoc: { 'string': :asc } }
        end

        it { expect(result.map { |x| x.assoc&.string }).to eq @all_foos.map { |x| x.assoc&.string }.sort! }
      end

      context '{ assoc: { computed_string: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_string': :asc } }
        end

        it { expect(result.map { |x| x.assoc&.computed_string }).to eq @all_foos.map { |x| x.assoc&.computed_string }.sort! }
      end

      context '{ assoc: { string: :desc } }' do
        let(:instructions) do
          { assoc: { 'string': :desc } }
        end

        it { expect(result.map { |x| x.assoc&.string }).to eq @all_foos.map { |x| x.assoc&.string }.sort!.reverse! }
      end

      context '{ assoc: { computed_string: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_string': :desc } }
        end

        it { expect(result.map { |x| x.assoc&.computed_string }).to eq @all_foos.map { |x| x.assoc&.computed_string }.sort!.reverse! }
      end
    end

    context 'with TEXT type' do
      context '{ text: :asc }' do
        let(:instructions) do
          { 'text': :asc }
        end

        it { expect(result.map(&:text)).to eq @all_foos.map(&:text).sort! }
      end

      context '{ computed_text: :asc }' do
        let(:instructions) do
          { 'computed_text': :asc }
        end

        it { expect(result.map(&:computed_text)).to eq @all_foos.map(&:computed_text).sort! }
      end

      context '{ text: :desc }' do
        let(:instructions) do
          { 'text': :desc }
        end

        it { expect(result.map(&:text)).to eq @all_foos.map(&:text).sort!.reverse! }
      end

      context '{ computed_text: :desc }' do
        let(:instructions) do
          { 'computed_text': :desc }
        end

        it { expect(result.map(&:computed_text)).to eq @all_foos.map(&:computed_text).sort!.reverse! }
      end

      context '{ assoc: { text: :asc } }' do
        let(:instructions) do
          { assoc: { 'text': :asc } }
        end

        it { expect(result.map { |x| x.assoc&.text }).to eq @all_foos.map { |x| x.assoc&.text }.sort! }
      end

      context '{ assoc: { computed_text: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_text': :asc } }
        end

        it { expect(result.map { |x| x.assoc&.computed_text }).to eq @all_foos.map { |x| x.assoc&.computed_text }.sort! }
      end

      context '{ assoc: { text: :desc } }' do
        let(:instructions) do
          { assoc: { 'text': :desc } }
        end

        it { expect(result.map { |x| x.assoc&.text }).to eq @all_foos.map { |x| x.assoc&.text }.sort!.reverse! }
      end

      context '{ assoc: { computed_text: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_text': :desc } }
        end

        it { expect(result.map { |x| x.assoc&.computed_text }).to eq @all_foos.map { |x| x.assoc&.computed_text }.sort!.reverse! }
      end
    end

    context 'with TIME type' do
      context '{ time: :asc }' do
        let(:instructions) do
          { 'time': :asc }
        end

        it { expect(result.map(&:time)).to eq @all_foos.map(&:time).sort! }
      end

      context '{ computed_time: :asc }' do
        let(:instructions) do
          { 'computed_time': :asc }
        end

        it { expect(result.map(&:computed_time)).to eq @all_foos.map(&:computed_time).sort! }
      end

      context '{ time: :desc }' do
        let(:instructions) do
          { 'time': :desc }
        end

        it { expect(result.map(&:time)).to eq @all_foos.map(&:time).sort!.reverse! }
      end

      context '{ computed_time: :desc }' do
        let(:instructions) do
          { 'computed_time': :desc }
        end

        it { expect(result.map(&:computed_time)).to eq @all_foos.map(&:computed_time).sort!.reverse! }
      end

      context '{ assoc: { time: :asc } }' do
        let(:instructions) do
          { assoc: { 'time': :asc } }
        end

        it { expect(result.map { |x| x.assoc&.time }).to eq @all_foos.map { |x| x.assoc&.time }.sort! }
      end

      context '{ assoc: { computed_time: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_time': :asc } }
        end

        it { expect(result.map { |x| x.assoc&.computed_time }).to eq @all_foos.map { |x| x.assoc&.computed_time }.sort! }
      end

      context '{ assoc: { time: :desc } }' do
        let(:instructions) do
          { assoc: { 'time': :desc } }
        end

        it { expect(result.map { |x| x.assoc&.time }).to eq @all_foos.map { |x| x.assoc&.time }.sort!.reverse! }
      end

      context '{ assoc: { computed_time: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_time': :desc } }
        end

        it { expect(result.map { |x| x.assoc&.computed_time }).to eq @all_foos.map { |x| x.assoc&.computed_time }.sort!.reverse! }
      end
    end

    # --------------------------------------------------------------------------
    attribute_types = %i[binary boolean date datetime decimal float integer string text time]

    context 'with BINARY and DATE type' do
      context '{ binary: :asc, date: :asc }' do
        let(:instructions) do
          { 'binary': :asc, 'date': :asc }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.date).to be <= right_result.date
            end
          end
        end
      end

      context '{ binary: :desc, date: :desc }' do
        let(:instructions) do
          { 'binary': :desc, 'date': :desc }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.date).to be >= right_result.date
            end
          end
        end
      end

      context '{ binary: :asc, date: :desc }' do
        let(:instructions) do
          { 'binary': :asc, 'date': :desc }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.date).to be >= right_result.date
            end
          end
        end
      end

      context '{ binary: :desc, date: :asc }' do
        let(:instructions) do
          { 'binary': :desc, 'date': :asc }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.date).to be <= right_result.date
            end
          end
        end
      end


      context '{ computed_binary: :asc, computed_date: :asc }' do
        let(:instructions) do
          { 'computed_binary': :asc, 'computed_date': :asc }
        end

        it do
          expect(result.map(&:computed_binary)).to eq @all_foos.map(&:computed_binary).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_binary == right_result.computed_binary
              expect(left_result.computed_date).to be <= right_result.computed_date
            end
          end
        end
      end

      context '{ binary: :desc, computed_date: :desc }' do
        let(:instructions) do
          { 'binary': :desc, 'computed_date': :desc }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.computed_date).to be >= right_result.computed_date
            end
          end
        end
      end

      context '{ computed_binary: :asc, date: :desc }' do
        let(:instructions) do
          { 'computed_binary': :asc, 'date': :desc }
        end

        it do
          expect(result.map(&:computed_binary)).to eq @all_foos.map(&:computed_binary).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_binary == right_result.computed_binary
              expect(left_result.date).to be >= right_result.date
            end
          end
        end
      end

      context '{ assoc: { binary: :desc, date: :asc } }' do
        let(:instructions) do
          { assoc: { 'binary': :desc, 'date': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.binary }).to eq @all_foos.map { |x| x.assoc&.binary }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.binary == right_result.assoc.binary
              expect(left_result.assoc.date).to be <= right_result.assoc.date
            end
          end
        end
      end

      context '{ assoc: { computed_binary: :asc, computed_date: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_binary': :asc, 'computed_date': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_binary }).to eq @all_foos.map { |x| x.assoc&.computed_binary }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_binary == right_result.assoc.computed_binary
              expect(left_result.assoc.computed_date).to be <= right_result.assoc.computed_date
            end
          end
        end
      end

      context '{ assoc: { binary: :desc, computed_date: :desc } }' do
        let(:instructions) do
          { assoc: { 'binary': :desc, 'computed_date': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.binary }).to eq @all_foos.map { |x| x.assoc&.binary }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.binary == right_result.assoc.binary
              expect(left_result.assoc.computed_date).to be >= right_result.assoc.computed_date
            end
          end
        end
      end

      context '{ assoc: { computed_binary: :asc, date: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_binary': :asc, 'date': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_binary }).to eq @all_foos.map { |x| x.assoc&.computed_binary }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_binary == right_result.assoc.computed_binary
              expect(left_result.assoc.date).to be >= right_result.assoc.date
            end
          end
        end
      end

      context '{ binary: :desc, assoc: { date: :asc } }' do
        let(:instructions) do
          { 'binary': :desc, assoc: { 'date': :asc } }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.assoc.date).to be <= right_result.assoc.date
            end
          end
        end
      end

      context '{ computed_binary: :asc, assoc: { date: :asc } }' do
        let(:instructions) do
          { 'computed_binary': :asc, assoc: { 'date': :asc } }
        end

        it do
          expect(result.map(&:computed_binary)).to eq @all_foos.map(&:computed_binary).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_binary == right_result.computed_binary
              expect(left_result.assoc.date).to be <= right_result.assoc.date
            end
          end
        end
      end

      context '{ binary: :desc, assoc: { computed_date: :desc } }' do
        let(:instructions) do
          { 'binary': :desc, assoc: { 'computed_date': :desc } }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.assoc.computed_date).to be >= right_result.assoc.computed_date
            end
          end
        end
      end

      context '{ computed_binary: :asc, assoc: { computed_date: :desc } }' do
        let(:instructions) do
          { 'computed_binary': :asc, assoc: { 'computed_date': :desc } }
        end

        it do
          expect(result.map(&:computed_binary)).to eq @all_foos.map(&:computed_binary).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_binary == right_result.computed_binary
              expect(left_result.assoc.computed_date).to be >= right_result.assoc.computed_date
            end
          end
        end
      end

      context '{ assoc: { binary: :desc }, date: :asc }' do
        let(:instructions) do
          { assoc: { 'binary': :desc }, 'date': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.binary }).to eq @all_foos.map { |x| x.assoc&.binary }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.binary == right_result.assoc.binary
              expect(left_result.date).to be <= right_result.date
            end
          end
        end
      end

      context '{ assoc: { computed_binary: :asc }, computed_date: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_binary': :asc }, 'computed_date': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_binary }).to eq @all_foos.map { |x| x.assoc&.computed_binary }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_binary == right_result.assoc.computed_binary
              expect(left_result.computed_date).to be <= right_result.computed_date
            end
          end
        end
      end

      context '{ assoc: { binary: :asc }, computed_date: :desc }' do
        let(:instructions) do
          { assoc: { 'binary': :asc }, 'computed_date': :desc }
        end

        it do
          expect(result.map { |x| x.assoc&.binary }).to eq @all_foos.map { |x| x.assoc&.binary }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.binary == right_result.assoc.binary
              expect(left_result.computed_date).to be >= right_result.computed_date
            end
          end
        end
      end

      context '{ assoc: { computed_binary: :desc }, date: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_binary': :desc }, 'date': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_binary }).to eq @all_foos.map { |x| x.assoc&.computed_binary }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_binary == right_result.assoc.computed_binary
              expect(left_result.date).to be <= right_result.date
            end
          end
        end
      end
    end

    context 'with BINARY and DATETIME type' do
      context '{ binary: :asc, datetime: :asc }' do
        let(:instructions) do
          { 'binary': :asc, 'datetime': :asc }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.datetime).to be <= right_result.datetime
            end
          end
        end
      end

      context '{ binary: :desc, datetime: :desc }' do
        let(:instructions) do
          { 'binary': :desc, 'datetime': :desc }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.datetime).to be >= right_result.datetime
            end
          end
        end
      end

      context '{ binary: :asc, datetime: :desc }' do
        let(:instructions) do
          { 'binary': :asc, 'datetime': :desc }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.datetime).to be >= right_result.datetime
            end
          end
        end
      end

      context '{ binary: :desc, datetime: :asc }' do
        let(:instructions) do
          { 'binary': :desc, 'datetime': :asc }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.datetime).to be <= right_result.datetime
            end
          end
        end
      end


      context '{ computed_binary: :asc, computed_datetime: :asc }' do
        let(:instructions) do
          { 'computed_binary': :asc, 'computed_datetime': :asc }
        end

        it do
          expect(result.map(&:computed_binary)).to eq @all_foos.map(&:computed_binary).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_binary == right_result.computed_binary
              expect(left_result.computed_datetime).to be <= right_result.computed_datetime
            end
          end
        end
      end

      context '{ binary: :desc, computed_datetime: :desc }' do
        let(:instructions) do
          { 'binary': :desc, 'computed_datetime': :desc }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.computed_datetime).to be >= right_result.computed_datetime
            end
          end
        end
      end

      context '{ computed_binary: :asc, datetime: :desc }' do
        let(:instructions) do
          { 'computed_binary': :asc, 'datetime': :desc }
        end

        it do
          expect(result.map(&:computed_binary)).to eq @all_foos.map(&:computed_binary).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_binary == right_result.computed_binary
              expect(left_result.datetime).to be >= right_result.datetime
            end
          end
        end
      end

      context '{ assoc: { binary: :desc, datetime: :asc } }' do
        let(:instructions) do
          { assoc: { 'binary': :desc, 'datetime': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.binary }).to eq @all_foos.map { |x| x.assoc&.binary }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.binary == right_result.assoc.binary
              expect(left_result.assoc.datetime).to be <= right_result.assoc.datetime
            end
          end
        end
      end

      context '{ assoc: { computed_binary: :asc, computed_datetime: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_binary': :asc, 'computed_datetime': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_binary }).to eq @all_foos.map { |x| x.assoc&.computed_binary }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_binary == right_result.assoc.computed_binary
              expect(left_result.assoc.computed_datetime).to be <= right_result.assoc.computed_datetime
            end
          end
        end
      end

      context '{ assoc: { binary: :desc, computed_datetime: :desc } }' do
        let(:instructions) do
          { assoc: { 'binary': :desc, 'computed_datetime': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.binary }).to eq @all_foos.map { |x| x.assoc&.binary }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.binary == right_result.assoc.binary
              expect(left_result.assoc.computed_datetime).to be >= right_result.assoc.computed_datetime
            end
          end
        end
      end

      context '{ assoc: { computed_binary: :asc, datetime: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_binary': :asc, 'datetime': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_binary }).to eq @all_foos.map { |x| x.assoc&.computed_binary }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_binary == right_result.assoc.computed_binary
              expect(left_result.assoc.datetime).to be >= right_result.assoc.datetime
            end
          end
        end
      end

      context '{ binary: :desc, assoc: { datetime: :asc } }' do
        let(:instructions) do
          { 'binary': :desc, assoc: { 'datetime': :asc } }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.assoc.datetime).to be <= right_result.assoc.datetime
            end
          end
        end
      end

      context '{ computed_binary: :asc, assoc: { datetime: :asc } }' do
        let(:instructions) do
          { 'computed_binary': :asc, assoc: { 'datetime': :asc } }
        end

        it do
          expect(result.map(&:computed_binary)).to eq @all_foos.map(&:computed_binary).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_binary == right_result.computed_binary
              expect(left_result.assoc.datetime).to be <= right_result.assoc.datetime
            end
          end
        end
      end

      context '{ binary: :desc, assoc: { computed_datetime: :desc } }' do
        let(:instructions) do
          { 'binary': :desc, assoc: { 'computed_datetime': :desc } }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.assoc.computed_datetime).to be >= right_result.assoc.computed_datetime
            end
          end
        end
      end

      context '{ computed_binary: :asc, assoc: { computed_datetime: :desc } }' do
        let(:instructions) do
          { 'computed_binary': :asc, assoc: { 'computed_datetime': :desc } }
        end

        it do
          expect(result.map(&:computed_binary)).to eq @all_foos.map(&:computed_binary).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_binary == right_result.computed_binary
              expect(left_result.assoc.computed_datetime).to be >= right_result.assoc.computed_datetime
            end
          end
        end
      end

      context '{ assoc: { binary: :desc }, datetime: :asc }' do
        let(:instructions) do
          { assoc: { 'binary': :desc }, 'datetime': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.binary }).to eq @all_foos.map { |x| x.assoc&.binary }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.binary == right_result.assoc.binary
              expect(left_result.datetime).to be <= right_result.datetime
            end
          end
        end
      end

      context '{ assoc: { computed_binary: :asc }, computed_datetime: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_binary': :asc }, 'computed_datetime': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_binary }).to eq @all_foos.map { |x| x.assoc&.computed_binary }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_binary == right_result.assoc.computed_binary
              expect(left_result.computed_datetime).to be <= right_result.computed_datetime
            end
          end
        end
      end

      context '{ assoc: { binary: :asc }, computed_datetime: :desc }' do
        let(:instructions) do
          { assoc: { 'binary': :asc }, 'computed_datetime': :desc }
        end

        it do
          expect(result.map { |x| x.assoc&.binary }).to eq @all_foos.map { |x| x.assoc&.binary }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.binary == right_result.assoc.binary
              expect(left_result.computed_datetime).to be >= right_result.computed_datetime
            end
          end
        end
      end

      context '{ assoc: { computed_binary: :desc }, datetime: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_binary': :desc }, 'datetime': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_binary }).to eq @all_foos.map { |x| x.assoc&.computed_binary }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_binary == right_result.assoc.computed_binary
              expect(left_result.datetime).to be <= right_result.datetime
            end
          end
        end
      end
    end

    context 'with BINARY and DECIMAL type' do
      context '{ binary: :asc, decimal: :asc }' do
        let(:instructions) do
          { 'binary': :asc, 'decimal': :asc }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.decimal).to be <= right_result.decimal
            end
          end
        end
      end

      context '{ binary: :desc, decimal: :desc }' do
        let(:instructions) do
          { 'binary': :desc, 'decimal': :desc }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.decimal).to be >= right_result.decimal
            end
          end
        end
      end

      context '{ binary: :asc, decimal: :desc }' do
        let(:instructions) do
          { 'binary': :asc, 'decimal': :desc }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.decimal).to be >= right_result.decimal
            end
          end
        end
      end

      context '{ binary: :desc, decimal: :asc }' do
        let(:instructions) do
          { 'binary': :desc, 'decimal': :asc }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.decimal).to be <= right_result.decimal
            end
          end
        end
      end


      context '{ computed_binary: :asc, computed_decimal: :asc }' do
        let(:instructions) do
          { 'computed_binary': :asc, 'computed_decimal': :asc }
        end

        it do
          expect(result.map(&:computed_binary)).to eq @all_foos.map(&:computed_binary).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_binary == right_result.computed_binary
              expect(left_result.computed_decimal).to be <= right_result.computed_decimal
            end
          end
        end
      end

      context '{ binary: :desc, computed_decimal: :desc }' do
        let(:instructions) do
          { 'binary': :desc, 'computed_decimal': :desc }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.computed_decimal).to be >= right_result.computed_decimal
            end
          end
        end
      end

      context '{ computed_binary: :asc, decimal: :desc }' do
        let(:instructions) do
          { 'computed_binary': :asc, 'decimal': :desc }
        end

        it do
          expect(result.map(&:computed_binary)).to eq @all_foos.map(&:computed_binary).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_binary == right_result.computed_binary
              expect(left_result.decimal).to be >= right_result.decimal
            end
          end
        end
      end

      context '{ assoc: { binary: :desc, decimal: :asc } }' do
        let(:instructions) do
          { assoc: { 'binary': :desc, 'decimal': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.binary }).to eq @all_foos.map { |x| x.assoc&.binary }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.binary == right_result.assoc.binary
              expect(left_result.assoc.decimal).to be <= right_result.assoc.decimal
            end
          end
        end
      end

      context '{ assoc: { computed_binary: :asc, computed_decimal: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_binary': :asc, 'computed_decimal': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_binary }).to eq @all_foos.map { |x| x.assoc&.computed_binary }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_binary == right_result.assoc.computed_binary
              expect(left_result.assoc.computed_decimal).to be <= right_result.assoc.computed_decimal
            end
          end
        end
      end

      context '{ assoc: { binary: :desc, computed_decimal: :desc } }' do
        let(:instructions) do
          { assoc: { 'binary': :desc, 'computed_decimal': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.binary }).to eq @all_foos.map { |x| x.assoc&.binary }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.binary == right_result.assoc.binary
              expect(left_result.assoc.computed_decimal).to be >= right_result.assoc.computed_decimal
            end
          end
        end
      end

      context '{ assoc: { computed_binary: :asc, decimal: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_binary': :asc, 'decimal': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_binary }).to eq @all_foos.map { |x| x.assoc&.computed_binary }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_binary == right_result.assoc.computed_binary
              expect(left_result.assoc.decimal).to be >= right_result.assoc.decimal
            end
          end
        end
      end

      context '{ binary: :desc, assoc: { decimal: :asc } }' do
        let(:instructions) do
          { 'binary': :desc, assoc: { 'decimal': :asc } }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.assoc.decimal).to be <= right_result.assoc.decimal
            end
          end
        end
      end

      context '{ computed_binary: :asc, assoc: { decimal: :asc } }' do
        let(:instructions) do
          { 'computed_binary': :asc, assoc: { 'decimal': :asc } }
        end

        it do
          expect(result.map(&:computed_binary)).to eq @all_foos.map(&:computed_binary).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_binary == right_result.computed_binary
              expect(left_result.assoc.decimal).to be <= right_result.assoc.decimal
            end
          end
        end
      end

      context '{ binary: :desc, assoc: { computed_decimal: :desc } }' do
        let(:instructions) do
          { 'binary': :desc, assoc: { 'computed_decimal': :desc } }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.assoc.computed_decimal).to be >= right_result.assoc.computed_decimal
            end
          end
        end
      end

      context '{ computed_binary: :asc, assoc: { computed_decimal: :desc } }' do
        let(:instructions) do
          { 'computed_binary': :asc, assoc: { 'computed_decimal': :desc } }
        end

        it do
          expect(result.map(&:computed_binary)).to eq @all_foos.map(&:computed_binary).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_binary == right_result.computed_binary
              expect(left_result.assoc.computed_decimal).to be >= right_result.assoc.computed_decimal
            end
          end
        end
      end

      context '{ assoc: { binary: :desc }, decimal: :asc }' do
        let(:instructions) do
          { assoc: { 'binary': :desc }, 'decimal': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.binary }).to eq @all_foos.map { |x| x.assoc&.binary }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.binary == right_result.assoc.binary
              expect(left_result.decimal).to be <= right_result.decimal
            end
          end
        end
      end

      context '{ assoc: { computed_binary: :asc }, computed_decimal: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_binary': :asc }, 'computed_decimal': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_binary }).to eq @all_foos.map { |x| x.assoc&.computed_binary }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_binary == right_result.assoc.computed_binary
              expect(left_result.computed_decimal).to be <= right_result.computed_decimal
            end
          end
        end
      end

      context '{ assoc: { binary: :asc }, computed_decimal: :desc }' do
        let(:instructions) do
          { assoc: { 'binary': :asc }, 'computed_decimal': :desc }
        end

        it do
          expect(result.map { |x| x.assoc&.binary }).to eq @all_foos.map { |x| x.assoc&.binary }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.binary == right_result.assoc.binary
              expect(left_result.computed_decimal).to be >= right_result.computed_decimal
            end
          end
        end
      end

      context '{ assoc: { computed_binary: :desc }, decimal: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_binary': :desc }, 'decimal': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_binary }).to eq @all_foos.map { |x| x.assoc&.computed_binary }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_binary == right_result.assoc.computed_binary
              expect(left_result.decimal).to be <= right_result.decimal
            end
          end
        end
      end
    end

    context 'with BINARY and FLOAT type' do
      context '{ binary: :asc, float: :asc }' do
        let(:instructions) do
          { 'binary': :asc, 'float': :asc }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.float).to be <= right_result.float
            end
          end
        end
      end

      context '{ binary: :desc, float: :desc }' do
        let(:instructions) do
          { 'binary': :desc, 'float': :desc }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.float).to be >= right_result.float
            end
          end
        end
      end

      context '{ binary: :asc, float: :desc }' do
        let(:instructions) do
          { 'binary': :asc, 'float': :desc }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.float).to be >= right_result.float
            end
          end
        end
      end

      context '{ binary: :desc, float: :asc }' do
        let(:instructions) do
          { 'binary': :desc, 'float': :asc }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.float).to be <= right_result.float
            end
          end
        end
      end


      context '{ computed_binary: :asc, computed_float: :asc }' do
        let(:instructions) do
          { 'computed_binary': :asc, 'computed_float': :asc }
        end

        it do
          expect(result.map(&:computed_binary)).to eq @all_foos.map(&:computed_binary).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_binary == right_result.computed_binary
              expect(left_result.computed_float).to be <= right_result.computed_float
            end
          end
        end
      end

      context '{ binary: :desc, computed_float: :desc }' do
        let(:instructions) do
          { 'binary': :desc, 'computed_float': :desc }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.computed_float).to be >= right_result.computed_float
            end
          end
        end
      end

      context '{ computed_binary: :asc, float: :desc }' do
        let(:instructions) do
          { 'computed_binary': :asc, 'float': :desc }
        end

        it do
          expect(result.map(&:computed_binary)).to eq @all_foos.map(&:computed_binary).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_binary == right_result.computed_binary
              expect(left_result.float).to be >= right_result.float
            end
          end
        end
      end

      context '{ assoc: { binary: :desc, float: :asc } }' do
        let(:instructions) do
          { assoc: { 'binary': :desc, 'float': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.binary }).to eq @all_foos.map { |x| x.assoc&.binary }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.binary == right_result.assoc.binary
              expect(left_result.assoc.float).to be <= right_result.assoc.float
            end
          end
        end
      end

      context '{ assoc: { computed_binary: :asc, computed_float: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_binary': :asc, 'computed_float': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_binary }).to eq @all_foos.map { |x| x.assoc&.computed_binary }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_binary == right_result.assoc.computed_binary
              expect(left_result.assoc.computed_float).to be <= right_result.assoc.computed_float
            end
          end
        end
      end

      context '{ assoc: { binary: :desc, computed_float: :desc } }' do
        let(:instructions) do
          { assoc: { 'binary': :desc, 'computed_float': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.binary }).to eq @all_foos.map { |x| x.assoc&.binary }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.binary == right_result.assoc.binary
              expect(left_result.assoc.computed_float).to be >= right_result.assoc.computed_float
            end
          end
        end
      end

      context '{ assoc: { computed_binary: :asc, float: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_binary': :asc, 'float': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_binary }).to eq @all_foos.map { |x| x.assoc&.computed_binary }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_binary == right_result.assoc.computed_binary
              expect(left_result.assoc.float).to be >= right_result.assoc.float
            end
          end
        end
      end

      context '{ binary: :desc, assoc: { float: :asc } }' do
        let(:instructions) do
          { 'binary': :desc, assoc: { 'float': :asc } }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.assoc.float).to be <= right_result.assoc.float
            end
          end
        end
      end

      context '{ computed_binary: :asc, assoc: { float: :asc } }' do
        let(:instructions) do
          { 'computed_binary': :asc, assoc: { 'float': :asc } }
        end

        it do
          expect(result.map(&:computed_binary)).to eq @all_foos.map(&:computed_binary).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_binary == right_result.computed_binary
              expect(left_result.assoc.float).to be <= right_result.assoc.float
            end
          end
        end
      end

      context '{ binary: :desc, assoc: { computed_float: :desc } }' do
        let(:instructions) do
          { 'binary': :desc, assoc: { 'computed_float': :desc } }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.assoc.computed_float).to be >= right_result.assoc.computed_float
            end
          end
        end
      end

      context '{ computed_binary: :asc, assoc: { computed_float: :desc } }' do
        let(:instructions) do
          { 'computed_binary': :asc, assoc: { 'computed_float': :desc } }
        end

        it do
          expect(result.map(&:computed_binary)).to eq @all_foos.map(&:computed_binary).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_binary == right_result.computed_binary
              expect(left_result.assoc.computed_float).to be >= right_result.assoc.computed_float
            end
          end
        end
      end

      context '{ assoc: { binary: :desc }, float: :asc }' do
        let(:instructions) do
          { assoc: { 'binary': :desc }, 'float': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.binary }).to eq @all_foos.map { |x| x.assoc&.binary }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.binary == right_result.assoc.binary
              expect(left_result.float).to be <= right_result.float
            end
          end
        end
      end

      context '{ assoc: { computed_binary: :asc }, computed_float: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_binary': :asc }, 'computed_float': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_binary }).to eq @all_foos.map { |x| x.assoc&.computed_binary }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_binary == right_result.assoc.computed_binary
              expect(left_result.computed_float).to be <= right_result.computed_float
            end
          end
        end
      end

      context '{ assoc: { binary: :asc }, computed_float: :desc }' do
        let(:instructions) do
          { assoc: { 'binary': :asc }, 'computed_float': :desc }
        end

        it do
          expect(result.map { |x| x.assoc&.binary }).to eq @all_foos.map { |x| x.assoc&.binary }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.binary == right_result.assoc.binary
              expect(left_result.computed_float).to be >= right_result.computed_float
            end
          end
        end
      end

      context '{ assoc: { computed_binary: :desc }, float: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_binary': :desc }, 'float': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_binary }).to eq @all_foos.map { |x| x.assoc&.computed_binary }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_binary == right_result.assoc.computed_binary
              expect(left_result.float).to be <= right_result.float
            end
          end
        end
      end
    end

    context 'with BINARY and INTEGER type' do
      context '{ binary: :asc, integer: :asc }' do
        let(:instructions) do
          { 'binary': :asc, 'integer': :asc }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.integer).to be <= right_result.integer
            end
          end
        end
      end

      context '{ binary: :desc, integer: :desc }' do
        let(:instructions) do
          { 'binary': :desc, 'integer': :desc }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.integer).to be >= right_result.integer
            end
          end
        end
      end

      context '{ binary: :asc, integer: :desc }' do
        let(:instructions) do
          { 'binary': :asc, 'integer': :desc }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.integer).to be >= right_result.integer
            end
          end
        end
      end

      context '{ binary: :desc, integer: :asc }' do
        let(:instructions) do
          { 'binary': :desc, 'integer': :asc }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.integer).to be <= right_result.integer
            end
          end
        end
      end


      context '{ computed_binary: :asc, computed_integer: :asc }' do
        let(:instructions) do
          { 'computed_binary': :asc, 'computed_integer': :asc }
        end

        it do
          expect(result.map(&:computed_binary)).to eq @all_foos.map(&:computed_binary).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_binary == right_result.computed_binary
              expect(left_result.computed_integer).to be <= right_result.computed_integer
            end
          end
        end
      end

      context '{ binary: :desc, computed_integer: :desc }' do
        let(:instructions) do
          { 'binary': :desc, 'computed_integer': :desc }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.computed_integer).to be >= right_result.computed_integer
            end
          end
        end
      end

      context '{ computed_binary: :asc, integer: :desc }' do
        let(:instructions) do
          { 'computed_binary': :asc, 'integer': :desc }
        end

        it do
          expect(result.map(&:computed_binary)).to eq @all_foos.map(&:computed_binary).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_binary == right_result.computed_binary
              expect(left_result.integer).to be >= right_result.integer
            end
          end
        end
      end

      context '{ assoc: { binary: :desc, integer: :asc } }' do
        let(:instructions) do
          { assoc: { 'binary': :desc, 'integer': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.binary }).to eq @all_foos.map { |x| x.assoc&.binary }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.binary == right_result.assoc.binary
              expect(left_result.assoc.integer).to be <= right_result.assoc.integer
            end
          end
        end
      end

      context '{ assoc: { computed_binary: :asc, computed_integer: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_binary': :asc, 'computed_integer': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_binary }).to eq @all_foos.map { |x| x.assoc&.computed_binary }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_binary == right_result.assoc.computed_binary
              expect(left_result.assoc.computed_integer).to be <= right_result.assoc.computed_integer
            end
          end
        end
      end

      context '{ assoc: { binary: :desc, computed_integer: :desc } }' do
        let(:instructions) do
          { assoc: { 'binary': :desc, 'computed_integer': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.binary }).to eq @all_foos.map { |x| x.assoc&.binary }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.binary == right_result.assoc.binary
              expect(left_result.assoc.computed_integer).to be >= right_result.assoc.computed_integer
            end
          end
        end
      end

      context '{ assoc: { computed_binary: :asc, integer: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_binary': :asc, 'integer': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_binary }).to eq @all_foos.map { |x| x.assoc&.computed_binary }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_binary == right_result.assoc.computed_binary
              expect(left_result.assoc.integer).to be >= right_result.assoc.integer
            end
          end
        end
      end

      context '{ binary: :desc, assoc: { integer: :asc } }' do
        let(:instructions) do
          { 'binary': :desc, assoc: { 'integer': :asc } }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.assoc.integer).to be <= right_result.assoc.integer
            end
          end
        end
      end

      context '{ computed_binary: :asc, assoc: { integer: :asc } }' do
        let(:instructions) do
          { 'computed_binary': :asc, assoc: { 'integer': :asc } }
        end

        it do
          expect(result.map(&:computed_binary)).to eq @all_foos.map(&:computed_binary).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_binary == right_result.computed_binary
              expect(left_result.assoc.integer).to be <= right_result.assoc.integer
            end
          end
        end
      end

      context '{ binary: :desc, assoc: { computed_integer: :desc } }' do
        let(:instructions) do
          { 'binary': :desc, assoc: { 'computed_integer': :desc } }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.assoc.computed_integer).to be >= right_result.assoc.computed_integer
            end
          end
        end
      end

      context '{ computed_binary: :asc, assoc: { computed_integer: :desc } }' do
        let(:instructions) do
          { 'computed_binary': :asc, assoc: { 'computed_integer': :desc } }
        end

        it do
          expect(result.map(&:computed_binary)).to eq @all_foos.map(&:computed_binary).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_binary == right_result.computed_binary
              expect(left_result.assoc.computed_integer).to be >= right_result.assoc.computed_integer
            end
          end
        end
      end

      context '{ assoc: { binary: :desc }, integer: :asc }' do
        let(:instructions) do
          { assoc: { 'binary': :desc }, 'integer': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.binary }).to eq @all_foos.map { |x| x.assoc&.binary }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.binary == right_result.assoc.binary
              expect(left_result.integer).to be <= right_result.integer
            end
          end
        end
      end

      context '{ assoc: { computed_binary: :asc }, computed_integer: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_binary': :asc }, 'computed_integer': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_binary }).to eq @all_foos.map { |x| x.assoc&.computed_binary }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_binary == right_result.assoc.computed_binary
              expect(left_result.computed_integer).to be <= right_result.computed_integer
            end
          end
        end
      end

      context '{ assoc: { binary: :asc }, computed_integer: :desc }' do
        let(:instructions) do
          { assoc: { 'binary': :asc }, 'computed_integer': :desc }
        end

        it do
          expect(result.map { |x| x.assoc&.binary }).to eq @all_foos.map { |x| x.assoc&.binary }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.binary == right_result.assoc.binary
              expect(left_result.computed_integer).to be >= right_result.computed_integer
            end
          end
        end
      end

      context '{ assoc: { computed_binary: :desc }, integer: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_binary': :desc }, 'integer': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_binary }).to eq @all_foos.map { |x| x.assoc&.computed_binary }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_binary == right_result.assoc.computed_binary
              expect(left_result.integer).to be <= right_result.integer
            end
          end
        end
      end
    end

    context 'with BINARY and STRING type' do
      context '{ binary: :asc, string: :asc }' do
        let(:instructions) do
          { 'binary': :asc, 'string': :asc }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.string).to be <= right_result.string
            end
          end
        end
      end

      context '{ binary: :desc, string: :desc }' do
        let(:instructions) do
          { 'binary': :desc, 'string': :desc }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.string).to be >= right_result.string
            end
          end
        end
      end

      context '{ binary: :asc, string: :desc }' do
        let(:instructions) do
          { 'binary': :asc, 'string': :desc }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.string).to be >= right_result.string
            end
          end
        end
      end

      context '{ binary: :desc, string: :asc }' do
        let(:instructions) do
          { 'binary': :desc, 'string': :asc }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.string).to be <= right_result.string
            end
          end
        end
      end


      context '{ computed_binary: :asc, computed_string: :asc }' do
        let(:instructions) do
          { 'computed_binary': :asc, 'computed_string': :asc }
        end

        it do
          expect(result.map(&:computed_binary)).to eq @all_foos.map(&:computed_binary).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_binary == right_result.computed_binary
              expect(left_result.computed_string).to be <= right_result.computed_string
            end
          end
        end
      end

      context '{ binary: :desc, computed_string: :desc }' do
        let(:instructions) do
          { 'binary': :desc, 'computed_string': :desc }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.computed_string).to be >= right_result.computed_string
            end
          end
        end
      end

      context '{ computed_binary: :asc, string: :desc }' do
        let(:instructions) do
          { 'computed_binary': :asc, 'string': :desc }
        end

        it do
          expect(result.map(&:computed_binary)).to eq @all_foos.map(&:computed_binary).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_binary == right_result.computed_binary
              expect(left_result.string).to be >= right_result.string
            end
          end
        end
      end

      context '{ assoc: { binary: :desc, string: :asc } }' do
        let(:instructions) do
          { assoc: { 'binary': :desc, 'string': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.binary }).to eq @all_foos.map { |x| x.assoc&.binary }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.binary == right_result.assoc.binary
              expect(left_result.assoc.string).to be <= right_result.assoc.string
            end
          end
        end
      end

      context '{ assoc: { computed_binary: :asc, computed_string: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_binary': :asc, 'computed_string': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_binary }).to eq @all_foos.map { |x| x.assoc&.computed_binary }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_binary == right_result.assoc.computed_binary
              expect(left_result.assoc.computed_string).to be <= right_result.assoc.computed_string
            end
          end
        end
      end

      context '{ assoc: { binary: :desc, computed_string: :desc } }' do
        let(:instructions) do
          { assoc: { 'binary': :desc, 'computed_string': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.binary }).to eq @all_foos.map { |x| x.assoc&.binary }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.binary == right_result.assoc.binary
              expect(left_result.assoc.computed_string).to be >= right_result.assoc.computed_string
            end
          end
        end
      end

      context '{ assoc: { computed_binary: :asc, string: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_binary': :asc, 'string': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_binary }).to eq @all_foos.map { |x| x.assoc&.computed_binary }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_binary == right_result.assoc.computed_binary
              expect(left_result.assoc.string).to be >= right_result.assoc.string
            end
          end
        end
      end

      context '{ binary: :desc, assoc: { string: :asc } }' do
        let(:instructions) do
          { 'binary': :desc, assoc: { 'string': :asc } }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.binary == right_result.assoc.binary
              expect(left_result.assoc.string).to be <= right_result.assoc.string
            end
          end
        end
      end

      context '{ computed_binary: :asc, assoc: { string: :asc } }' do
        let(:instructions) do
          { 'computed_binary': :asc, assoc: { 'string': :asc } }
        end

        it do
          expect(result.map(&:computed_binary)).to eq @all_foos.map(&:computed_binary).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_binary == right_result.computed_binary
              expect(left_result.assoc.string).to be <= right_result.assoc.string
            end
          end
        end
      end

      context '{ binary: :desc, assoc: { computed_string: :desc } }' do
        let(:instructions) do
          { 'binary': :desc, assoc: { 'computed_string': :desc } }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.assoc.computed_string).to be >= right_result.assoc.computed_string
            end
          end
        end
      end

      context '{ computed_binary: :asc, assoc: { computed_string: :desc } }' do
        let(:instructions) do
          { 'computed_binary': :asc, assoc: { 'computed_string': :desc } }
        end

        it do
          expect(result.map(&:computed_binary)).to eq @all_foos.map(&:computed_binary).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_binary == right_result.computed_binary
              expect(left_result.assoc.computed_string).to be >= right_result.assoc.computed_string
            end
          end
        end
      end

      context '{ assoc: { binary: :desc }, string: :asc }' do
        let(:instructions) do
          { assoc: { 'binary': :desc }, 'string': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.binary }).to eq @all_foos.map { |x| x.assoc&.binary }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.binary == right_result.assoc.binary
              expect(left_result.string).to be <= right_result.string
            end
          end
        end
      end

      context '{ assoc: { computed_binary: :asc }, computed_string: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_binary': :asc }, 'computed_string': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_binary }).to eq @all_foos.map { |x| x.assoc&.computed_binary }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_binary == right_result.assoc.computed_binary
              expect(left_result.computed_string).to be <= right_result.computed_string
            end
          end
        end
      end

      context '{ assoc: { binary: :asc }, computed_string: :desc }' do
        let(:instructions) do
          { assoc: { 'binary': :asc }, 'computed_string': :desc }
        end

        it do
          expect(result.map { |x| x.assoc&.binary }).to eq @all_foos.map { |x| x.assoc&.binary }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.binary == right_result.assoc.binary
              expect(left_result.computed_string).to be >= right_result.computed_string
            end
          end
        end
      end

      context '{ assoc: { computed_binary: :desc }, string: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_binary': :desc }, 'string': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_binary }).to eq @all_foos.map { |x| x.assoc&.computed_binary }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_binary == right_result.assoc.computed_binary
              expect(left_result.string).to be <= right_result.string
            end
          end
        end
      end
    end

    context 'with BINARY and TEXT type' do
      context '{ binary: :asc, text: :asc }' do
        let(:instructions) do
          { 'binary': :asc, 'text': :asc }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.text).to be <= right_result.text
            end
          end
        end
      end

      context '{ binary: :desc, text: :desc }' do
        let(:instructions) do
          { 'binary': :desc, 'text': :desc }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.text).to be >= right_result.text
            end
          end
        end
      end

      context '{ binary: :asc, text: :desc }' do
        let(:instructions) do
          { 'binary': :asc, 'text': :desc }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.text).to be >= right_result.text
            end
          end
        end
      end

      context '{ binary: :desc, text: :asc }' do
        let(:instructions) do
          { 'binary': :desc, 'text': :asc }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.text).to be <= right_result.text
            end
          end
        end
      end


      context '{ computed_binary: :asc, computed_text: :asc }' do
        let(:instructions) do
          { 'computed_binary': :asc, 'computed_text': :asc }
        end

        it do
          expect(result.map(&:computed_binary)).to eq @all_foos.map(&:computed_binary).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_binary == right_result.computed_binary
              expect(left_result.computed_text).to be <= right_result.computed_text
            end
          end
        end
      end

      context '{ binary: :desc, computed_text: :desc }' do
        let(:instructions) do
          { 'binary': :desc, 'computed_text': :desc }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.computed_text).to be >= right_result.computed_text
            end
          end
        end
      end

      context '{ computed_binary: :asc, text: :desc }' do
        let(:instructions) do
          { 'computed_binary': :asc, 'text': :desc }
        end

        it do
          expect(result.map(&:computed_binary)).to eq @all_foos.map(&:computed_binary).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_binary == right_result.computed_binary
              expect(left_result.text).to be >= right_result.text
            end
          end
        end
      end

      context '{ assoc: { binary: :desc, text: :asc } }' do
        let(:instructions) do
          { assoc: { 'binary': :desc, 'text': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.binary }).to eq @all_foos.map { |x| x.assoc&.binary }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.binary == right_result.assoc.binary
              expect(left_result.assoc.text).to be <= right_result.assoc.text
            end
          end
        end
      end

      context '{ assoc: { computed_binary: :asc, computed_text: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_binary': :asc, 'computed_text': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_binary }).to eq @all_foos.map { |x| x.assoc&.computed_binary }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_binary == right_result.assoc.computed_binary
              expect(left_result.assoc.computed_text).to be <= right_result.assoc.computed_text
            end
          end
        end
      end

      context '{ assoc: { binary: :desc, computed_text: :desc } }' do
        let(:instructions) do
          { assoc: { 'binary': :desc, 'computed_text': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.binary }).to eq @all_foos.map { |x| x.assoc&.binary }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.binary == right_result.assoc.binary
              expect(left_result.assoc.computed_text).to be >= right_result.assoc.computed_text
            end
          end
        end
      end

      context '{ assoc: { computed_binary: :asc, text: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_binary': :asc, 'text': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_binary }).to eq @all_foos.map { |x| x.assoc&.computed_binary }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_binary == right_result.assoc.computed_binary
              expect(left_result.assoc.text).to be >= right_result.assoc.text
            end
          end
        end
      end

      context '{ binary: :desc, assoc: { text: :asc } }' do
        let(:instructions) do
          { 'binary': :desc, assoc: { 'text': :asc } }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.assoc.text).to be <= right_result.assoc.text
            end
          end
        end
      end

      context '{ computed_binary: :asc, assoc: { text: :asc } }' do
        let(:instructions) do
          { 'computed_binary': :asc, assoc: { 'text': :asc } }
        end

        it do
          expect(result.map(&:computed_binary)).to eq @all_foos.map(&:computed_binary).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_binary == right_result.computed_binary
              expect(left_result.assoc.text).to be <= right_result.assoc.text
            end
          end
        end
      end

      context '{ binary: :desc, assoc: { computed_text: :desc } }' do
        let(:instructions) do
          { 'binary': :desc, assoc: { 'computed_text': :desc } }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.assoc.computed_text).to be >= right_result.assoc.computed_text
            end
          end
        end
      end

      context '{ computed_binary: :asc, assoc: { computed_text: :desc } }' do
        let(:instructions) do
          { 'computed_binary': :asc, assoc: { 'computed_text': :desc } }
        end

        it do
          expect(result.map(&:computed_binary)).to eq @all_foos.map(&:computed_binary).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_binary == right_result.computed_binary
              expect(left_result.assoc.computed_text).to be >= right_result.assoc.computed_text
            end
          end
        end
      end

      context '{ assoc: { binary: :desc }, text: :asc }' do
        let(:instructions) do
          { assoc: { 'binary': :desc }, 'text': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.binary }).to eq @all_foos.map { |x| x.assoc&.binary }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.binary == right_result.assoc.binary
              expect(left_result.text).to be <= right_result.text
            end
          end
        end
      end

      context '{ assoc: { computed_binary: :asc }, computed_text: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_binary': :asc }, 'computed_text': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_binary }).to eq @all_foos.map { |x| x.assoc&.computed_binary }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_binary == right_result.assoc.computed_binary
              expect(left_result.computed_text).to be <= right_result.computed_text
            end
          end
        end
      end

      context '{ assoc: { binary: :asc }, computed_text: :desc }' do
        let(:instructions) do
          { assoc: { 'binary': :asc }, 'computed_text': :desc }
        end

        it do
          expect(result.map { |x| x.assoc&.binary }).to eq @all_foos.map { |x| x.assoc&.binary }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.binary == right_result.assoc.binary
              expect(left_result.computed_text).to be >= right_result.computed_text
            end
          end
        end
      end

      context '{ assoc: { computed_binary: :desc }, text: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_binary': :desc }, 'text': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_binary }).to eq @all_foos.map { |x| x.assoc&.computed_binary }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_binary == right_result.assoc.computed_binary
              expect(left_result.text).to be <= right_result.text
            end
          end
        end
      end
    end

    context 'with BINARY and TIME type' do
      context '{ binary: :asc, time: :asc }' do
        let(:instructions) do
          { 'binary': :asc, 'time': :asc }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.time).to be <= right_result.time
            end
          end
        end
      end

      context '{ binary: :desc, time: :desc }' do
        let(:instructions) do
          { 'binary': :desc, 'time': :desc }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.time).to be >= right_result.time
            end
          end
        end
      end

      context '{ binary: :asc, time: :desc }' do
        let(:instructions) do
          { 'binary': :asc, 'time': :desc }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.time).to be >= right_result.time
            end
          end
        end
      end

      context '{ binary: :desc, time: :asc }' do
        let(:instructions) do
          { 'binary': :desc, 'time': :asc }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.time).to be <= right_result.time
            end
          end
        end
      end


      context '{ computed_binary: :asc, computed_time: :asc }' do
        let(:instructions) do
          { 'computed_binary': :asc, 'computed_time': :asc }
        end

        it do
          expect(result.map(&:computed_binary)).to eq @all_foos.map(&:computed_binary).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_binary == right_result.computed_binary
              expect(left_result.computed_time).to be <= right_result.computed_time
            end
          end
        end
      end

      context '{ binary: :desc, computed_time: :desc }' do
        let(:instructions) do
          { 'binary': :desc, 'computed_time': :desc }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.computed_time).to be >= right_result.computed_time
            end
          end
        end
      end

      context '{ computed_binary: :asc, time: :desc }' do
        let(:instructions) do
          { 'computed_binary': :asc, 'time': :desc }
        end

        it do
          expect(result.map(&:computed_binary)).to eq @all_foos.map(&:computed_binary).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_binary == right_result.computed_binary
              expect(left_result.time).to be >= right_result.time
            end
          end
        end
      end

      context '{ assoc: { binary: :desc, time: :asc } }' do
        let(:instructions) do
          { assoc: { 'binary': :desc, 'time': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.binary }).to eq @all_foos.map { |x| x.assoc&.binary }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.binary == right_result.assoc.binary
              expect(left_result.assoc.time).to be <= right_result.assoc.time
            end
          end
        end
      end

      context '{ assoc: { computed_binary: :asc, computed_time: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_binary': :asc, 'computed_time': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_binary }).to eq @all_foos.map { |x| x.assoc&.computed_binary }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_binary == right_result.assoc.computed_binary
              expect(left_result.assoc.computed_time).to be <= right_result.assoc.computed_time
            end
          end
        end
      end

      context '{ assoc: { binary: :desc, computed_time: :desc } }' do
        let(:instructions) do
          { assoc: { 'binary': :desc, 'computed_time': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.binary }).to eq @all_foos.map { |x| x.assoc&.binary }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.binary == right_result.assoc.binary
              expect(left_result.assoc.computed_time).to be >= right_result.assoc.computed_time
            end
          end
        end
      end

      context '{ assoc: { computed_binary: :asc, time: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_binary': :asc, 'time': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_binary }).to eq @all_foos.map { |x| x.assoc&.computed_binary }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_binary == right_result.assoc.computed_binary
              expect(left_result.assoc.time).to be >= right_result.assoc.time
            end
          end
        end
      end

      context '{ binary: :desc, assoc: { time: :asc } }' do
        let(:instructions) do
          { 'binary': :desc, assoc: { 'time': :asc } }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.assoc.time).to be <= right_result.assoc.time
            end
          end
        end
      end

      context '{ computed_binary: :asc, assoc: { time: :asc } }' do
        let(:instructions) do
          { 'computed_binary': :asc, assoc: { 'time': :asc } }
        end

        it do
          expect(result.map(&:computed_binary)).to eq @all_foos.map(&:computed_binary).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_binary == right_result.computed_binary
              expect(left_result.assoc.time).to be <= right_result.assoc.time
            end
          end
        end
      end

      context '{ binary: :desc, assoc: { computed_time: :desc } }' do
        let(:instructions) do
          { 'binary': :desc, assoc: { 'computed_time': :desc } }
        end

        it do
          expect(result.map(&:binary)).to eq @all_foos.map(&:binary).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.binary == right_result.binary
              expect(left_result.assoc.computed_time).to be >= right_result.assoc.computed_time
            end
          end
        end
      end

      context '{ computed_binary: :asc, assoc: { computed_time: :desc } }' do
        let(:instructions) do
          { 'computed_binary': :asc, assoc: { 'computed_time': :desc } }
        end

        it do
          expect(result.map(&:computed_binary)).to eq @all_foos.map(&:computed_binary).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_binary == right_result.computed_binary
              expect(left_result.assoc.computed_time).to be >= right_result.assoc.computed_time
            end
          end
        end
      end

      context '{ assoc: { binary: :desc }, time: :asc }' do
        let(:instructions) do
          { assoc: { 'binary': :desc }, 'time': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.binary }).to eq @all_foos.map { |x| x.assoc&.binary }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.binary == right_result.assoc.binary
              expect(left_result.time).to be <= right_result.time
            end
          end
        end
      end

      context '{ assoc: { computed_binary: :asc }, computed_time: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_binary': :asc }, 'computed_time': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_binary }).to eq @all_foos.map { |x| x.assoc&.computed_binary }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_binary == right_result.assoc.computed_binary
              expect(left_result.computed_time).to be <= right_result.computed_time
            end
          end
        end
      end

      context '{ assoc: { binary: :asc }, computed_time: :desc }' do
        let(:instructions) do
          { assoc: { 'binary': :asc }, 'computed_time': :desc }
        end

        it do
          expect(result.map { |x| x.assoc&.binary }).to eq @all_foos.map { |x| x.assoc&.binary }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.binary == right_result.assoc.binary
              expect(left_result.computed_time).to be >= right_result.computed_time
            end
          end
        end
      end

      context '{ assoc: { computed_binary: :desc }, time: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_binary': :desc }, 'time': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_binary }).to eq @all_foos.map { |x| x.assoc&.computed_binary }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_binary == right_result.assoc.computed_binary
              expect(left_result.time).to be <= right_result.time
            end
          end
        end
      end
    end


    context 'with BOOLEAN and DATE type' do
      context '{ boolean: :asc, date: :asc }' do
        let(:instructions) do
          { 'boolean': :asc, 'date': :asc }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.date).to be <= right_result.date
            end
          end
        end
      end

      context '{ boolean: :desc, date: :desc }' do
        let(:instructions) do
          { 'boolean': :desc, 'date': :desc }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.date).to be >= right_result.date
            end
          end
        end
      end

      context '{ boolean: :asc, date: :desc }' do
        let(:instructions) do
          { 'boolean': :asc, 'date': :desc }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.date).to be >= right_result.date
            end
          end
        end
      end

      context '{ boolean: :desc, date: :asc }' do
        let(:instructions) do
          { 'boolean': :desc, 'date': :asc }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.date).to be <= right_result.date
            end
          end
        end
      end


      context '{ computed_boolean: :asc, computed_date: :asc }' do
        let(:instructions) do
          { 'computed_boolean': :asc, 'computed_date': :asc }
        end

        it do
          expect(result.map(&:computed_boolean)).to eq @all_foos.map(&:computed_boolean).sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_boolean == right_result.computed_boolean
              expect(left_result.computed_date).to be <= right_result.computed_date
            end
          end
        end
      end

      context '{ boolean: :desc, computed_date: :desc }' do
        let(:instructions) do
          { 'boolean': :desc, 'computed_date': :desc }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.computed_date).to be >= right_result.computed_date
            end
          end
        end
      end

      context '{ computed_boolean: :asc, date: :desc }' do
        let(:instructions) do
          { 'computed_boolean': :asc, 'date': :desc }
        end

        it do
          expect(result.map(&:computed_boolean)).to eq @all_foos.map(&:computed_boolean).sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_boolean == right_result.computed_boolean
              expect(left_result.date).to be >= right_result.date
            end
          end
        end
      end

      context '{ assoc: { boolean: :desc, date: :asc } }' do
        let(:instructions) do
          { assoc: { 'boolean': :desc, 'date': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.boolean }).to eq @all_foos.map { |x| x.assoc&.boolean }.sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.boolean == right_result.assoc.boolean
              expect(left_result.assoc.date).to be <= right_result.assoc.date
            end
          end
        end
      end

      context '{ assoc: { computed_boolean: :asc, computed_date: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_boolean': :asc, 'computed_date': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_boolean }).to eq @all_foos.map { |x| x.assoc&.computed_boolean }.sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_boolean == right_result.assoc.computed_boolean
              expect(left_result.assoc.computed_date).to be <= right_result.assoc.computed_date
            end
          end
        end
      end

      context '{ assoc: { boolean: :desc, computed_date: :desc } }' do
        let(:instructions) do
          { assoc: { 'boolean': :desc, 'computed_date': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.boolean }).to eq @all_foos.map { |x| x.assoc&.boolean }.sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.boolean == right_result.assoc.boolean
              expect(left_result.assoc.computed_date).to be >= right_result.assoc.computed_date
            end
          end
        end
      end

      context '{ assoc: { computed_boolean: :asc, date: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_boolean': :asc, 'date': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_boolean }).to eq @all_foos.map { |x| x.assoc&.computed_boolean }.sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_boolean == right_result.assoc.computed_boolean
              expect(left_result.assoc.date).to be >= right_result.assoc.date
            end
          end
        end
      end

      context '{ boolean: :desc, assoc: { date: :asc } }' do
        let(:instructions) do
          { 'boolean': :desc, assoc: { 'date': :asc } }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.assoc.date).to be <= right_result.assoc.date
            end
          end
        end
      end

      context '{ computed_boolean: :asc, assoc: { date: :asc } }' do
        let(:instructions) do
          { 'computed_boolean': :asc, assoc: { 'date': :asc } }
        end

        it do
          expect(result.map(&:computed_boolean)).to eq @all_foos.map(&:computed_boolean).sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_boolean == right_result.computed_boolean
              expect(left_result.assoc.date).to be <= right_result.assoc.date
            end
          end
        end
      end

      context '{ boolean: :desc, assoc: { computed_date: :desc } }' do
        let(:instructions) do
          { 'boolean': :desc, assoc: { 'computed_date': :desc } }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.assoc.computed_date).to be >= right_result.assoc.computed_date
            end
          end
        end
      end

      context '{ computed_boolean: :asc, assoc: { computed_date: :desc } }' do
        let(:instructions) do
          { 'computed_boolean': :asc, assoc: { 'computed_date': :desc } }
        end

        it do
          expect(result.map(&:computed_boolean)).to eq @all_foos.map(&:computed_boolean).sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_boolean == right_result.computed_boolean
              expect(left_result.assoc.computed_date).to be >= right_result.assoc.computed_date
            end
          end
        end
      end

      context '{ assoc: { boolean: :desc }, date: :asc }' do
        let(:instructions) do
          { assoc: { 'boolean': :desc }, 'date': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.boolean }).to eq @all_foos.map { |x| x.assoc&.boolean }.sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.boolean == right_result.assoc.boolean
              expect(left_result.date).to be <= right_result.date
            end
          end
        end
      end

      context '{ assoc: { computed_boolean: :asc }, computed_date: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_boolean': :asc }, 'computed_date': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_boolean }).to eq @all_foos.map { |x| x.assoc&.computed_boolean }.sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_boolean == right_result.assoc.computed_boolean
              expect(left_result.computed_date).to be <= right_result.computed_date
            end
          end
        end
      end

      context '{ assoc: { boolean: :asc }, computed_date: :desc }' do
        let(:instructions) do
          { assoc: { 'boolean': :asc }, 'computed_date': :desc }
        end

        it do
          expect(result.map { |x| x.assoc&.boolean }).to eq @all_foos.map { |x| x.assoc&.boolean }.sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.boolean == right_result.assoc.boolean
              expect(left_result.computed_date).to be >= right_result.computed_date
            end
          end
        end
      end

      context '{ assoc: { computed_boolean: :desc }, date: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_boolean': :desc }, 'date': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_boolean }).to eq @all_foos.map { |x| x.assoc&.computed_boolean }.sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_boolean == right_result.assoc.computed_boolean
              expect(left_result.date).to be <= right_result.date
            end
          end
        end
      end
    end

    context 'with BOOLEAN and DATETIME type' do
      context '{ boolean: :asc, datetime: :asc }' do
        let(:instructions) do
          { 'boolean': :asc, 'datetime': :asc }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.datetime).to be <= right_result.datetime
            end
          end
        end
      end

      context '{ boolean: :desc, datetime: :desc }' do
        let(:instructions) do
          { 'boolean': :desc, 'datetime': :desc }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.datetime).to be >= right_result.datetime
            end
          end
        end
      end

      context '{ boolean: :asc, datetime: :desc }' do
        let(:instructions) do
          { 'boolean': :asc, 'datetime': :desc }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.datetime).to be >= right_result.datetime
            end
          end
        end
      end

      context '{ boolean: :desc, datetime: :asc }' do
        let(:instructions) do
          { 'boolean': :desc, 'datetime': :asc }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.datetime).to be <= right_result.datetime
            end
          end
        end
      end


      context '{ computed_boolean: :asc, computed_datetime: :asc }' do
        let(:instructions) do
          { 'computed_boolean': :asc, 'computed_datetime': :asc }
        end

        it do
          expect(result.map(&:computed_boolean)).to eq @all_foos.map(&:computed_boolean).sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_boolean == right_result.computed_boolean
              expect(left_result.computed_datetime).to be <= right_result.computed_datetime
            end
          end
        end
      end

      context '{ boolean: :desc, computed_datetime: :desc }' do
        let(:instructions) do
          { 'boolean': :desc, 'computed_datetime': :desc }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.computed_datetime).to be >= right_result.computed_datetime
            end
          end
        end
      end

      context '{ computed_boolean: :asc, datetime: :desc }' do
        let(:instructions) do
          { 'computed_boolean': :asc, 'datetime': :desc }
        end

        it do
          expect(result.map(&:computed_boolean)).to eq @all_foos.map(&:computed_boolean).sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_boolean == right_result.computed_boolean
              expect(left_result.datetime).to be >= right_result.datetime
            end
          end
        end
      end

      context '{ assoc: { boolean: :desc, datetime: :asc } }' do
        let(:instructions) do
          { assoc: { 'boolean': :desc, 'datetime': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.boolean }).to eq @all_foos.map { |x| x.assoc&.boolean }.sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.boolean == right_result.assoc.boolean
              expect(left_result.assoc.datetime).to be <= right_result.assoc.datetime
            end
          end
        end
      end

      context '{ assoc: { computed_boolean: :asc, computed_datetime: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_boolean': :asc, 'computed_datetime': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_boolean }).to eq @all_foos.map { |x| x.assoc&.computed_boolean }.sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_boolean == right_result.assoc.computed_boolean
              expect(left_result.assoc.computed_datetime).to be <= right_result.assoc.computed_datetime
            end
          end
        end
      end

      context '{ assoc: { boolean: :desc, computed_datetime: :desc } }' do
        let(:instructions) do
          { assoc: { 'boolean': :desc, 'computed_datetime': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.boolean }).to eq @all_foos.map { |x| x.assoc&.boolean }.sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.boolean == right_result.assoc.boolean
              expect(left_result.assoc.computed_datetime).to be >= right_result.assoc.computed_datetime
            end
          end
        end
      end

      context '{ assoc: { computed_boolean: :asc, datetime: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_boolean': :asc, 'datetime': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_boolean }).to eq @all_foos.map { |x| x.assoc&.computed_boolean }.sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_boolean == right_result.assoc.computed_boolean
              expect(left_result.assoc.datetime).to be >= right_result.assoc.datetime
            end
          end
        end
      end

      context '{ boolean: :desc, assoc: { datetime: :asc } }' do
        let(:instructions) do
          { 'boolean': :desc, assoc: { 'datetime': :asc } }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.assoc.datetime).to be <= right_result.assoc.datetime
            end
          end
        end
      end

      context '{ computed_boolean: :asc, assoc: { datetime: :asc } }' do
        let(:instructions) do
          { 'computed_boolean': :asc, assoc: { 'datetime': :asc } }
        end

        it do
          expect(result.map(&:computed_boolean)).to eq @all_foos.map(&:computed_boolean).sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_boolean == right_result.computed_boolean
              expect(left_result.assoc.datetime).to be <= right_result.assoc.datetime
            end
          end
        end
      end

      context '{ boolean: :desc, assoc: { computed_datetime: :desc } }' do
        let(:instructions) do
          { 'boolean': :desc, assoc: { 'computed_datetime': :desc } }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.assoc.computed_datetime).to be >= right_result.assoc.computed_datetime
            end
          end
        end
      end

      context '{ computed_boolean: :asc, assoc: { computed_datetime: :desc } }' do
        let(:instructions) do
          { 'computed_boolean': :asc, assoc: { 'computed_datetime': :desc } }
        end

        it do
          expect(result.map(&:computed_boolean)).to eq @all_foos.map(&:computed_boolean).sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_boolean == right_result.computed_boolean
              expect(left_result.assoc.computed_datetime).to be >= right_result.assoc.computed_datetime
            end
          end
        end
      end

      context '{ assoc: { boolean: :desc }, datetime: :asc }' do
        let(:instructions) do
          { assoc: { 'boolean': :desc }, 'datetime': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.boolean }).to eq @all_foos.map { |x| x.assoc&.boolean }.sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.boolean == right_result.assoc.boolean
              expect(left_result.datetime).to be <= right_result.datetime
            end
          end
        end
      end

      context '{ assoc: { computed_boolean: :asc }, computed_datetime: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_boolean': :asc }, 'computed_datetime': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_boolean }).to eq @all_foos.map { |x| x.assoc&.computed_boolean }.sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_boolean == right_result.assoc.computed_boolean
              expect(left_result.computed_datetime).to be <= right_result.computed_datetime
            end
          end
        end
      end

      context '{ assoc: { boolean: :asc }, computed_datetime: :desc }' do
        let(:instructions) do
          { assoc: { 'boolean': :asc }, 'computed_datetime': :desc }
        end

        it do
          expect(result.map { |x| x.assoc&.boolean }).to eq @all_foos.map { |x| x.assoc&.boolean }.sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.boolean == right_result.assoc.boolean
              expect(left_result.computed_datetime).to be >= right_result.computed_datetime
            end
          end
        end
      end

      context '{ assoc: { computed_boolean: :desc }, datetime: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_boolean': :desc }, 'datetime': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_boolean }).to eq @all_foos.map { |x| x.assoc&.computed_boolean }.sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_boolean == right_result.assoc.computed_boolean
              expect(left_result.datetime).to be <= right_result.datetime
            end
          end
        end
      end
    end

    context 'with BOOLEAN and DECIMAL type' do
      context '{ boolean: :asc, decimal: :asc }' do
        let(:instructions) do
          { 'boolean': :asc, 'decimal': :asc }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.decimal).to be <= right_result.decimal
            end
          end
        end
      end

      context '{ boolean: :desc, decimal: :desc }' do
        let(:instructions) do
          { 'boolean': :desc, 'decimal': :desc }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.decimal).to be >= right_result.decimal
            end
          end
        end
      end

      context '{ boolean: :asc, decimal: :desc }' do
        let(:instructions) do
          { 'boolean': :asc, 'decimal': :desc }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.decimal).to be >= right_result.decimal
            end
          end
        end
      end

      context '{ boolean: :desc, decimal: :asc }' do
        let(:instructions) do
          { 'boolean': :desc, 'decimal': :asc }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.decimal).to be <= right_result.decimal
            end
          end
        end
      end


      context '{ computed_boolean: :asc, computed_decimal: :asc }' do
        let(:instructions) do
          { 'computed_boolean': :asc, 'computed_decimal': :asc }
        end

        it do
          expect(result.map(&:computed_boolean)).to eq @all_foos.map(&:computed_boolean).sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_boolean == right_result.computed_boolean
              expect(left_result.computed_decimal).to be <= right_result.computed_decimal
            end
          end
        end
      end

      context '{ boolean: :desc, computed_decimal: :desc }' do
        let(:instructions) do
          { 'boolean': :desc, 'computed_decimal': :desc }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.computed_decimal).to be >= right_result.computed_decimal
            end
          end
        end
      end

      context '{ computed_boolean: :asc, decimal: :desc }' do
        let(:instructions) do
          { 'computed_boolean': :asc, 'decimal': :desc }
        end

        it do
          expect(result.map(&:computed_boolean)).to eq @all_foos.map(&:computed_boolean).sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_boolean == right_result.computed_boolean
              expect(left_result.decimal).to be >= right_result.decimal
            end
          end
        end
      end

      context '{ assoc: { boolean: :desc, decimal: :asc } }' do
        let(:instructions) do
          { assoc: { 'boolean': :desc, 'decimal': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.boolean }).to eq @all_foos.map { |x| x.assoc&.boolean }.sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.boolean == right_result.assoc.boolean
              expect(left_result.assoc.decimal).to be <= right_result.assoc.decimal
            end
          end
        end
      end

      context '{ assoc: { computed_boolean: :asc, computed_decimal: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_boolean': :asc, 'computed_decimal': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_boolean }).to eq @all_foos.map { |x| x.assoc&.computed_boolean }.sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_boolean == right_result.assoc.computed_boolean
              expect(left_result.assoc.computed_decimal).to be <= right_result.assoc.computed_decimal
            end
          end
        end
      end

      context '{ assoc: { boolean: :desc, computed_decimal: :desc } }' do
        let(:instructions) do
          { assoc: { 'boolean': :desc, 'computed_decimal': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.boolean }).to eq @all_foos.map { |x| x.assoc&.boolean }.sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.boolean == right_result.assoc.boolean
              expect(left_result.assoc.computed_decimal).to be >= right_result.assoc.computed_decimal
            end
          end
        end
      end

      context '{ assoc: { computed_boolean: :asc, decimal: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_boolean': :asc, 'decimal': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_boolean }).to eq @all_foos.map { |x| x.assoc&.computed_boolean }.sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_boolean == right_result.assoc.computed_boolean
              expect(left_result.assoc.decimal).to be >= right_result.assoc.decimal
            end
          end
        end
      end

      context '{ boolean: :desc, assoc: { decimal: :asc } }' do
        let(:instructions) do
          { 'boolean': :desc, assoc: { 'decimal': :asc } }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.assoc.decimal).to be <= right_result.assoc.decimal
            end
          end
        end
      end

      context '{ computed_boolean: :asc, assoc: { decimal: :asc } }' do
        let(:instructions) do
          { 'computed_boolean': :asc, assoc: { 'decimal': :asc } }
        end

        it do
          expect(result.map(&:computed_boolean)).to eq @all_foos.map(&:computed_boolean).sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_boolean == right_result.computed_boolean
              expect(left_result.assoc.decimal).to be <= right_result.assoc.decimal
            end
          end
        end
      end

      context '{ boolean: :desc, assoc: { computed_decimal: :desc } }' do
        let(:instructions) do
          { 'boolean': :desc, assoc: { 'computed_decimal': :desc } }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.assoc.computed_decimal).to be >= right_result.assoc.computed_decimal
            end
          end
        end
      end

      context '{ computed_boolean: :asc, assoc: { computed_decimal: :desc } }' do
        let(:instructions) do
          { 'computed_boolean': :asc, assoc: { 'computed_decimal': :desc } }
        end

        it do
          expect(result.map(&:computed_boolean)).to eq @all_foos.map(&:computed_boolean).sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_boolean == right_result.computed_boolean
              expect(left_result.assoc.computed_decimal).to be >= right_result.assoc.computed_decimal
            end
          end
        end
      end

      context '{ assoc: { boolean: :desc }, decimal: :asc }' do
        let(:instructions) do
          { assoc: { 'boolean': :desc }, 'decimal': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.boolean }).to eq @all_foos.map { |x| x.assoc&.boolean }.sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.boolean == right_result.assoc.boolean
              expect(left_result.decimal).to be <= right_result.decimal
            end
          end
        end
      end

      context '{ assoc: { computed_boolean: :asc }, computed_decimal: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_boolean': :asc }, 'computed_decimal': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_boolean }).to eq @all_foos.map { |x| x.assoc&.computed_boolean }.sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_boolean == right_result.assoc.computed_boolean
              expect(left_result.computed_decimal).to be <= right_result.computed_decimal
            end
          end
        end
      end

      context '{ assoc: { boolean: :asc }, computed_decimal: :desc }' do
        let(:instructions) do
          { assoc: { 'boolean': :asc }, 'computed_decimal': :desc }
        end

        it do
          expect(result.map { |x| x.assoc&.boolean }).to eq @all_foos.map { |x| x.assoc&.boolean }.sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.boolean == right_result.assoc.boolean
              expect(left_result.computed_decimal).to be >= right_result.computed_decimal
            end
          end
        end
      end

      context '{ assoc: { computed_boolean: :desc }, decimal: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_boolean': :desc }, 'decimal': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_boolean }).to eq @all_foos.map { |x| x.assoc&.computed_boolean }.sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_boolean == right_result.assoc.computed_boolean
              expect(left_result.decimal).to be <= right_result.decimal
            end
          end
        end
      end
    end

    context 'with BOOLEAN and FLOAT type' do
      context '{ boolean: :asc, float: :asc }' do
        let(:instructions) do
          { 'boolean': :asc, 'float': :asc }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.float).to be <= right_result.float
            end
          end
        end
      end

      context '{ boolean: :desc, float: :desc }' do
        let(:instructions) do
          { 'boolean': :desc, 'float': :desc }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.float).to be >= right_result.float
            end
          end
        end
      end

      context '{ boolean: :asc, float: :desc }' do
        let(:instructions) do
          { 'boolean': :asc, 'float': :desc }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.float).to be >= right_result.float
            end
          end
        end
      end

      context '{ boolean: :desc, float: :asc }' do
        let(:instructions) do
          { 'boolean': :desc, 'float': :asc }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.float).to be <= right_result.float
            end
          end
        end
      end


      context '{ computed_boolean: :asc, computed_float: :asc }' do
        let(:instructions) do
          { 'computed_boolean': :asc, 'computed_float': :asc }
        end

        it do
          expect(result.map(&:computed_boolean)).to eq @all_foos.map(&:computed_boolean).sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_boolean == right_result.computed_boolean
              expect(left_result.computed_float).to be <= right_result.computed_float
            end
          end
        end
      end

      context '{ boolean: :desc, computed_float: :desc }' do
        let(:instructions) do
          { 'boolean': :desc, 'computed_float': :desc }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.computed_float).to be >= right_result.computed_float
            end
          end
        end
      end

      context '{ computed_boolean: :asc, float: :desc }' do
        let(:instructions) do
          { 'computed_boolean': :asc, 'float': :desc }
        end

        it do
          expect(result.map(&:computed_boolean)).to eq @all_foos.map(&:computed_boolean).sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_boolean == right_result.computed_boolean
              expect(left_result.float).to be >= right_result.float
            end
          end
        end
      end

      context '{ assoc: { boolean: :desc, float: :asc } }' do
        let(:instructions) do
          { assoc: { 'boolean': :desc, 'float': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.boolean }).to eq @all_foos.map { |x| x.assoc&.boolean }.sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.boolean == right_result.assoc.boolean
              expect(left_result.assoc.float).to be <= right_result.assoc.float
            end
          end
        end
      end

      context '{ assoc: { computed_boolean: :asc, computed_float: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_boolean': :asc, 'computed_float': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_boolean }).to eq @all_foos.map { |x| x.assoc&.computed_boolean }.sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_boolean == right_result.assoc.computed_boolean
              expect(left_result.assoc.computed_float).to be <= right_result.assoc.computed_float
            end
          end
        end
      end

      context '{ assoc: { boolean: :desc, computed_float: :desc } }' do
        let(:instructions) do
          { assoc: { 'boolean': :desc, 'computed_float': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.boolean }).to eq @all_foos.map { |x| x.assoc&.boolean }.sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.boolean == right_result.assoc.boolean
              expect(left_result.assoc.computed_float).to be >= right_result.assoc.computed_float
            end
          end
        end
      end

      context '{ assoc: { computed_boolean: :asc, float: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_boolean': :asc, 'float': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_boolean }).to eq @all_foos.map { |x| x.assoc&.computed_boolean }.sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_boolean == right_result.assoc.computed_boolean
              expect(left_result.assoc.float).to be >= right_result.assoc.float
            end
          end
        end
      end

      context '{ boolean: :desc, assoc: { float: :asc } }' do
        let(:instructions) do
          { 'boolean': :desc, assoc: { 'float': :asc } }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.assoc.float).to be <= right_result.assoc.float
            end
          end
        end
      end

      context '{ computed_boolean: :asc, assoc: { float: :asc } }' do
        let(:instructions) do
          { 'computed_boolean': :asc, assoc: { 'float': :asc } }
        end

        it do
          expect(result.map(&:computed_boolean)).to eq @all_foos.map(&:computed_boolean).sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_boolean == right_result.computed_boolean
              expect(left_result.assoc.float).to be <= right_result.assoc.float
            end
          end
        end
      end

      context '{ boolean: :desc, assoc: { computed_float: :desc } }' do
        let(:instructions) do
          { 'boolean': :desc, assoc: { 'computed_float': :desc } }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.assoc.computed_float).to be >= right_result.assoc.computed_float
            end
          end
        end
      end

      context '{ computed_boolean: :asc, assoc: { computed_float: :desc } }' do
        let(:instructions) do
          { 'computed_boolean': :asc, assoc: { 'computed_float': :desc } }
        end

        it do
          expect(result.map(&:computed_boolean)).to eq @all_foos.map(&:computed_boolean).sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_boolean == right_result.computed_boolean
              expect(left_result.assoc.computed_float).to be >= right_result.assoc.computed_float
            end
          end
        end
      end

      context '{ assoc: { boolean: :desc }, float: :asc }' do
        let(:instructions) do
          { assoc: { 'boolean': :desc }, 'float': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.boolean }).to eq @all_foos.map { |x| x.assoc&.boolean }.sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.boolean == right_result.assoc.boolean
              expect(left_result.float).to be <= right_result.float
            end
          end
        end
      end

      context '{ assoc: { computed_boolean: :asc }, computed_float: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_boolean': :asc }, 'computed_float': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_boolean }).to eq @all_foos.map { |x| x.assoc&.computed_boolean }.sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_boolean == right_result.assoc.computed_boolean
              expect(left_result.computed_float).to be <= right_result.computed_float
            end
          end
        end
      end

      context '{ assoc: { boolean: :asc }, computed_float: :desc }' do
        let(:instructions) do
          { assoc: { 'boolean': :asc }, 'computed_float': :desc }
        end

        it do
          expect(result.map { |x| x.assoc&.boolean }).to eq @all_foos.map { |x| x.assoc&.boolean }.sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.boolean == right_result.assoc.boolean
              expect(left_result.computed_float).to be >= right_result.computed_float
            end
          end
        end
      end

      context '{ assoc: { computed_boolean: :desc }, float: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_boolean': :desc }, 'float': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_boolean }).to eq @all_foos.map { |x| x.assoc&.computed_boolean }.sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_boolean == right_result.assoc.computed_boolean
              expect(left_result.float).to be <= right_result.float
            end
          end
        end
      end
    end

    context 'with BOOLEAN and INTEGER type' do
      context '{ boolean: :asc, integer: :asc }' do
        let(:instructions) do
          { 'boolean': :asc, 'integer': :asc }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.integer).to be <= right_result.integer
            end
          end
        end
      end

      context '{ boolean: :desc, integer: :desc }' do
        let(:instructions) do
          { 'boolean': :desc, 'integer': :desc }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.integer).to be >= right_result.integer
            end
          end
        end
      end

      context '{ boolean: :asc, integer: :desc }' do
        let(:instructions) do
          { 'boolean': :asc, 'integer': :desc }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.integer).to be >= right_result.integer
            end
          end
        end
      end

      context '{ boolean: :desc, integer: :asc }' do
        let(:instructions) do
          { 'boolean': :desc, 'integer': :asc }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.integer).to be <= right_result.integer
            end
          end
        end
      end


      context '{ computed_boolean: :asc, computed_integer: :asc }' do
        let(:instructions) do
          { 'computed_boolean': :asc, 'computed_integer': :asc }
        end

        it do
          expect(result.map(&:computed_boolean)).to eq @all_foos.map(&:computed_boolean).sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_boolean == right_result.computed_boolean
              expect(left_result.computed_integer).to be <= right_result.computed_integer
            end
          end
        end
      end

      context '{ boolean: :desc, computed_integer: :desc }' do
        let(:instructions) do
          { 'boolean': :desc, 'computed_integer': :desc }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.computed_integer).to be >= right_result.computed_integer
            end
          end
        end
      end

      context '{ computed_boolean: :asc, integer: :desc }' do
        let(:instructions) do
          { 'computed_boolean': :asc, 'integer': :desc }
        end

        it do
          expect(result.map(&:computed_boolean)).to eq @all_foos.map(&:computed_boolean).sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_boolean == right_result.computed_boolean
              expect(left_result.integer).to be >= right_result.integer
            end
          end
        end
      end

      context '{ assoc: { boolean: :desc, integer: :asc } }' do
        let(:instructions) do
          { assoc: { 'boolean': :desc, 'integer': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.boolean }).to eq @all_foos.map { |x| x.assoc&.boolean }.sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.boolean == right_result.assoc.boolean
              expect(left_result.assoc.integer).to be <= right_result.assoc.integer
            end
          end
        end
      end

      context '{ assoc: { computed_boolean: :asc, computed_integer: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_boolean': :asc, 'computed_integer': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_boolean }).to eq @all_foos.map { |x| x.assoc&.computed_boolean }.sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_boolean == right_result.assoc.computed_boolean
              expect(left_result.assoc.computed_integer).to be <= right_result.assoc.computed_integer
            end
          end
        end
      end

      context '{ assoc: { boolean: :desc, computed_integer: :desc } }' do
        let(:instructions) do
          { assoc: { 'boolean': :desc, 'computed_integer': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.boolean }).to eq @all_foos.map { |x| x.assoc&.boolean }.sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.boolean == right_result.assoc.boolean
              expect(left_result.assoc.computed_integer).to be >= right_result.assoc.computed_integer
            end
          end
        end
      end

      context '{ assoc: { computed_boolean: :asc, integer: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_boolean': :asc, 'integer': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_boolean }).to eq @all_foos.map { |x| x.assoc&.computed_boolean }.sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_boolean == right_result.assoc.computed_boolean
              expect(left_result.assoc.integer).to be >= right_result.assoc.integer
            end
          end
        end
      end

      context '{ boolean: :desc, assoc: { integer: :asc } }' do
        let(:instructions) do
          { 'boolean': :desc, assoc: { 'integer': :asc } }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.assoc.integer).to be <= right_result.assoc.integer
            end
          end
        end
      end

      context '{ computed_boolean: :asc, assoc: { integer: :asc } }' do
        let(:instructions) do
          { 'computed_boolean': :asc, assoc: { 'integer': :asc } }
        end

        it do
          expect(result.map(&:computed_boolean)).to eq @all_foos.map(&:computed_boolean).sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_boolean == right_result.computed_boolean
              expect(left_result.assoc.integer).to be <= right_result.assoc.integer
            end
          end
        end
      end

      context '{ boolean: :desc, assoc: { computed_integer: :desc } }' do
        let(:instructions) do
          { 'boolean': :desc, assoc: { 'computed_integer': :desc } }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.assoc.computed_integer).to be >= right_result.assoc.computed_integer
            end
          end
        end
      end

      context '{ computed_boolean: :asc, assoc: { computed_integer: :desc } }' do
        let(:instructions) do
          { 'computed_boolean': :asc, assoc: { 'computed_integer': :desc } }
        end

        it do
          expect(result.map(&:computed_boolean)).to eq @all_foos.map(&:computed_boolean).sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_boolean == right_result.computed_boolean
              expect(left_result.assoc.computed_integer).to be >= right_result.assoc.computed_integer
            end
          end
        end
      end

      context '{ assoc: { boolean: :desc }, integer: :asc }' do
        let(:instructions) do
          { assoc: { 'boolean': :desc }, 'integer': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.boolean }).to eq @all_foos.map { |x| x.assoc&.boolean }.sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.boolean == right_result.assoc.boolean
              expect(left_result.integer).to be <= right_result.integer
            end
          end
        end
      end

      context '{ assoc: { computed_boolean: :asc }, computed_integer: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_boolean': :asc }, 'computed_integer': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_boolean }).to eq @all_foos.map { |x| x.assoc&.computed_boolean }.sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_boolean == right_result.assoc.computed_boolean
              expect(left_result.computed_integer).to be <= right_result.computed_integer
            end
          end
        end
      end

      context '{ assoc: { boolean: :asc }, computed_integer: :desc }' do
        let(:instructions) do
          { assoc: { 'boolean': :asc }, 'computed_integer': :desc }
        end

        it do
          expect(result.map { |x| x.assoc&.boolean }).to eq @all_foos.map { |x| x.assoc&.boolean }.sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.boolean == right_result.assoc.boolean
              expect(left_result.computed_integer).to be >= right_result.computed_integer
            end
          end
        end
      end

      context '{ assoc: { computed_boolean: :desc }, integer: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_boolean': :desc }, 'integer': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_boolean }).to eq @all_foos.map { |x| x.assoc&.computed_boolean }.sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_boolean == right_result.assoc.computed_boolean
              expect(left_result.integer).to be <= right_result.integer
            end
          end
        end
      end
    end

    context 'with BOOLEAN and STRING type' do
      context '{ boolean: :asc, string: :asc }' do
        let(:instructions) do
          { 'boolean': :asc, 'string': :asc }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.string).to be <= right_result.string
            end
          end
        end
      end

      context '{ boolean: :desc, string: :desc }' do
        let(:instructions) do
          { 'boolean': :desc, 'string': :desc }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.string).to be >= right_result.string
            end
          end
        end
      end

      context '{ boolean: :asc, string: :desc }' do
        let(:instructions) do
          { 'boolean': :asc, 'string': :desc }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.string).to be >= right_result.string
            end
          end
        end
      end

      context '{ boolean: :desc, string: :asc }' do
        let(:instructions) do
          { 'boolean': :desc, 'string': :asc }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.string).to be <= right_result.string
            end
          end
        end
      end


      context '{ computed_boolean: :asc, computed_string: :asc }' do
        let(:instructions) do
          { 'computed_boolean': :asc, 'computed_string': :asc }
        end

        it do
          expect(result.map(&:computed_boolean)).to eq @all_foos.map(&:computed_boolean).sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_boolean == right_result.computed_boolean
              expect(left_result.computed_string).to be <= right_result.computed_string
            end
          end
        end
      end

      context '{ boolean: :desc, computed_string: :desc }' do
        let(:instructions) do
          { 'boolean': :desc, 'computed_string': :desc }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.computed_string).to be >= right_result.computed_string
            end
          end
        end
      end

      context '{ computed_boolean: :asc, string: :desc }' do
        let(:instructions) do
          { 'computed_boolean': :asc, 'string': :desc }
        end

        it do
          expect(result.map(&:computed_boolean)).to eq @all_foos.map(&:computed_boolean).sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_boolean == right_result.computed_boolean
              expect(left_result.string).to be >= right_result.string
            end
          end
        end
      end

      context '{ assoc: { boolean: :desc, string: :asc } }' do
        let(:instructions) do
          { assoc: { 'boolean': :desc, 'string': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.boolean }).to eq @all_foos.map { |x| x.assoc&.boolean }.sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.boolean == right_result.assoc.boolean
              expect(left_result.assoc.string).to be <= right_result.assoc.string
            end
          end
        end
      end

      context '{ assoc: { computed_boolean: :asc, computed_string: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_boolean': :asc, 'computed_string': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_boolean }).to eq @all_foos.map { |x| x.assoc&.computed_boolean }.sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_boolean == right_result.assoc.computed_boolean
              expect(left_result.assoc.computed_string).to be <= right_result.assoc.computed_string
            end
          end
        end
      end

      context '{ assoc: { boolean: :desc, computed_string: :desc } }' do
        let(:instructions) do
          { assoc: { 'boolean': :desc, 'computed_string': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.boolean }).to eq @all_foos.map { |x| x.assoc&.boolean }.sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.boolean == right_result.assoc.boolean
              expect(left_result.assoc.computed_string).to be >= right_result.assoc.computed_string
            end
          end
        end
      end

      context '{ assoc: { computed_boolean: :asc, string: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_boolean': :asc, 'string': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_boolean }).to eq @all_foos.map { |x| x.assoc&.computed_boolean }.sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_boolean == right_result.assoc.computed_boolean
              expect(left_result.assoc.string).to be >= right_result.assoc.string
            end
          end
        end
      end

      context '{ boolean: :desc, assoc: { string: :asc } }' do
        let(:instructions) do
          { 'boolean': :desc, assoc: { 'string': :asc } }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.assoc.string).to be <= right_result.assoc.string
            end
          end
        end
      end

      context '{ computed_boolean: :asc, assoc: { string: :asc } }' do
        let(:instructions) do
          { 'computed_boolean': :asc, assoc: { 'string': :asc } }
        end

        it do
          expect(result.map(&:computed_boolean)).to eq @all_foos.map(&:computed_boolean).sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_boolean == right_result.computed_boolean
              expect(left_result.assoc.string).to be <= right_result.assoc.string
            end
          end
        end
      end

      context '{ boolean: :desc, assoc: { computed_string: :desc } }' do
        let(:instructions) do
          { 'boolean': :desc, assoc: { 'computed_string': :desc } }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.assoc.computed_string).to be >= right_result.assoc.computed_string
            end
          end
        end
      end

      context '{ computed_boolean: :asc, assoc: { computed_string: :desc } }' do
        let(:instructions) do
          { 'computed_boolean': :asc, assoc: { 'computed_string': :desc } }
        end

        it do
          expect(result.map(&:computed_boolean)).to eq @all_foos.map(&:computed_boolean).sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_boolean == right_result.computed_boolean
              expect(left_result.assoc.computed_string).to be >= right_result.assoc.computed_string
            end
          end
        end
      end

      context '{ assoc: { boolean: :desc }, string: :asc }' do
        let(:instructions) do
          { assoc: { 'boolean': :desc }, 'string': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.boolean }).to eq @all_foos.map { |x| x.assoc&.boolean }.sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.boolean == right_result.assoc.boolean
              expect(left_result.string).to be <= right_result.string
            end
          end
        end
      end

      context '{ assoc: { computed_boolean: :asc }, computed_string: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_boolean': :asc }, 'computed_string': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_boolean }).to eq @all_foos.map { |x| x.assoc&.computed_boolean }.sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_boolean == right_result.assoc.computed_boolean
              expect(left_result.computed_string).to be <= right_result.computed_string
            end
          end
        end
      end

      context '{ assoc: { boolean: :asc }, computed_string: :desc }' do
        let(:instructions) do
          { assoc: { 'boolean': :asc }, 'computed_string': :desc }
        end

        it do
          expect(result.map { |x| x.assoc&.boolean }).to eq @all_foos.map { |x| x.assoc&.boolean }.sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.boolean == right_result.assoc.boolean
              expect(left_result.computed_string).to be >= right_result.computed_string
            end
          end
        end
      end

      context '{ assoc: { computed_boolean: :desc }, string: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_boolean': :desc }, 'string': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_boolean }).to eq @all_foos.map { |x| x.assoc&.computed_boolean }.sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_boolean == right_result.assoc.computed_boolean
              expect(left_result.string).to be <= right_result.string
            end
          end
        end
      end
    end

    context 'with BOOLEAN and TEXT type' do
      context '{ boolean: :asc, text: :asc }' do
        let(:instructions) do
          { 'boolean': :asc, 'text': :asc }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.text).to be <= right_result.text
            end
          end
        end
      end

      context '{ boolean: :desc, text: :desc }' do
        let(:instructions) do
          { 'boolean': :desc, 'text': :desc }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.text).to be >= right_result.text
            end
          end
        end
      end

      context '{ boolean: :asc, text: :desc }' do
        let(:instructions) do
          { 'boolean': :asc, 'text': :desc }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.text).to be >= right_result.text
            end
          end
        end
      end

      context '{ boolean: :desc, text: :asc }' do
        let(:instructions) do
          { 'boolean': :desc, 'text': :asc }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.text).to be <= right_result.text
            end
          end
        end
      end


      context '{ computed_boolean: :asc, computed_text: :asc }' do
        let(:instructions) do
          { 'computed_boolean': :asc, 'computed_text': :asc }
        end

        it do
          expect(result.map(&:computed_boolean)).to eq @all_foos.map(&:computed_boolean).sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_boolean == right_result.computed_boolean
              expect(left_result.computed_text).to be <= right_result.computed_text
            end
          end
        end
      end

      context '{ boolean: :desc, computed_text: :desc }' do
        let(:instructions) do
          { 'boolean': :desc, 'computed_text': :desc }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.computed_text).to be >= right_result.computed_text
            end
          end
        end
      end

      context '{ computed_boolean: :asc, text: :desc }' do
        let(:instructions) do
          { 'computed_boolean': :asc, 'text': :desc }
        end

        it do
          expect(result.map(&:computed_boolean)).to eq @all_foos.map(&:computed_boolean).sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_boolean == right_result.computed_boolean
              expect(left_result.text).to be >= right_result.text
            end
          end
        end
      end

      context '{ assoc: { boolean: :desc, text: :asc } }' do
        let(:instructions) do
          { assoc: { 'boolean': :desc, 'text': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.boolean }).to eq @all_foos.map { |x| x.assoc&.boolean }.sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.boolean == right_result.assoc.boolean
              expect(left_result.assoc.text).to be <= right_result.assoc.text
            end
          end
        end
      end

      context '{ assoc: { computed_boolean: :asc, computed_text: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_boolean': :asc, 'computed_text': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_boolean }).to eq @all_foos.map { |x| x.assoc&.computed_boolean }.sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_boolean == right_result.assoc.computed_boolean
              expect(left_result.assoc.computed_text).to be <= right_result.assoc.computed_text
            end
          end
        end
      end

      context '{ assoc: { boolean: :desc, computed_text: :desc } }' do
        let(:instructions) do
          { assoc: { 'boolean': :desc, 'computed_text': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.boolean }).to eq @all_foos.map { |x| x.assoc&.boolean }.sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.boolean == right_result.assoc.boolean
              expect(left_result.assoc.computed_text).to be >= right_result.assoc.computed_text
            end
          end
        end
      end

      context '{ assoc: { computed_boolean: :asc, text: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_boolean': :asc, 'text': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_boolean }).to eq @all_foos.map { |x| x.assoc&.computed_boolean }.sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_boolean == right_result.assoc.computed_boolean
              expect(left_result.assoc.text).to be >= right_result.assoc.text
            end
          end
        end
      end

      context '{ boolean: :desc, assoc: { text: :asc } }' do
        let(:instructions) do
          { 'boolean': :desc, assoc: { 'text': :asc } }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.assoc.text).to be <= right_result.assoc.text
            end
          end
        end
      end

      context '{ computed_boolean: :asc, assoc: { text: :asc } }' do
        let(:instructions) do
          { 'computed_boolean': :asc, assoc: { 'text': :asc } }
        end

        it do
          expect(result.map(&:computed_boolean)).to eq @all_foos.map(&:computed_boolean).sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_boolean == right_result.computed_boolean
              expect(left_result.assoc.text).to be <= right_result.assoc.text
            end
          end
        end
      end

      context '{ boolean: :desc, assoc: { computed_text: :desc } }' do
        let(:instructions) do
          { 'boolean': :desc, assoc: { 'computed_text': :desc } }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.assoc.computed_text).to be >= right_result.assoc.computed_text
            end
          end
        end
      end

      context '{ computed_boolean: :asc, assoc: { computed_text: :desc } }' do
        let(:instructions) do
          { 'computed_boolean': :asc, assoc: { 'computed_text': :desc } }
        end

        it do
          expect(result.map(&:computed_boolean)).to eq @all_foos.map(&:computed_boolean).sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_boolean == right_result.computed_boolean
              expect(left_result.assoc.computed_text).to be >= right_result.assoc.computed_text
            end
          end
        end
      end

      context '{ assoc: { boolean: :desc }, text: :asc }' do
        let(:instructions) do
          { assoc: { 'boolean': :desc }, 'text': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.boolean }).to eq @all_foos.map { |x| x.assoc&.boolean }.sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.boolean == right_result.assoc.boolean
              expect(left_result.text).to be <= right_result.text
            end
          end
        end
      end

      context '{ assoc: { computed_boolean: :asc }, computed_text: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_boolean': :asc }, 'computed_text': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_boolean }).to eq @all_foos.map { |x| x.assoc&.computed_boolean }.sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_boolean == right_result.assoc.computed_boolean
              expect(left_result.computed_text).to be <= right_result.computed_text
            end
          end
        end
      end

      context '{ assoc: { boolean: :asc }, computed_text: :desc }' do
        let(:instructions) do
          { assoc: { 'boolean': :asc }, 'computed_text': :desc }
        end

        it do
          expect(result.map { |x| x.assoc&.boolean }).to eq @all_foos.map { |x| x.assoc&.boolean }.sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.boolean == right_result.assoc.boolean
              expect(left_result.computed_text).to be >= right_result.computed_text
            end
          end
        end
      end

      context '{ assoc: { computed_boolean: :desc }, text: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_boolean': :desc }, 'text': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_boolean }).to eq @all_foos.map { |x| x.assoc&.computed_boolean }.sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_boolean == right_result.assoc.computed_boolean
              expect(left_result.text).to be <= right_result.text
            end
          end
        end
      end
    end

    context 'with BOOLEAN and TIME type' do
      context '{ boolean: :asc, time: :asc }' do
        let(:instructions) do
          { 'boolean': :asc, 'time': :asc }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.time).to be <= right_result.time
            end
          end
        end
      end

      context '{ boolean: :desc, time: :desc }' do
        let(:instructions) do
          { 'boolean': :desc, 'time': :desc }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.time).to be >= right_result.time
            end
          end
        end
      end

      context '{ boolean: :asc, time: :desc }' do
        let(:instructions) do
          { 'boolean': :asc, 'time': :desc }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.time).to be >= right_result.time
            end
          end
        end
      end

      context '{ boolean: :desc, time: :asc }' do
        let(:instructions) do
          { 'boolean': :desc, 'time': :asc }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.time).to be <= right_result.time
            end
          end
        end
      end


      context '{ computed_boolean: :asc, computed_time: :asc }' do
        let(:instructions) do
          { 'computed_boolean': :asc, 'computed_time': :asc }
        end

        it do
          expect(result.map(&:computed_boolean)).to eq @all_foos.map(&:computed_boolean).sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_boolean == right_result.computed_boolean
              expect(left_result.computed_time).to be <= right_result.computed_time
            end
          end
        end
      end

      context '{ boolean: :desc, computed_time: :desc }' do
        let(:instructions) do
          { 'boolean': :desc, 'computed_time': :desc }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.computed_time).to be >= right_result.computed_time
            end
          end
        end
      end

      context '{ computed_boolean: :asc, time: :desc }' do
        let(:instructions) do
          { 'computed_boolean': :asc, 'time': :desc }
        end

        it do
          expect(result.map(&:computed_boolean)).to eq @all_foos.map(&:computed_boolean).sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_boolean == right_result.computed_boolean
              expect(left_result.time).to be >= right_result.time
            end
          end
        end
      end

      context '{ assoc: { boolean: :desc, time: :asc } }' do
        let(:instructions) do
          { assoc: { 'boolean': :desc, 'time': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.boolean }).to eq @all_foos.map { |x| x.assoc&.boolean }.sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.boolean == right_result.assoc.boolean
              expect(left_result.assoc.time).to be <= right_result.assoc.time
            end
          end
        end
      end

      context '{ assoc: { computed_boolean: :asc, computed_time: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_boolean': :asc, 'computed_time': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_boolean }).to eq @all_foos.map { |x| x.assoc&.computed_boolean }.sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_boolean == right_result.assoc.computed_boolean
              expect(left_result.assoc.computed_time).to be <= right_result.assoc.computed_time
            end
          end
        end
      end

      context '{ assoc: { boolean: :desc, computed_time: :desc } }' do
        let(:instructions) do
          { assoc: { 'boolean': :desc, 'computed_time': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.boolean }).to eq @all_foos.map { |x| x.assoc&.boolean }.sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.boolean == right_result.assoc.boolean
              expect(left_result.assoc.computed_time).to be >= right_result.assoc.computed_time
            end
          end
        end
      end

      context '{ assoc: { computed_boolean: :asc, time: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_boolean': :asc, 'time': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_boolean }).to eq @all_foos.map { |x| x.assoc&.computed_boolean }.sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_boolean == right_result.assoc.computed_boolean
              expect(left_result.assoc.time).to be >= right_result.assoc.time
            end
          end
        end
      end

      context '{ boolean: :desc, assoc: { time: :asc } }' do
        let(:instructions) do
          { 'boolean': :desc, assoc: { 'time': :asc } }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.assoc.time).to be <= right_result.assoc.time
            end
          end
        end
      end

      context '{ computed_boolean: :asc, assoc: { time: :asc } }' do
        let(:instructions) do
          { 'computed_boolean': :asc, assoc: { 'time': :asc } }
        end

        it do
          expect(result.map(&:computed_boolean)).to eq @all_foos.map(&:computed_boolean).sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_boolean == right_result.computed_boolean
              expect(left_result.assoc.time).to be <= right_result.assoc.time
            end
          end
        end
      end

      context '{ boolean: :desc, assoc: { computed_time: :desc } }' do
        let(:instructions) do
          { 'boolean': :desc, assoc: { 'computed_time': :desc } }
        end

        it do
          expect(result.map(&:boolean)).to eq @all_foos.map(&:boolean).sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.boolean == right_result.boolean
              expect(left_result.assoc.computed_time).to be >= right_result.assoc.computed_time
            end
          end
        end
      end

      context '{ computed_boolean: :asc, assoc: { computed_time: :desc } }' do
        let(:instructions) do
          { 'computed_boolean': :asc, assoc: { 'computed_time': :desc } }
        end

        it do
          expect(result.map(&:computed_boolean)).to eq @all_foos.map(&:computed_boolean).sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_boolean == right_result.computed_boolean
              expect(left_result.assoc.computed_time).to be >= right_result.assoc.computed_time
            end
          end
        end
      end

      context '{ assoc: { boolean: :desc }, time: :asc }' do
        let(:instructions) do
          { assoc: { 'boolean': :desc }, 'time': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.boolean }).to eq @all_foos.map { |x| x.assoc&.boolean }.sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.boolean == right_result.assoc.boolean
              expect(left_result.time).to be <= right_result.time
            end
          end
        end
      end

      context '{ assoc: { computed_boolean: :asc }, computed_time: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_boolean': :asc }, 'computed_time': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_boolean }).to eq @all_foos.map { |x| x.assoc&.computed_boolean }.sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_boolean == right_result.assoc.computed_boolean
              expect(left_result.computed_time).to be <= right_result.computed_time
            end
          end
        end
      end

      context '{ assoc: { boolean: :asc }, computed_time: :desc }' do
        let(:instructions) do
          { assoc: { 'boolean': :asc }, 'computed_time': :desc }
        end

        it do
          expect(result.map { |x| x.assoc&.boolean }).to eq @all_foos.map { |x| x.assoc&.boolean }.sort_by { |bool| bool ? 1 : 0 }

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.boolean == right_result.assoc.boolean
              expect(left_result.computed_time).to be >= right_result.computed_time
            end
          end
        end
      end

      context '{ assoc: { computed_boolean: :desc }, time: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_boolean': :desc }, 'time': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_boolean }).to eq @all_foos.map { |x| x.assoc&.computed_boolean }.sort_by { |bool| bool ? 1 : 0 }.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_boolean == right_result.assoc.computed_boolean
              expect(left_result.time).to be <= right_result.time
            end
          end
        end
      end
    end


    context 'with DATE and DATETIME type' do
      context '{ date: :asc, datetime: :asc }' do
        let(:instructions) do
          { 'date': :asc, 'datetime': :asc }
        end

        it do
          expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.date == right_result.date
              expect(left_result.datetime).to be <= right_result.datetime
            end
          end
        end
      end

      context '{ date: :desc, datetime: :desc }' do
        let(:instructions) do
          { 'date': :desc, 'datetime': :desc }
        end

        it do
          expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.date == right_result.date
              expect(left_result.datetime).to be >= right_result.datetime
            end
          end
        end
      end

      context '{ date: :asc, datetime: :desc }' do
        let(:instructions) do
          { 'date': :asc, 'datetime': :desc }
        end

        it do
          expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.date == right_result.date
              expect(left_result.datetime).to be >= right_result.datetime
            end
          end
        end
      end

      context '{ date: :desc, datetime: :asc }' do
        let(:instructions) do
          { 'date': :desc, 'datetime': :asc }
        end

        it do
          expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.date == right_result.date
              expect(left_result.datetime).to be <= right_result.datetime
            end
          end
        end
      end


      context '{ computed_date: :asc, computed_datetime: :asc }' do
        let(:instructions) do
          { 'computed_date': :asc, 'computed_datetime': :asc }
        end

        it do
          expect(result.map(&:computed_date)).to eq @all_foos.map(&:computed_date).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_date == right_result.computed_date
              expect(left_result.computed_datetime).to be <= right_result.computed_datetime
            end
          end
        end
      end

      context '{ date: :desc, computed_datetime: :desc }' do
        let(:instructions) do
          { 'date': :desc, 'computed_datetime': :desc }
        end

        it do
          expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.date == right_result.date
              expect(left_result.computed_datetime).to be >= right_result.computed_datetime
            end
          end
        end
      end

      context '{ computed_date: :asc, datetime: :desc }' do
        let(:instructions) do
          { 'computed_date': :asc, 'datetime': :desc }
        end

        it do
          expect(result.map(&:computed_date)).to eq @all_foos.map(&:computed_date).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_date == right_result.computed_date
              expect(left_result.datetime).to be >= right_result.datetime
            end
          end
        end
      end

      context '{ assoc: { date: :desc, datetime: :asc } }' do
        let(:instructions) do
          { assoc: { 'date': :desc, 'datetime': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.date }).to eq @all_foos.map { |x| x.assoc&.date }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.date == right_result.assoc.date
              expect(left_result.assoc.datetime).to be <= right_result.assoc.datetime
            end
          end
        end
      end

      context '{ assoc: { computed_date: :asc, computed_datetime: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_date': :asc, 'computed_datetime': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_date }).to eq @all_foos.map { |x| x.assoc&.computed_date }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_date == right_result.assoc.computed_date
              expect(left_result.assoc.computed_datetime).to be <= right_result.assoc.computed_datetime
            end
          end
        end
      end

      context '{ assoc: { date: :desc, computed_datetime: :desc } }' do
        let(:instructions) do
          { assoc: { 'date': :desc, 'computed_datetime': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.date }).to eq @all_foos.map { |x| x.assoc&.date }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.date == right_result.assoc.date
              expect(left_result.assoc.computed_datetime).to be >= right_result.assoc.computed_datetime
            end
          end
        end
      end

      context '{ assoc: { computed_date: :asc, datetime: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_date': :asc, 'datetime': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_date }).to eq @all_foos.map { |x| x.assoc&.computed_date }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_date == right_result.assoc.computed_date
              expect(left_result.assoc.datetime).to be >= right_result.assoc.datetime
            end
          end
        end
      end

      context '{ date: :desc, assoc: { datetime: :asc } }' do
        let(:instructions) do
          { 'date': :desc, assoc: { 'datetime': :asc } }
        end

        it do
          expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.date == right_result.date
              expect(left_result.assoc.datetime).to be <= right_result.assoc.datetime
            end
          end
        end
      end

      context '{ computed_date: :asc, assoc: { datetime: :asc } }' do
        let(:instructions) do
          { 'computed_date': :asc, assoc: { 'datetime': :asc } }
        end

        it do
          expect(result.map(&:computed_date)).to eq @all_foos.map(&:computed_date).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_date == right_result.computed_date
              expect(left_result.assoc.datetime).to be <= right_result.assoc.datetime
            end
          end
        end
      end

      context '{ date: :desc, assoc: { computed_datetime: :desc } }' do
        let(:instructions) do
          { 'date': :desc, assoc: { 'computed_datetime': :desc } }
        end

        it do
          expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.date == right_result.date
              expect(left_result.assoc.computed_datetime).to be >= right_result.assoc.computed_datetime
            end
          end
        end
      end

      context '{ computed_date: :asc, assoc: { computed_datetime: :desc } }' do
        let(:instructions) do
          { 'computed_date': :asc, assoc: { 'computed_datetime': :desc } }
        end

        it do
          expect(result.map(&:computed_date)).to eq @all_foos.map(&:computed_date).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_date == right_result.computed_date
              expect(left_result.assoc.computed_datetime).to be >= right_result.assoc.computed_datetime
            end
          end
        end
      end

      context '{ assoc: { date: :desc }, datetime: :asc }' do
        let(:instructions) do
          { assoc: { 'date': :desc }, 'datetime': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.date }).to eq @all_foos.map { |x| x.assoc&.date }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.date == right_result.assoc.date
              expect(left_result.datetime).to be <= right_result.datetime
            end
          end
        end
      end

      context '{ assoc: { computed_date: :asc }, computed_datetime: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_date': :asc }, 'computed_datetime': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_date }).to eq @all_foos.map { |x| x.assoc&.computed_date }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_date == right_result.assoc.computed_date
              expect(left_result.computed_datetime).to be <= right_result.computed_datetime
            end
          end
        end
      end

      context '{ assoc: { date: :asc }, computed_datetime: :desc }' do
        let(:instructions) do
          { assoc: { 'date': :asc }, 'computed_datetime': :desc }
        end

        it do
          expect(result.map { |x| x.assoc&.date }).to eq @all_foos.map { |x| x.assoc&.date }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.date == right_result.assoc.date
              expect(left_result.computed_datetime).to be >= right_result.computed_datetime
            end
          end
        end
      end

      context '{ assoc: { computed_date: :desc }, datetime: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_date': :desc }, 'datetime': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_date }).to eq @all_foos.map { |x| x.assoc&.computed_date }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_date == right_result.assoc.computed_date
              expect(left_result.datetime).to be <= right_result.datetime
            end
          end
        end
      end
    end

    context 'with DATE and DECIMAL type' do
      context '{ date: :asc, decimal: :asc }' do
        let(:instructions) do
          { 'date': :asc, 'decimal': :asc }
        end

        it do
          expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.date == right_result.date
              expect(left_result.decimal).to be <= right_result.decimal
            end
          end
        end
      end

      context '{ date: :desc, decimal: :desc }' do
        let(:instructions) do
          { 'date': :desc, 'decimal': :desc }
        end

        it do
          expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.date == right_result.date
              expect(left_result.decimal).to be >= right_result.decimal
            end
          end
        end
      end

      context '{ date: :asc, decimal: :desc }' do
        let(:instructions) do
          { 'date': :asc, 'decimal': :desc }
        end

        it do
          expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.date == right_result.date
              expect(left_result.decimal).to be >= right_result.decimal
            end
          end
        end
      end

      context '{ date: :desc, decimal: :asc }' do
        let(:instructions) do
          { 'date': :desc, 'decimal': :asc }
        end

        it do
          expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.date == right_result.date
              expect(left_result.decimal).to be <= right_result.decimal
            end
          end
        end
      end


      context '{ computed_date: :asc, computed_decimal: :asc }' do
        let(:instructions) do
          { 'computed_date': :asc, 'computed_decimal': :asc }
        end

        it do
          expect(result.map(&:computed_date)).to eq @all_foos.map(&:computed_date).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_date == right_result.computed_date
              expect(left_result.computed_decimal).to be <= right_result.computed_decimal
            end
          end
        end
      end

      context '{ date: :desc, computed_decimal: :desc }' do
        let(:instructions) do
          { 'date': :desc, 'computed_decimal': :desc }
        end

        it do
          expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.date == right_result.date
              expect(left_result.computed_decimal).to be >= right_result.computed_decimal
            end
          end
        end
      end

      context '{ computed_date: :asc, decimal: :desc }' do
        let(:instructions) do
          { 'computed_date': :asc, 'decimal': :desc }
        end

        it do
          expect(result.map(&:computed_date)).to eq @all_foos.map(&:computed_date).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_date == right_result.computed_date
              expect(left_result.decimal).to be >= right_result.decimal
            end
          end
        end
      end

      context '{ assoc: { date: :desc, decimal: :asc } }' do
        let(:instructions) do
          { assoc: { 'date': :desc, 'decimal': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.date }).to eq @all_foos.map { |x| x.assoc&.date }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.date == right_result.assoc.date
              expect(left_result.assoc.decimal).to be <= right_result.assoc.decimal
            end
          end
        end
      end

      context '{ assoc: { computed_date: :asc, computed_decimal: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_date': :asc, 'computed_decimal': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_date }).to eq @all_foos.map { |x| x.assoc&.computed_date }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_date == right_result.assoc.computed_date
              expect(left_result.assoc.computed_decimal).to be <= right_result.assoc.computed_decimal
            end
          end
        end
      end

      context '{ assoc: { date: :desc, computed_decimal: :desc } }' do
        let(:instructions) do
          { assoc: { 'date': :desc, 'computed_decimal': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.date }).to eq @all_foos.map { |x| x.assoc&.date }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.date == right_result.assoc.date
              expect(left_result.assoc.computed_decimal).to be >= right_result.assoc.computed_decimal
            end
          end
        end
      end

      context '{ assoc: { computed_date: :asc, decimal: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_date': :asc, 'decimal': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_date }).to eq @all_foos.map { |x| x.assoc&.computed_date }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_date == right_result.assoc.computed_date
              expect(left_result.assoc.decimal).to be >= right_result.assoc.decimal
            end
          end
        end
      end

      context '{ date: :desc, assoc: { decimal: :asc } }' do
        let(:instructions) do
          { 'date': :desc, assoc: { 'decimal': :asc } }
        end

        it do
          expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.date == right_result.date
              expect(left_result.assoc.decimal).to be <= right_result.assoc.decimal
            end
          end
        end
      end

      context '{ computed_date: :asc, assoc: { decimal: :asc } }' do
        let(:instructions) do
          { 'computed_date': :asc, assoc: { 'decimal': :asc } }
        end

        it do
          expect(result.map(&:computed_date)).to eq @all_foos.map(&:computed_date).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_date == right_result.computed_date
              expect(left_result.assoc.decimal).to be <= right_result.assoc.decimal
            end
          end
        end
      end

      context '{ date: :desc, assoc: { computed_decimal: :desc } }' do
        let(:instructions) do
          { 'date': :desc, assoc: { 'computed_decimal': :desc } }
        end

        it do
          expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.date == right_result.date
              expect(left_result.assoc.computed_decimal).to be >= right_result.assoc.computed_decimal
            end
          end
        end
      end

      context '{ computed_date: :asc, assoc: { computed_decimal: :desc } }' do
        let(:instructions) do
          { 'computed_date': :asc, assoc: { 'computed_decimal': :desc } }
        end

        it do
          expect(result.map(&:computed_date)).to eq @all_foos.map(&:computed_date).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_date == right_result.computed_date
              expect(left_result.assoc.computed_decimal).to be >= right_result.assoc.computed_decimal
            end
          end
        end
      end

      context '{ assoc: { date: :desc }, decimal: :asc }' do
        let(:instructions) do
          { assoc: { 'date': :desc }, 'decimal': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.date }).to eq @all_foos.map { |x| x.assoc&.date }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.date == right_result.assoc.date
              expect(left_result.decimal).to be <= right_result.decimal
            end
          end
        end
      end

      context '{ assoc: { computed_date: :asc }, computed_decimal: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_date': :asc }, 'computed_decimal': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_date }).to eq @all_foos.map { |x| x.assoc&.computed_date }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_date == right_result.assoc.computed_date
              expect(left_result.computed_decimal).to be <= right_result.computed_decimal
            end
          end
        end
      end

      context '{ assoc: { date: :asc }, computed_decimal: :desc }' do
        let(:instructions) do
          { assoc: { 'date': :asc }, 'computed_decimal': :desc }
        end

        it do
          expect(result.map { |x| x.assoc&.date }).to eq @all_foos.map { |x| x.assoc&.date }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.date == right_result.assoc.date
              expect(left_result.computed_decimal).to be >= right_result.computed_decimal
            end
          end
        end
      end

      context '{ assoc: { computed_date: :desc }, decimal: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_date': :desc }, 'decimal': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_date }).to eq @all_foos.map { |x| x.assoc&.computed_date }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_date == right_result.assoc.computed_date
              expect(left_result.decimal).to be <= right_result.decimal
            end
          end
        end
      end
    end

    context 'with DATE and FLOAT type' do
      context '{ date: :asc, float: :asc }' do
        let(:instructions) do
          { 'date': :asc, 'float': :asc }
        end

        it do
          expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.date == right_result.date
              expect(left_result.float).to be <= right_result.float
            end
          end
        end
      end

      context '{ date: :desc, float: :desc }' do
        let(:instructions) do
          { 'date': :desc, 'float': :desc }
        end

        it do
          expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.date == right_result.date
              expect(left_result.float).to be >= right_result.float
            end
          end
        end
      end

      context '{ date: :asc, float: :desc }' do
        let(:instructions) do
          { 'date': :asc, 'float': :desc }
        end

        it do
          expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.date == right_result.date
              expect(left_result.float).to be >= right_result.float
            end
          end
        end
      end

      context '{ date: :desc, float: :asc }' do
        let(:instructions) do
          { 'date': :desc, 'float': :asc }
        end

        it do
          expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.date == right_result.date
              expect(left_result.float).to be <= right_result.float
            end
          end
        end
      end


      context '{ computed_date: :asc, computed_float: :asc }' do
        let(:instructions) do
          { 'computed_date': :asc, 'computed_float': :asc }
        end

        it do
          expect(result.map(&:computed_date)).to eq @all_foos.map(&:computed_date).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_date == right_result.computed_date
              expect(left_result.computed_float).to be <= right_result.computed_float
            end
          end
        end
      end

      context '{ date: :desc, computed_float: :desc }' do
        let(:instructions) do
          { 'date': :desc, 'computed_float': :desc }
        end

        it do
          expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.date == right_result.date
              expect(left_result.computed_float).to be >= right_result.computed_float
            end
          end
        end
      end

      context '{ computed_date: :asc, float: :desc }' do
        let(:instructions) do
          { 'computed_date': :asc, 'float': :desc }
        end

        it do
          expect(result.map(&:computed_date)).to eq @all_foos.map(&:computed_date).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_date == right_result.computed_date
              expect(left_result.float).to be >= right_result.float
            end
          end
        end
      end

      context '{ assoc: { date: :desc, float: :asc } }' do
        let(:instructions) do
          { assoc: { 'date': :desc, 'float': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.date }).to eq @all_foos.map { |x| x.assoc&.date }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.date == right_result.assoc.date
              expect(left_result.assoc.float).to be <= right_result.assoc.float
            end
          end
        end
      end

      context '{ assoc: { computed_date: :asc, computed_float: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_date': :asc, 'computed_float': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_date }).to eq @all_foos.map { |x| x.assoc&.computed_date }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_date == right_result.assoc.computed_date
              expect(left_result.assoc.computed_float).to be <= right_result.assoc.computed_float
            end
          end
        end
      end

      context '{ assoc: { date: :desc, computed_float: :desc } }' do
        let(:instructions) do
          { assoc: { 'date': :desc, 'computed_float': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.date }).to eq @all_foos.map { |x| x.assoc&.date }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.date == right_result.assoc.date
              expect(left_result.assoc.computed_float).to be >= right_result.assoc.computed_float
            end
          end
        end
      end

      context '{ assoc: { computed_date: :asc, float: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_date': :asc, 'float': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_date }).to eq @all_foos.map { |x| x.assoc&.computed_date }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_date == right_result.assoc.computed_date
              expect(left_result.assoc.float).to be >= right_result.assoc.float
            end
          end
        end
      end

      context '{ date: :desc, assoc: { float: :asc } }' do
        let(:instructions) do
          { 'date': :desc, assoc: { 'float': :asc } }
        end

        it do
          expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.date == right_result.date
              expect(left_result.assoc.float).to be <= right_result.assoc.float
            end
          end
        end
      end

      context '{ computed_date: :asc, assoc: { float: :asc } }' do
        let(:instructions) do
          { 'computed_date': :asc, assoc: { 'float': :asc } }
        end

        it do
          expect(result.map(&:computed_date)).to eq @all_foos.map(&:computed_date).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_date == right_result.computed_date
              expect(left_result.assoc.float).to be <= right_result.assoc.float
            end
          end
        end
      end

      context '{ date: :desc, assoc: { computed_float: :desc } }' do
        let(:instructions) do
          { 'date': :desc, assoc: { 'computed_float': :desc } }
        end

        it do
          expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.date == right_result.date
              expect(left_result.assoc.computed_float).to be >= right_result.assoc.computed_float
            end
          end
        end
      end

      context '{ computed_date: :asc, assoc: { computed_float: :desc } }' do
        let(:instructions) do
          { 'computed_date': :asc, assoc: { 'computed_float': :desc } }
        end

        it do
          expect(result.map(&:computed_date)).to eq @all_foos.map(&:computed_date).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_date == right_result.computed_date
              expect(left_result.assoc.computed_float).to be >= right_result.assoc.computed_float
            end
          end
        end
      end

      context '{ assoc: { date: :desc }, float: :asc }' do
        let(:instructions) do
          { assoc: { 'date': :desc }, 'float': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.date }).to eq @all_foos.map { |x| x.assoc&.date }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.date == right_result.assoc.date
              expect(left_result.float).to be <= right_result.float
            end
          end
        end
      end

      context '{ assoc: { computed_date: :asc }, computed_float: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_date': :asc }, 'computed_float': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_date }).to eq @all_foos.map { |x| x.assoc&.computed_date }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_date == right_result.assoc.computed_date
              expect(left_result.computed_float).to be <= right_result.computed_float
            end
          end
        end
      end

      context '{ assoc: { date: :asc }, computed_float: :desc }' do
        let(:instructions) do
          { assoc: { 'date': :asc }, 'computed_float': :desc }
        end

        it do
          expect(result.map { |x| x.assoc&.date }).to eq @all_foos.map { |x| x.assoc&.date }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.date == right_result.assoc.date
              expect(left_result.computed_float).to be >= right_result.computed_float
            end
          end
        end
      end

      context '{ assoc: { computed_date: :desc }, float: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_date': :desc }, 'float': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_date }).to eq @all_foos.map { |x| x.assoc&.computed_date }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_date == right_result.assoc.computed_date
              expect(left_result.float).to be <= right_result.float
            end
          end
        end
      end
    end

    context 'with DATE and INTEGER type' do
      context '{ date: :asc, integer: :asc }' do
        let(:instructions) do
          { 'date': :asc, 'integer': :asc }
        end

        it do
          expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.date == right_result.date
              expect(left_result.integer).to be <= right_result.integer
            end
          end
        end
      end

      context '{ date: :desc, integer: :desc }' do
        let(:instructions) do
          { 'date': :desc, 'integer': :desc }
        end

        it do
          expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.date == right_result.date
              expect(left_result.integer).to be >= right_result.integer
            end
          end
        end
      end

      context '{ date: :asc, integer: :desc }' do
        let(:instructions) do
          { 'date': :asc, 'integer': :desc }
        end

        it do
          expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.date == right_result.date
              expect(left_result.integer).to be >= right_result.integer
            end
          end
        end
      end

      context '{ date: :desc, integer: :asc }' do
        let(:instructions) do
          { 'date': :desc, 'integer': :asc }
        end

        it do
          expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.date == right_result.date
              expect(left_result.integer).to be <= right_result.integer
            end
          end
        end
      end


      context '{ computed_date: :asc, computed_integer: :asc }' do
        let(:instructions) do
          { 'computed_date': :asc, 'computed_integer': :asc }
        end

        it do
          expect(result.map(&:computed_date)).to eq @all_foos.map(&:computed_date).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_date == right_result.computed_date
              expect(left_result.computed_integer).to be <= right_result.computed_integer
            end
          end
        end
      end

      context '{ date: :desc, computed_integer: :desc }' do
        let(:instructions) do
          { 'date': :desc, 'computed_integer': :desc }
        end

        it do
          expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.date == right_result.date
              expect(left_result.computed_integer).to be >= right_result.computed_integer
            end
          end
        end
      end

      context '{ computed_date: :asc, integer: :desc }' do
        let(:instructions) do
          { 'computed_date': :asc, 'integer': :desc }
        end

        it do
          expect(result.map(&:computed_date)).to eq @all_foos.map(&:computed_date).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_date == right_result.computed_date
              expect(left_result.integer).to be >= right_result.integer
            end
          end
        end
      end

      context '{ assoc: { date: :desc, integer: :asc } }' do
        let(:instructions) do
          { assoc: { 'date': :desc, 'integer': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.date }).to eq @all_foos.map { |x| x.assoc&.date }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.date == right_result.assoc.date
              expect(left_result.assoc.integer).to be <= right_result.assoc.integer
            end
          end
        end
      end

      context '{ assoc: { computed_date: :asc, computed_integer: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_date': :asc, 'computed_integer': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_date }).to eq @all_foos.map { |x| x.assoc&.computed_date }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_date == right_result.assoc.computed_date
              expect(left_result.assoc.computed_integer).to be <= right_result.assoc.computed_integer
            end
          end
        end
      end

      context '{ assoc: { date: :desc, computed_integer: :desc } }' do
        let(:instructions) do
          { assoc: { 'date': :desc, 'computed_integer': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.date }).to eq @all_foos.map { |x| x.assoc&.date }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.date == right_result.assoc.date
              expect(left_result.assoc.computed_integer).to be >= right_result.assoc.computed_integer
            end
          end
        end
      end

      context '{ assoc: { computed_date: :asc, integer: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_date': :asc, 'integer': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_date }).to eq @all_foos.map { |x| x.assoc&.computed_date }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_date == right_result.assoc.computed_date
              expect(left_result.assoc.integer).to be >= right_result.assoc.integer
            end
          end
        end
      end

      context '{ date: :desc, assoc: { integer: :asc } }' do
        let(:instructions) do
          { 'date': :desc, assoc: { 'integer': :asc } }
        end

        it do
          expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.date == right_result.date
              expect(left_result.assoc.integer).to be <= right_result.assoc.integer
            end
          end
        end
      end

      context '{ computed_date: :asc, assoc: { integer: :asc } }' do
        let(:instructions) do
          { 'computed_date': :asc, assoc: { 'integer': :asc } }
        end

        it do
          expect(result.map(&:computed_date)).to eq @all_foos.map(&:computed_date).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_date == right_result.computed_date
              expect(left_result.assoc.integer).to be <= right_result.assoc.integer
            end
          end
        end
      end

      context '{ date: :desc, assoc: { computed_integer: :desc } }' do
        let(:instructions) do
          { 'date': :desc, assoc: { 'computed_integer': :desc } }
        end

        it do
          expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.date == right_result.date
              expect(left_result.assoc.computed_integer).to be >= right_result.assoc.computed_integer
            end
          end
        end
      end

      context '{ computed_date: :asc, assoc: { computed_integer: :desc } }' do
        let(:instructions) do
          { 'computed_date': :asc, assoc: { 'computed_integer': :desc } }
        end

        it do
          expect(result.map(&:computed_date)).to eq @all_foos.map(&:computed_date).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_date == right_result.computed_date
              expect(left_result.assoc.computed_integer).to be >= right_result.assoc.computed_integer
            end
          end
        end
      end

      context '{ assoc: { date: :desc }, integer: :asc }' do
        let(:instructions) do
          { assoc: { 'date': :desc }, 'integer': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.date }).to eq @all_foos.map { |x| x.assoc&.date }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.date == right_result.assoc.date
              expect(left_result.integer).to be <= right_result.integer
            end
          end
        end
      end

      context '{ assoc: { computed_date: :asc }, computed_integer: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_date': :asc }, 'computed_integer': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_date }).to eq @all_foos.map { |x| x.assoc&.computed_date }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_date == right_result.assoc.computed_date
              expect(left_result.computed_integer).to be <= right_result.computed_integer
            end
          end
        end
      end

      context '{ assoc: { date: :asc }, computed_integer: :desc }' do
        let(:instructions) do
          { assoc: { 'date': :asc }, 'computed_integer': :desc }
        end

        it do
          expect(result.map { |x| x.assoc&.date }).to eq @all_foos.map { |x| x.assoc&.date }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.date == right_result.assoc.date
              expect(left_result.computed_integer).to be >= right_result.computed_integer
            end
          end
        end
      end

      context '{ assoc: { computed_date: :desc }, integer: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_date': :desc }, 'integer': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_date }).to eq @all_foos.map { |x| x.assoc&.computed_date }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_date == right_result.assoc.computed_date
              expect(left_result.integer).to be <= right_result.integer
            end
          end
        end
      end
    end

    context 'with DATE and STRING type' do
      context '{ date: :asc, string: :asc }' do
        let(:instructions) do
          { 'date': :asc, 'string': :asc }
        end

        it do
          expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.date == right_result.date
              expect(left_result.string).to be <= right_result.string
            end
          end
        end
      end

      context '{ date: :desc, string: :desc }' do
        let(:instructions) do
          { 'date': :desc, 'string': :desc }
        end

        it do
          expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.date == right_result.date
              expect(left_result.string).to be >= right_result.string
            end
          end
        end
      end

      context '{ date: :asc, string: :desc }' do
        let(:instructions) do
          { 'date': :asc, 'string': :desc }
        end

        it do
          expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.date == right_result.date
              expect(left_result.string).to be >= right_result.string
            end
          end
        end
      end

      context '{ date: :desc, string: :asc }' do
        let(:instructions) do
          { 'date': :desc, 'string': :asc }
        end

        it do
          expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.date == right_result.date
              expect(left_result.string).to be <= right_result.string
            end
          end
        end
      end


      context '{ computed_date: :asc, computed_string: :asc }' do
        let(:instructions) do
          { 'computed_date': :asc, 'computed_string': :asc }
        end

        it do
          expect(result.map(&:computed_date)).to eq @all_foos.map(&:computed_date).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_date == right_result.computed_date
              expect(left_result.computed_string).to be <= right_result.computed_string
            end
          end
        end
      end

      context '{ date: :desc, computed_string: :desc }' do
        let(:instructions) do
          { 'date': :desc, 'computed_string': :desc }
        end

        it do
          expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.date == right_result.date
              expect(left_result.computed_string).to be >= right_result.computed_string
            end
          end
        end
      end

      context '{ computed_date: :asc, string: :desc }' do
        let(:instructions) do
          { 'computed_date': :asc, 'string': :desc }
        end

        it do
          expect(result.map(&:computed_date)).to eq @all_foos.map(&:computed_date).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_date == right_result.computed_date
              expect(left_result.string).to be >= right_result.string
            end
          end
        end
      end

      context '{ assoc: { date: :desc, string: :asc } }' do
        let(:instructions) do
          { assoc: { 'date': :desc, 'string': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.date }).to eq @all_foos.map { |x| x.assoc&.date }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.date == right_result.assoc.date
              expect(left_result.assoc.string).to be <= right_result.assoc.string
            end
          end
        end
      end

      context '{ assoc: { computed_date: :asc, computed_string: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_date': :asc, 'computed_string': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_date }).to eq @all_foos.map { |x| x.assoc&.computed_date }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_date == right_result.assoc.computed_date
              expect(left_result.assoc.computed_string).to be <= right_result.assoc.computed_string
            end
          end
        end
      end

      context '{ assoc: { date: :desc, computed_string: :desc } }' do
        let(:instructions) do
          { assoc: { 'date': :desc, 'computed_string': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.date }).to eq @all_foos.map { |x| x.assoc&.date }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.date == right_result.assoc.date
              expect(left_result.assoc.computed_string).to be >= right_result.assoc.computed_string
            end
          end
        end
      end

      context '{ assoc: { computed_date: :asc, string: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_date': :asc, 'string': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_date }).to eq @all_foos.map { |x| x.assoc&.computed_date }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_date == right_result.assoc.computed_date
              expect(left_result.assoc.string).to be >= right_result.assoc.string
            end
          end
        end
      end

      context '{ date: :desc, assoc: { string: :asc } }' do
        let(:instructions) do
          { 'date': :desc, assoc: { 'string': :asc } }
        end

        it do
          expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.date == right_result.date
              expect(left_result.assoc.string).to be <= right_result.assoc.string
            end
          end
        end
      end

      context '{ computed_date: :asc, assoc: { string: :asc } }' do
        let(:instructions) do
          { 'computed_date': :asc, assoc: { 'string': :asc } }
        end

        it do
          expect(result.map(&:computed_date)).to eq @all_foos.map(&:computed_date).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_date == right_result.computed_date
              expect(left_result.assoc.string).to be <= right_result.assoc.string
            end
          end
        end
      end

      context '{ date: :desc, assoc: { computed_string: :desc } }' do
        let(:instructions) do
          { 'date': :desc, assoc: { 'computed_string': :desc } }
        end

        it do
          expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.date == right_result.date
              expect(left_result.assoc.computed_string).to be >= right_result.assoc.computed_string
            end
          end
        end
      end

      context '{ computed_date: :asc, assoc: { computed_string: :desc } }' do
        let(:instructions) do
          { 'computed_date': :asc, assoc: { 'computed_string': :desc } }
        end

        it do
          expect(result.map(&:computed_date)).to eq @all_foos.map(&:computed_date).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_date == right_result.computed_date
              expect(left_result.assoc.computed_string).to be >= right_result.assoc.computed_string
            end
          end
        end
      end

      context '{ assoc: { date: :desc }, string: :asc }' do
        let(:instructions) do
          { assoc: { 'date': :desc }, 'string': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.date }).to eq @all_foos.map { |x| x.assoc&.date }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.date == right_result.assoc.date
              expect(left_result.string).to be <= right_result.string
            end
          end
        end
      end

      context '{ assoc: { computed_date: :asc }, computed_string: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_date': :asc }, 'computed_string': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_date }).to eq @all_foos.map { |x| x.assoc&.computed_date }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_date == right_result.assoc.computed_date
              expect(left_result.computed_string).to be <= right_result.computed_string
            end
          end
        end
      end

      context '{ assoc: { date: :asc }, computed_string: :desc }' do
        let(:instructions) do
          { assoc: { 'date': :asc }, 'computed_string': :desc }
        end

        it do
          expect(result.map { |x| x.assoc&.date }).to eq @all_foos.map { |x| x.assoc&.date }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.date == right_result.assoc.date
              expect(left_result.computed_string).to be >= right_result.computed_string
            end
          end
        end
      end

      context '{ assoc: { computed_date: :desc }, string: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_date': :desc }, 'string': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_date }).to eq @all_foos.map { |x| x.assoc&.computed_date }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_date == right_result.assoc.computed_date
              expect(left_result.string).to be <= right_result.string
            end
          end
        end
      end
    end

    context 'with DATE and TEXT type' do
      context '{ date: :asc, text: :asc }' do
        let(:instructions) do
          { 'date': :asc, 'text': :asc }
        end

        it do
          expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.date == right_result.date
              expect(left_result.text).to be <= right_result.text
            end
          end
        end
      end

      context '{ date: :desc, text: :desc }' do
        let(:instructions) do
          { 'date': :desc, 'text': :desc }
        end

        it do
          expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.date == right_result.date
              expect(left_result.text).to be >= right_result.text
            end
          end
        end
      end

      context '{ date: :asc, text: :desc }' do
        let(:instructions) do
          { 'date': :asc, 'text': :desc }
        end

        it do
          expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.date == right_result.date
              expect(left_result.text).to be >= right_result.text
            end
          end
        end
      end

      context '{ date: :desc, text: :asc }' do
        let(:instructions) do
          { 'date': :desc, 'text': :asc }
        end

        it do
          expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.date == right_result.date
              expect(left_result.text).to be <= right_result.text
            end
          end
        end
      end


      context '{ computed_date: :asc, computed_text: :asc }' do
        let(:instructions) do
          { 'computed_date': :asc, 'computed_text': :asc }
        end

        it do
          expect(result.map(&:computed_date)).to eq @all_foos.map(&:computed_date).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_date == right_result.computed_date
              expect(left_result.computed_text).to be <= right_result.computed_text
            end
          end
        end
      end

      context '{ date: :desc, computed_text: :desc }' do
        let(:instructions) do
          { 'date': :desc, 'computed_text': :desc }
        end

        it do
          expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.date == right_result.date
              expect(left_result.computed_text).to be >= right_result.computed_text
            end
          end
        end
      end

      context '{ computed_date: :asc, text: :desc }' do
        let(:instructions) do
          { 'computed_date': :asc, 'text': :desc }
        end

        it do
          expect(result.map(&:computed_date)).to eq @all_foos.map(&:computed_date).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_date == right_result.computed_date
              expect(left_result.text).to be >= right_result.text
            end
          end
        end
      end

      context '{ assoc: { date: :desc, text: :asc } }' do
        let(:instructions) do
          { assoc: { 'date': :desc, 'text': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.date }).to eq @all_foos.map { |x| x.assoc&.date }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.date == right_result.assoc.date
              expect(left_result.assoc.text).to be <= right_result.assoc.text
            end
          end
        end
      end

      context '{ assoc: { computed_date: :asc, computed_text: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_date': :asc, 'computed_text': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_date }).to eq @all_foos.map { |x| x.assoc&.computed_date }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_date == right_result.assoc.computed_date
              expect(left_result.assoc.computed_text).to be <= right_result.assoc.computed_text
            end
          end
        end
      end

      context '{ assoc: { date: :desc, computed_text: :desc } }' do
        let(:instructions) do
          { assoc: { 'date': :desc, 'computed_text': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.date }).to eq @all_foos.map { |x| x.assoc&.date }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.date == right_result.assoc.date
              expect(left_result.assoc.computed_text).to be >= right_result.assoc.computed_text
            end
          end
        end
      end

      context '{ assoc: { computed_date: :asc, text: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_date': :asc, 'text': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_date }).to eq @all_foos.map { |x| x.assoc&.computed_date }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_date == right_result.assoc.computed_date
              expect(left_result.assoc.text).to be >= right_result.assoc.text
            end
          end
        end
      end

      context '{ date: :desc, assoc: { text: :asc } }' do
        let(:instructions) do
          { 'date': :desc, assoc: { 'text': :asc } }
        end

        it do
          expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.date == right_result.date
              expect(left_result.assoc.text).to be <= right_result.assoc.text
            end
          end
        end
      end

      context '{ computed_date: :asc, assoc: { text: :asc } }' do
        let(:instructions) do
          { 'computed_date': :asc, assoc: { 'text': :asc } }
        end

        it do
          expect(result.map(&:computed_date)).to eq @all_foos.map(&:computed_date).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_date == right_result.computed_date
              expect(left_result.assoc.text).to be <= right_result.assoc.text
            end
          end
        end
      end

      context '{ date: :desc, assoc: { computed_text: :desc } }' do
        let(:instructions) do
          { 'date': :desc, assoc: { 'computed_text': :desc } }
        end

        it do
          expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.date == right_result.date
              expect(left_result.assoc.computed_text).to be >= right_result.assoc.computed_text
            end
          end
        end
      end

      context '{ computed_date: :asc, assoc: { computed_text: :desc } }' do
        let(:instructions) do
          { 'computed_date': :asc, assoc: { 'computed_text': :desc } }
        end

        it do
          expect(result.map(&:computed_date)).to eq @all_foos.map(&:computed_date).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_date == right_result.computed_date
              expect(left_result.assoc.computed_text).to be >= right_result.assoc.computed_text
            end
          end
        end
      end

      context '{ assoc: { date: :desc }, text: :asc }' do
        let(:instructions) do
          { assoc: { 'date': :desc }, 'text': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.date }).to eq @all_foos.map { |x| x.assoc&.date }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.date == right_result.assoc.date
              expect(left_result.text).to be <= right_result.text
            end
          end
        end
      end

      context '{ assoc: { computed_date: :asc }, computed_text: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_date': :asc }, 'computed_text': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_date }).to eq @all_foos.map { |x| x.assoc&.computed_date }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_date == right_result.assoc.computed_date
              expect(left_result.computed_text).to be <= right_result.computed_text
            end
          end
        end
      end

      context '{ assoc: { date: :asc }, computed_text: :desc }' do
        let(:instructions) do
          { assoc: { 'date': :asc }, 'computed_text': :desc }
        end

        it do
          expect(result.map { |x| x.assoc&.date }).to eq @all_foos.map { |x| x.assoc&.date }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.date == right_result.assoc.date
              expect(left_result.computed_text).to be >= right_result.computed_text
            end
          end
        end
      end

      context '{ assoc: { computed_date: :desc }, text: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_date': :desc }, 'text': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_date }).to eq @all_foos.map { |x| x.assoc&.computed_date }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_date == right_result.assoc.computed_date
              expect(left_result.text).to be <= right_result.text
            end
          end
        end
      end
    end

    context 'with DATE and TIME type' do
      context '{ date: :asc, time: :asc }' do
        let(:instructions) do
          { 'date': :asc, 'time': :asc }
        end

        it do
          expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.date == right_result.date
              expect(left_result.time).to be <= right_result.time
            end
          end
        end
      end

      context '{ date: :desc, time: :desc }' do
        let(:instructions) do
          { 'date': :desc, 'time': :desc }
        end

        it do
          expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.date == right_result.date
              expect(left_result.time).to be >= right_result.time
            end
          end
        end
      end

      context '{ date: :asc, time: :desc }' do
        let(:instructions) do
          { 'date': :asc, 'time': :desc }
        end

        it do
          expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.date == right_result.date
              expect(left_result.time).to be >= right_result.time
            end
          end
        end
      end

      context '{ date: :desc, time: :asc }' do
        let(:instructions) do
          { 'date': :desc, 'time': :asc }
        end

        it do
          expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.date == right_result.date
              expect(left_result.time).to be <= right_result.time
            end
          end
        end
      end


      context '{ computed_date: :asc, computed_time: :asc }' do
        let(:instructions) do
          { 'computed_date': :asc, 'computed_time': :asc }
        end

        it do
          expect(result.map(&:computed_date)).to eq @all_foos.map(&:computed_date).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_date == right_result.computed_date
              expect(left_result.computed_time).to be <= right_result.computed_time
            end
          end
        end
      end

      context '{ date: :desc, computed_time: :desc }' do
        let(:instructions) do
          { 'date': :desc, 'computed_time': :desc }
        end

        it do
          expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.date == right_result.date
              expect(left_result.computed_time).to be >= right_result.computed_time
            end
          end
        end
      end

      context '{ computed_date: :asc, time: :desc }' do
        let(:instructions) do
          { 'computed_date': :asc, 'time': :desc }
        end

        it do
          expect(result.map(&:computed_date)).to eq @all_foos.map(&:computed_date).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_date == right_result.computed_date
              expect(left_result.time).to be >= right_result.time
            end
          end
        end
      end

      context '{ assoc: { date: :desc, time: :asc } }' do
        let(:instructions) do
          { assoc: { 'date': :desc, 'time': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.date }).to eq @all_foos.map { |x| x.assoc&.date }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.date == right_result.assoc.date
              expect(left_result.assoc.time).to be <= right_result.assoc.time
            end
          end
        end
      end

      context '{ assoc: { computed_date: :asc, computed_time: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_date': :asc, 'computed_time': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_date }).to eq @all_foos.map { |x| x.assoc&.computed_date }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_date == right_result.assoc.computed_date
              expect(left_result.assoc.computed_time).to be <= right_result.assoc.computed_time
            end
          end
        end
      end

      context '{ assoc: { date: :desc, computed_time: :desc } }' do
        let(:instructions) do
          { assoc: { 'date': :desc, 'computed_time': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.date }).to eq @all_foos.map { |x| x.assoc&.date }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.date == right_result.assoc.date
              expect(left_result.assoc.computed_time).to be >= right_result.assoc.computed_time
            end
          end
        end
      end

      context '{ assoc: { computed_date: :asc, time: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_date': :asc, 'time': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_date }).to eq @all_foos.map { |x| x.assoc&.computed_date }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_date == right_result.assoc.computed_date
              expect(left_result.assoc.time).to be >= right_result.assoc.time
            end
          end
        end
      end

      context '{ date: :desc, assoc: { time: :asc } }' do
        let(:instructions) do
          { 'date': :desc, assoc: { 'time': :asc } }
        end

        it do
          expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.date == right_result.date
              expect(left_result.assoc.time).to be <= right_result.assoc.time
            end
          end
        end
      end

      context '{ computed_date: :asc, assoc: { time: :asc } }' do
        let(:instructions) do
          { 'computed_date': :asc, assoc: { 'time': :asc } }
        end

        it do
          expect(result.map(&:computed_date)).to eq @all_foos.map(&:computed_date).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_date == right_result.computed_date
              expect(left_result.assoc.time).to be <= right_result.assoc.time
            end
          end
        end
      end

      context '{ date: :desc, assoc: { computed_time: :desc } }' do
        let(:instructions) do
          { 'date': :desc, assoc: { 'computed_time': :desc } }
        end

        it do
          expect(result.map(&:date)).to eq @all_foos.map(&:date).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.date == right_result.date
              expect(left_result.assoc.computed_time).to be >= right_result.assoc.computed_time
            end
          end
        end
      end

      context '{ computed_date: :asc, assoc: { computed_time: :desc } }' do
        let(:instructions) do
          { 'computed_date': :asc, assoc: { 'computed_time': :desc } }
        end

        it do
          expect(result.map(&:computed_date)).to eq @all_foos.map(&:computed_date).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_date == right_result.computed_date
              expect(left_result.assoc.computed_time).to be >= right_result.assoc.computed_time
            end
          end
        end
      end

      context '{ assoc: { date: :desc }, time: :asc }' do
        let(:instructions) do
          { assoc: { 'date': :desc }, 'time': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.date }).to eq @all_foos.map { |x| x.assoc&.date }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.date == right_result.assoc.date
              expect(left_result.time).to be <= right_result.time
            end
          end
        end
      end

      context '{ assoc: { computed_date: :asc }, computed_time: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_date': :asc }, 'computed_time': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_date }).to eq @all_foos.map { |x| x.assoc&.computed_date }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_date == right_result.assoc.computed_date
              expect(left_result.computed_time).to be <= right_result.computed_time
            end
          end
        end
      end

      context '{ assoc: { date: :asc }, computed_time: :desc }' do
        let(:instructions) do
          { assoc: { 'date': :asc }, 'computed_time': :desc }
        end

        it do
          expect(result.map { |x| x.assoc&.date }).to eq @all_foos.map { |x| x.assoc&.date }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.date == right_result.assoc.date
              expect(left_result.computed_time).to be >= right_result.computed_time
            end
          end
        end
      end

      context '{ assoc: { computed_date: :desc }, time: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_date': :desc }, 'time': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_date }).to eq @all_foos.map { |x| x.assoc&.computed_date }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_date == right_result.assoc.computed_date
              expect(left_result.time).to be <= right_result.time
            end
          end
        end
      end
    end


    context 'with DATETIME and DECIMAL type' do
      context '{ datetime: :asc, decimal: :asc }' do
        let(:instructions) do
          { 'datetime': :asc, 'decimal': :asc }
        end

        it do
          expect(result.map(&:datetime)).to eq @all_foos.map(&:datetime).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.datetime == right_result.datetime
              expect(left_result.decimal).to be <= right_result.decimal
            end
          end
        end
      end

      context '{ datetime: :desc, decimal: :desc }' do
        let(:instructions) do
          { 'datetime': :desc, 'decimal': :desc }
        end

        it do
          expect(result.map(&:datetime)).to eq @all_foos.map(&:datetime).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.datetime == right_result.datetime
              expect(left_result.decimal).to be >= right_result.decimal
            end
          end
        end
      end

      context '{ datetime: :asc, decimal: :desc }' do
        let(:instructions) do
          { 'datetime': :asc, 'decimal': :desc }
        end

        it do
          expect(result.map(&:datetime)).to eq @all_foos.map(&:datetime).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.datetime == right_result.datetime
              expect(left_result.decimal).to be >= right_result.decimal
            end
          end
        end
      end

      context '{ datetime: :desc, decimal: :asc }' do
        let(:instructions) do
          { 'datetime': :desc, 'decimal': :asc }
        end

        it do
          expect(result.map(&:datetime)).to eq @all_foos.map(&:datetime).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.datetime == right_result.datetime
              expect(left_result.decimal).to be <= right_result.decimal
            end
          end
        end
      end


      context '{ computed_datetime: :asc, computed_decimal: :asc }' do
        let(:instructions) do
          { 'computed_datetime': :asc, 'computed_decimal': :asc }
        end

        it do
          expect(result.map(&:computed_datetime)).to eq @all_foos.map(&:computed_datetime).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_datetime == right_result.computed_datetime
              expect(left_result.computed_decimal).to be <= right_result.computed_decimal
            end
          end
        end
      end

      context '{ datetime: :desc, computed_decimal: :desc }' do
        let(:instructions) do
          { 'datetime': :desc, 'computed_decimal': :desc }
        end

        it do
          expect(result.map(&:datetime)).to eq @all_foos.map(&:datetime).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.datetime == right_result.datetime
              expect(left_result.computed_decimal).to be >= right_result.computed_decimal
            end
          end
        end
      end

      context '{ computed_datetime: :asc, decimal: :desc }' do
        let(:instructions) do
          { 'computed_datetime': :asc, 'decimal': :desc }
        end

        it do
          expect(result.map(&:computed_datetime)).to eq @all_foos.map(&:computed_datetime).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_datetime == right_result.computed_datetime
              expect(left_result.decimal).to be >= right_result.decimal
            end
          end
        end
      end

      context '{ assoc: { datetime: :desc, decimal: :asc } }' do
        let(:instructions) do
          { assoc: { 'datetime': :desc, 'decimal': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.datetime }).to eq @all_foos.map { |x| x.assoc&.datetime }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.datetime == right_result.assoc.datetime
              expect(left_result.assoc.decimal).to be <= right_result.assoc.decimal
            end
          end
        end
      end

      context '{ assoc: { computed_datetime: :asc, computed_decimal: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_datetime': :asc, 'computed_decimal': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_datetime }).to eq @all_foos.map { |x| x.assoc&.computed_datetime }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_datetime == right_result.assoc.computed_datetime
              expect(left_result.assoc.computed_decimal).to be <= right_result.assoc.computed_decimal
            end
          end
        end
      end

      context '{ assoc: { datetime: :desc, computed_decimal: :desc } }' do
        let(:instructions) do
          { assoc: { 'datetime': :desc, 'computed_decimal': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.datetime }).to eq @all_foos.map { |x| x.assoc&.datetime }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.datetime == right_result.assoc.datetime
              expect(left_result.assoc.computed_decimal).to be >= right_result.assoc.computed_decimal
            end
          end
        end
      end

      context '{ assoc: { computed_datetime: :asc, decimal: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_datetime': :asc, 'decimal': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_datetime }).to eq @all_foos.map { |x| x.assoc&.computed_datetime }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_datetime == right_result.assoc.computed_datetime
              expect(left_result.assoc.decimal).to be >= right_result.assoc.decimal
            end
          end
        end
      end

      context '{ datetime: :desc, assoc: { decimal: :asc } }' do
        let(:instructions) do
          { 'datetime': :desc, assoc: { 'decimal': :asc } }
        end

        it do
          expect(result.map(&:datetime)).to eq @all_foos.map(&:datetime).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.datetime == right_result.datetime
              expect(left_result.assoc.decimal).to be <= right_result.assoc.decimal
            end
          end
        end
      end

      context '{ computed_datetime: :asc, assoc: { decimal: :asc } }' do
        let(:instructions) do
          { 'computed_datetime': :asc, assoc: { 'decimal': :asc } }
        end

        it do
          expect(result.map(&:computed_datetime)).to eq @all_foos.map(&:computed_datetime).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_datetime == right_result.computed_datetime
              expect(left_result.assoc.decimal).to be <= right_result.assoc.decimal
            end
          end
        end
      end

      context '{ datetime: :desc, assoc: { computed_decimal: :desc } }' do
        let(:instructions) do
          { 'datetime': :desc, assoc: { 'computed_decimal': :desc } }
        end

        it do
          expect(result.map(&:datetime)).to eq @all_foos.map(&:datetime).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.datetime == right_result.datetime
              expect(left_result.assoc.computed_decimal).to be >= right_result.assoc.computed_decimal
            end
          end
        end
      end

      context '{ computed_datetime: :asc, assoc: { computed_decimal: :desc } }' do
        let(:instructions) do
          { 'computed_datetime': :asc, assoc: { 'computed_decimal': :desc } }
        end

        it do
          expect(result.map(&:computed_datetime)).to eq @all_foos.map(&:computed_datetime).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_datetime == right_result.computed_datetime
              expect(left_result.assoc.computed_decimal).to be >= right_result.assoc.computed_decimal
            end
          end
        end
      end

      context '{ assoc: { datetime: :desc }, decimal: :asc }' do
        let(:instructions) do
          { assoc: { 'datetime': :desc }, 'decimal': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.datetime }).to eq @all_foos.map { |x| x.assoc&.datetime }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.datetime == right_result.assoc.datetime
              expect(left_result.decimal).to be <= right_result.decimal
            end
          end
        end
      end

      context '{ assoc: { computed_datetime: :asc }, computed_decimal: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_datetime': :asc }, 'computed_decimal': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_datetime }).to eq @all_foos.map { |x| x.assoc&.computed_datetime }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_datetime == right_result.assoc.computed_datetime
              expect(left_result.computed_decimal).to be <= right_result.computed_decimal
            end
          end
        end
      end

      context '{ assoc: { datetime: :asc }, computed_decimal: :desc }' do
        let(:instructions) do
          { assoc: { 'datetime': :asc }, 'computed_decimal': :desc }
        end

        it do
          expect(result.map { |x| x.assoc&.datetime }).to eq @all_foos.map { |x| x.assoc&.datetime }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.datetime == right_result.assoc.datetime
              expect(left_result.computed_decimal).to be >= right_result.computed_decimal
            end
          end
        end
      end

      context '{ assoc: { computed_datetime: :desc }, decimal: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_datetime': :desc }, 'decimal': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_datetime }).to eq @all_foos.map { |x| x.assoc&.computed_datetime }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_datetime == right_result.assoc.computed_datetime
              expect(left_result.decimal).to be <= right_result.decimal
            end
          end
        end
      end
    end

    context 'with DATETIME and FLOAT type' do
      context '{ datetime: :asc, float: :asc }' do
        let(:instructions) do
          { 'datetime': :asc, 'float': :asc }
        end

        it do
          expect(result.map(&:datetime)).to eq @all_foos.map(&:datetime).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.datetime == right_result.datetime
              expect(left_result.float).to be <= right_result.float
            end
          end
        end
      end

      context '{ datetime: :desc, float: :desc }' do
        let(:instructions) do
          { 'datetime': :desc, 'float': :desc }
        end

        it do
          expect(result.map(&:datetime)).to eq @all_foos.map(&:datetime).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.datetime == right_result.datetime
              expect(left_result.float).to be >= right_result.float
            end
          end
        end
      end

      context '{ datetime: :asc, float: :desc }' do
        let(:instructions) do
          { 'datetime': :asc, 'float': :desc }
        end

        it do
          expect(result.map(&:datetime)).to eq @all_foos.map(&:datetime).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.datetime == right_result.datetime
              expect(left_result.float).to be >= right_result.float
            end
          end
        end
      end

      context '{ datetime: :desc, float: :asc }' do
        let(:instructions) do
          { 'datetime': :desc, 'float': :asc }
        end

        it do
          expect(result.map(&:datetime)).to eq @all_foos.map(&:datetime).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.datetime == right_result.datetime
              expect(left_result.float).to be <= right_result.float
            end
          end
        end
      end


      context '{ computed_datetime: :asc, computed_float: :asc }' do
        let(:instructions) do
          { 'computed_datetime': :asc, 'computed_float': :asc }
        end

        it do
          expect(result.map(&:computed_datetime)).to eq @all_foos.map(&:computed_datetime).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_datetime == right_result.computed_datetime
              expect(left_result.computed_float).to be <= right_result.computed_float
            end
          end
        end
      end

      context '{ datetime: :desc, computed_float: :desc }' do
        let(:instructions) do
          { 'datetime': :desc, 'computed_float': :desc }
        end

        it do
          expect(result.map(&:datetime)).to eq @all_foos.map(&:datetime).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.datetime == right_result.datetime
              expect(left_result.computed_float).to be >= right_result.computed_float
            end
          end
        end
      end

      context '{ computed_datetime: :asc, float: :desc }' do
        let(:instructions) do
          { 'computed_datetime': :asc, 'float': :desc }
        end

        it do
          expect(result.map(&:computed_datetime)).to eq @all_foos.map(&:computed_datetime).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_datetime == right_result.computed_datetime
              expect(left_result.float).to be >= right_result.float
            end
          end
        end
      end

      context '{ assoc: { datetime: :desc, float: :asc } }' do
        let(:instructions) do
          { assoc: { 'datetime': :desc, 'float': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.datetime }).to eq @all_foos.map { |x| x.assoc&.datetime }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.datetime == right_result.assoc.datetime
              expect(left_result.assoc.float).to be <= right_result.assoc.float
            end
          end
        end
      end

      context '{ assoc: { computed_datetime: :asc, computed_float: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_datetime': :asc, 'computed_float': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_datetime }).to eq @all_foos.map { |x| x.assoc&.computed_datetime }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_datetime == right_result.assoc.computed_datetime
              expect(left_result.assoc.computed_float).to be <= right_result.assoc.computed_float
            end
          end
        end
      end

      context '{ assoc: { datetime: :desc, computed_float: :desc } }' do
        let(:instructions) do
          { assoc: { 'datetime': :desc, 'computed_float': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.datetime }).to eq @all_foos.map { |x| x.assoc&.datetime }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.datetime == right_result.assoc.datetime
              expect(left_result.assoc.computed_float).to be >= right_result.assoc.computed_float
            end
          end
        end
      end

      context '{ assoc: { computed_datetime: :asc, float: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_datetime': :asc, 'float': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_datetime }).to eq @all_foos.map { |x| x.assoc&.computed_datetime }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_datetime == right_result.assoc.computed_datetime
              expect(left_result.assoc.float).to be >= right_result.assoc.float
            end
          end
        end
      end

      context '{ datetime: :desc, assoc: { float: :asc } }' do
        let(:instructions) do
          { 'datetime': :desc, assoc: { 'float': :asc } }
        end

        it do
          expect(result.map(&:datetime)).to eq @all_foos.map(&:datetime).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.datetime == right_result.datetime
              expect(left_result.assoc.float).to be <= right_result.assoc.float
            end
          end
        end
      end

      context '{ computed_datetime: :asc, assoc: { float: :asc } }' do
        let(:instructions) do
          { 'computed_datetime': :asc, assoc: { 'float': :asc } }
        end

        it do
          expect(result.map(&:computed_datetime)).to eq @all_foos.map(&:computed_datetime).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_datetime == right_result.computed_datetime
              expect(left_result.assoc.float).to be <= right_result.assoc.float
            end
          end
        end
      end

      context '{ datetime: :desc, assoc: { computed_float: :desc } }' do
        let(:instructions) do
          { 'datetime': :desc, assoc: { 'computed_float': :desc } }
        end

        it do
          expect(result.map(&:datetime)).to eq @all_foos.map(&:datetime).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.datetime == right_result.datetime
              expect(left_result.assoc.computed_float).to be >= right_result.assoc.computed_float
            end
          end
        end
      end

      context '{ computed_datetime: :asc, assoc: { computed_float: :desc } }' do
        let(:instructions) do
          { 'computed_datetime': :asc, assoc: { 'computed_float': :desc } }
        end

        it do
          expect(result.map(&:computed_datetime)).to eq @all_foos.map(&:computed_datetime).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_datetime == right_result.computed_datetime
              expect(left_result.assoc.computed_float).to be >= right_result.assoc.computed_float
            end
          end
        end
      end

      context '{ assoc: { datetime: :desc }, float: :asc }' do
        let(:instructions) do
          { assoc: { 'datetime': :desc }, 'float': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.datetime }).to eq @all_foos.map { |x| x.assoc&.datetime }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.datetime == right_result.assoc.datetime
              expect(left_result.float).to be <= right_result.float
            end
          end
        end
      end

      context '{ assoc: { computed_datetime: :asc }, computed_float: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_datetime': :asc }, 'computed_float': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_datetime }).to eq @all_foos.map { |x| x.assoc&.computed_datetime }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_datetime == right_result.assoc.computed_datetime
              expect(left_result.computed_float).to be <= right_result.computed_float
            end
          end
        end
      end

      context '{ assoc: { datetime: :asc }, computed_float: :desc }' do
        let(:instructions) do
          { assoc: { 'datetime': :asc }, 'computed_float': :desc }
        end

        it do
          expect(result.map { |x| x.assoc&.datetime }).to eq @all_foos.map { |x| x.assoc&.datetime }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.datetime == right_result.assoc.datetime
              expect(left_result.computed_float).to be >= right_result.computed_float
            end
          end
        end
      end

      context '{ assoc: { computed_datetime: :desc }, float: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_datetime': :desc }, 'float': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_datetime }).to eq @all_foos.map { |x| x.assoc&.computed_datetime }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_datetime == right_result.assoc.computed_datetime
              expect(left_result.float).to be <= right_result.float
            end
          end
        end
      end
    end

    context 'with DATETIME and INTEGER type' do
      context '{ datetime: :asc, integer: :asc }' do
        let(:instructions) do
          { 'datetime': :asc, 'integer': :asc }
        end

        it do
          expect(result.map(&:datetime)).to eq @all_foos.map(&:datetime).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.datetime == right_result.datetime
              expect(left_result.integer).to be <= right_result.integer
            end
          end
        end
      end

      context '{ datetime: :desc, integer: :desc }' do
        let(:instructions) do
          { 'datetime': :desc, 'integer': :desc }
        end

        it do
          expect(result.map(&:datetime)).to eq @all_foos.map(&:datetime).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.datetime == right_result.datetime
              expect(left_result.integer).to be >= right_result.integer
            end
          end
        end
      end

      context '{ datetime: :asc, integer: :desc }' do
        let(:instructions) do
          { 'datetime': :asc, 'integer': :desc }
        end

        it do
          expect(result.map(&:datetime)).to eq @all_foos.map(&:datetime).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.datetime == right_result.datetime
              expect(left_result.integer).to be >= right_result.integer
            end
          end
        end
      end

      context '{ datetime: :desc, integer: :asc }' do
        let(:instructions) do
          { 'datetime': :desc, 'integer': :asc }
        end

        it do
          expect(result.map(&:datetime)).to eq @all_foos.map(&:datetime).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.datetime == right_result.datetime
              expect(left_result.integer).to be <= right_result.integer
            end
          end
        end
      end


      context '{ computed_datetime: :asc, computed_integer: :asc }' do
        let(:instructions) do
          { 'computed_datetime': :asc, 'computed_integer': :asc }
        end

        it do
          expect(result.map(&:computed_datetime)).to eq @all_foos.map(&:computed_datetime).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_datetime == right_result.computed_datetime
              expect(left_result.computed_integer).to be <= right_result.computed_integer
            end
          end
        end
      end

      context '{ datetime: :desc, computed_integer: :desc }' do
        let(:instructions) do
          { 'datetime': :desc, 'computed_integer': :desc }
        end

        it do
          expect(result.map(&:datetime)).to eq @all_foos.map(&:datetime).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.datetime == right_result.datetime
              expect(left_result.computed_integer).to be >= right_result.computed_integer
            end
          end
        end
      end

      context '{ computed_datetime: :asc, integer: :desc }' do
        let(:instructions) do
          { 'computed_datetime': :asc, 'integer': :desc }
        end

        it do
          expect(result.map(&:computed_datetime)).to eq @all_foos.map(&:computed_datetime).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_datetime == right_result.computed_datetime
              expect(left_result.integer).to be >= right_result.integer
            end
          end
        end
      end

      context '{ assoc: { datetime: :desc, integer: :asc } }' do
        let(:instructions) do
          { assoc: { 'datetime': :desc, 'integer': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.datetime }).to eq @all_foos.map { |x| x.assoc&.datetime }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.datetime == right_result.assoc.datetime
              expect(left_result.assoc.integer).to be <= right_result.assoc.integer
            end
          end
        end
      end

      context '{ assoc: { computed_datetime: :asc, computed_integer: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_datetime': :asc, 'computed_integer': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_datetime }).to eq @all_foos.map { |x| x.assoc&.computed_datetime }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_datetime == right_result.assoc.computed_datetime
              expect(left_result.assoc.computed_integer).to be <= right_result.assoc.computed_integer
            end
          end
        end
      end

      context '{ assoc: { datetime: :desc, computed_integer: :desc } }' do
        let(:instructions) do
          { assoc: { 'datetime': :desc, 'computed_integer': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.datetime }).to eq @all_foos.map { |x| x.assoc&.datetime }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.datetime == right_result.assoc.datetime
              expect(left_result.assoc.computed_integer).to be >= right_result.assoc.computed_integer
            end
          end
        end
      end

      context '{ assoc: { computed_datetime: :asc, integer: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_datetime': :asc, 'integer': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_datetime }).to eq @all_foos.map { |x| x.assoc&.computed_datetime }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_datetime == right_result.assoc.computed_datetime
              expect(left_result.assoc.integer).to be >= right_result.assoc.integer
            end
          end
        end
      end

      context '{ datetime: :desc, assoc: { integer: :asc } }' do
        let(:instructions) do
          { 'datetime': :desc, assoc: { 'integer': :asc } }
        end

        it do
          expect(result.map(&:datetime)).to eq @all_foos.map(&:datetime).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.datetime == right_result.datetime
              expect(left_result.assoc.integer).to be <= right_result.assoc.integer
            end
          end
        end
      end

      context '{ computed_datetime: :asc, assoc: { integer: :asc } }' do
        let(:instructions) do
          { 'computed_datetime': :asc, assoc: { 'integer': :asc } }
        end

        it do
          expect(result.map(&:computed_datetime)).to eq @all_foos.map(&:computed_datetime).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_datetime == right_result.computed_datetime
              expect(left_result.assoc.integer).to be <= right_result.assoc.integer
            end
          end
        end
      end

      context '{ datetime: :desc, assoc: { computed_integer: :desc } }' do
        let(:instructions) do
          { 'datetime': :desc, assoc: { 'computed_integer': :desc } }
        end

        it do
          expect(result.map(&:datetime)).to eq @all_foos.map(&:datetime).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.datetime == right_result.datetime
              expect(left_result.assoc.computed_integer).to be >= right_result.assoc.computed_integer
            end
          end
        end
      end

      context '{ computed_datetime: :asc, assoc: { computed_integer: :desc } }' do
        let(:instructions) do
          { 'computed_datetime': :asc, assoc: { 'computed_integer': :desc } }
        end

        it do
          expect(result.map(&:computed_datetime)).to eq @all_foos.map(&:computed_datetime).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_datetime == right_result.computed_datetime
              expect(left_result.assoc.computed_integer).to be >= right_result.assoc.computed_integer
            end
          end
        end
      end

      context '{ assoc: { datetime: :desc }, integer: :asc }' do
        let(:instructions) do
          { assoc: { 'datetime': :desc }, 'integer': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.datetime }).to eq @all_foos.map { |x| x.assoc&.datetime }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.datetime == right_result.assoc.datetime
              expect(left_result.integer).to be <= right_result.integer
            end
          end
        end
      end

      context '{ assoc: { computed_datetime: :asc }, computed_integer: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_datetime': :asc }, 'computed_integer': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_datetime }).to eq @all_foos.map { |x| x.assoc&.computed_datetime }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_datetime == right_result.assoc.computed_datetime
              expect(left_result.computed_integer).to be <= right_result.computed_integer
            end
          end
        end
      end

      context '{ assoc: { datetime: :asc }, computed_integer: :desc }' do
        let(:instructions) do
          { assoc: { 'datetime': :asc }, 'computed_integer': :desc }
        end

        it do
          expect(result.map { |x| x.assoc&.datetime }).to eq @all_foos.map { |x| x.assoc&.datetime }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.datetime == right_result.assoc.datetime
              expect(left_result.computed_integer).to be >= right_result.computed_integer
            end
          end
        end
      end

      context '{ assoc: { computed_datetime: :desc }, integer: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_datetime': :desc }, 'integer': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_datetime }).to eq @all_foos.map { |x| x.assoc&.computed_datetime }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_datetime == right_result.assoc.computed_datetime
              expect(left_result.integer).to be <= right_result.integer
            end
          end
        end
      end
    end

    context 'with DATETIME and STRING type' do
      context '{ datetime: :asc, string: :asc }' do
        let(:instructions) do
          { 'datetime': :asc, 'string': :asc }
        end

        it do
          expect(result.map(&:datetime)).to eq @all_foos.map(&:datetime).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.datetime == right_result.datetime
              expect(left_result.string).to be <= right_result.string
            end
          end
        end
      end

      context '{ datetime: :desc, string: :desc }' do
        let(:instructions) do
          { 'datetime': :desc, 'string': :desc }
        end

        it do
          expect(result.map(&:datetime)).to eq @all_foos.map(&:datetime).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.datetime == right_result.datetime
              expect(left_result.string).to be >= right_result.string
            end
          end
        end
      end

      context '{ datetime: :asc, string: :desc }' do
        let(:instructions) do
          { 'datetime': :asc, 'string': :desc }
        end

        it do
          expect(result.map(&:datetime)).to eq @all_foos.map(&:datetime).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.datetime == right_result.datetime
              expect(left_result.string).to be >= right_result.string
            end
          end
        end
      end

      context '{ datetime: :desc, string: :asc }' do
        let(:instructions) do
          { 'datetime': :desc, 'string': :asc }
        end

        it do
          expect(result.map(&:datetime)).to eq @all_foos.map(&:datetime).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.datetime == right_result.datetime
              expect(left_result.string).to be <= right_result.string
            end
          end
        end
      end


      context '{ computed_datetime: :asc, computed_string: :asc }' do
        let(:instructions) do
          { 'computed_datetime': :asc, 'computed_string': :asc }
        end

        it do
          expect(result.map(&:computed_datetime)).to eq @all_foos.map(&:computed_datetime).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_datetime == right_result.computed_datetime
              expect(left_result.computed_string).to be <= right_result.computed_string
            end
          end
        end
      end

      context '{ datetime: :desc, computed_string: :desc }' do
        let(:instructions) do
          { 'datetime': :desc, 'computed_string': :desc }
        end

        it do
          expect(result.map(&:datetime)).to eq @all_foos.map(&:datetime).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.datetime == right_result.datetime
              expect(left_result.computed_string).to be >= right_result.computed_string
            end
          end
        end
      end

      context '{ computed_datetime: :asc, string: :desc }' do
        let(:instructions) do
          { 'computed_datetime': :asc, 'string': :desc }
        end

        it do
          expect(result.map(&:computed_datetime)).to eq @all_foos.map(&:computed_datetime).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_datetime == right_result.computed_datetime
              expect(left_result.string).to be >= right_result.string
            end
          end
        end
      end

      context '{ assoc: { datetime: :desc, string: :asc } }' do
        let(:instructions) do
          { assoc: { 'datetime': :desc, 'string': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.datetime }).to eq @all_foos.map { |x| x.assoc&.datetime }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.datetime == right_result.assoc.datetime
              expect(left_result.assoc.string).to be <= right_result.assoc.string
            end
          end
        end
      end

      context '{ assoc: { computed_datetime: :asc, computed_string: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_datetime': :asc, 'computed_string': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_datetime }).to eq @all_foos.map { |x| x.assoc&.computed_datetime }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_datetime == right_result.assoc.computed_datetime
              expect(left_result.assoc.computed_string).to be <= right_result.assoc.computed_string
            end
          end
        end
      end

      context '{ assoc: { datetime: :desc, computed_string: :desc } }' do
        let(:instructions) do
          { assoc: { 'datetime': :desc, 'computed_string': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.datetime }).to eq @all_foos.map { |x| x.assoc&.datetime }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.datetime == right_result.assoc.datetime
              expect(left_result.assoc.computed_string).to be >= right_result.assoc.computed_string
            end
          end
        end
      end

      context '{ assoc: { computed_datetime: :asc, string: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_datetime': :asc, 'string': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_datetime }).to eq @all_foos.map { |x| x.assoc&.computed_datetime }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_datetime == right_result.assoc.computed_datetime
              expect(left_result.assoc.string).to be >= right_result.assoc.string
            end
          end
        end
      end

      context '{ datetime: :desc, assoc: { string: :asc } }' do
        let(:instructions) do
          { 'datetime': :desc, assoc: { 'string': :asc } }
        end

        it do
          expect(result.map(&:datetime)).to eq @all_foos.map(&:datetime).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.datetime == right_result.datetime
              expect(left_result.assoc.string).to be <= right_result.assoc.string
            end
          end
        end
      end

      context '{ computed_datetime: :asc, assoc: { string: :asc } }' do
        let(:instructions) do
          { 'computed_datetime': :asc, assoc: { 'string': :asc } }
        end

        it do
          expect(result.map(&:computed_datetime)).to eq @all_foos.map(&:computed_datetime).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_datetime == right_result.computed_datetime
              expect(left_result.assoc.string).to be <= right_result.assoc.string
            end
          end
        end
      end

      context '{ datetime: :desc, assoc: { computed_string: :desc } }' do
        let(:instructions) do
          { 'datetime': :desc, assoc: { 'computed_string': :desc } }
        end

        it do
          expect(result.map(&:datetime)).to eq @all_foos.map(&:datetime).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.datetime == right_result.datetime
              expect(left_result.assoc.computed_string).to be >= right_result.assoc.computed_string
            end
          end
        end
      end

      context '{ computed_datetime: :asc, assoc: { computed_string: :desc } }' do
        let(:instructions) do
          { 'computed_datetime': :asc, assoc: { 'computed_string': :desc } }
        end

        it do
          expect(result.map(&:computed_datetime)).to eq @all_foos.map(&:computed_datetime).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_datetime == right_result.computed_datetime
              expect(left_result.assoc.computed_string).to be >= right_result.assoc.computed_string
            end
          end
        end
      end

      context '{ assoc: { datetime: :desc }, string: :asc }' do
        let(:instructions) do
          { assoc: { 'datetime': :desc }, 'string': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.datetime }).to eq @all_foos.map { |x| x.assoc&.datetime }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.datetime == right_result.assoc.datetime
              expect(left_result.string).to be <= right_result.string
            end
          end
        end
      end

      context '{ assoc: { computed_datetime: :asc }, computed_string: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_datetime': :asc }, 'computed_string': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_datetime }).to eq @all_foos.map { |x| x.assoc&.computed_datetime }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_datetime == right_result.assoc.computed_datetime
              expect(left_result.computed_string).to be <= right_result.computed_string
            end
          end
        end
      end

      context '{ assoc: { datetime: :asc }, computed_string: :desc }' do
        let(:instructions) do
          { assoc: { 'datetime': :asc }, 'computed_string': :desc }
        end

        it do
          expect(result.map { |x| x.assoc&.datetime }).to eq @all_foos.map { |x| x.assoc&.datetime }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.datetime == right_result.assoc.datetime
              expect(left_result.computed_string).to be >= right_result.computed_string
            end
          end
        end
      end

      context '{ assoc: { computed_datetime: :desc }, string: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_datetime': :desc }, 'string': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_datetime }).to eq @all_foos.map { |x| x.assoc&.computed_datetime }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_datetime == right_result.assoc.computed_datetime
              expect(left_result.string).to be <= right_result.string
            end
          end
        end
      end
    end

    context 'with DATETIME and TEXT type' do
      context '{ datetime: :asc, text: :asc }' do
        let(:instructions) do
          { 'datetime': :asc, 'text': :asc }
        end

        it do
          expect(result.map(&:datetime)).to eq @all_foos.map(&:datetime).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.datetime == right_result.datetime
              expect(left_result.text).to be <= right_result.text
            end
          end
        end
      end

      context '{ datetime: :desc, text: :desc }' do
        let(:instructions) do
          { 'datetime': :desc, 'text': :desc }
        end

        it do
          expect(result.map(&:datetime)).to eq @all_foos.map(&:datetime).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.datetime == right_result.datetime
              expect(left_result.text).to be >= right_result.text
            end
          end
        end
      end

      context '{ datetime: :asc, text: :desc }' do
        let(:instructions) do
          { 'datetime': :asc, 'text': :desc }
        end

        it do
          expect(result.map(&:datetime)).to eq @all_foos.map(&:datetime).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.datetime == right_result.datetime
              expect(left_result.text).to be >= right_result.text
            end
          end
        end
      end

      context '{ datetime: :desc, text: :asc }' do
        let(:instructions) do
          { 'datetime': :desc, 'text': :asc }
        end

        it do
          expect(result.map(&:datetime)).to eq @all_foos.map(&:datetime).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.datetime == right_result.datetime
              expect(left_result.text).to be <= right_result.text
            end
          end
        end
      end


      context '{ computed_datetime: :asc, computed_text: :asc }' do
        let(:instructions) do
          { 'computed_datetime': :asc, 'computed_text': :asc }
        end

        it do
          expect(result.map(&:computed_datetime)).to eq @all_foos.map(&:computed_datetime).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_datetime == right_result.computed_datetime
              expect(left_result.computed_text).to be <= right_result.computed_text
            end
          end
        end
      end

      context '{ datetime: :desc, computed_text: :desc }' do
        let(:instructions) do
          { 'datetime': :desc, 'computed_text': :desc }
        end

        it do
          expect(result.map(&:datetime)).to eq @all_foos.map(&:datetime).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.datetime == right_result.datetime
              expect(left_result.computed_text).to be >= right_result.computed_text
            end
          end
        end
      end

      context '{ computed_datetime: :asc, text: :desc }' do
        let(:instructions) do
          { 'computed_datetime': :asc, 'text': :desc }
        end

        it do
          expect(result.map(&:computed_datetime)).to eq @all_foos.map(&:computed_datetime).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_datetime == right_result.computed_datetime
              expect(left_result.text).to be >= right_result.text
            end
          end
        end
      end

      context '{ assoc: { datetime: :desc, text: :asc } }' do
        let(:instructions) do
          { assoc: { 'datetime': :desc, 'text': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.datetime }).to eq @all_foos.map { |x| x.assoc&.datetime }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.datetime == right_result.assoc.datetime
              expect(left_result.assoc.text).to be <= right_result.assoc.text
            end
          end
        end
      end

      context '{ assoc: { computed_datetime: :asc, computed_text: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_datetime': :asc, 'computed_text': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_datetime }).to eq @all_foos.map { |x| x.assoc&.computed_datetime }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_datetime == right_result.assoc.computed_datetime
              expect(left_result.assoc.computed_text).to be <= right_result.assoc.computed_text
            end
          end
        end
      end

      context '{ assoc: { datetime: :desc, computed_text: :desc } }' do
        let(:instructions) do
          { assoc: { 'datetime': :desc, 'computed_text': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.datetime }).to eq @all_foos.map { |x| x.assoc&.datetime }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.datetime == right_result.assoc.datetime
              expect(left_result.assoc.computed_text).to be >= right_result.assoc.computed_text
            end
          end
        end
      end

      context '{ assoc: { computed_datetime: :asc, text: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_datetime': :asc, 'text': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_datetime }).to eq @all_foos.map { |x| x.assoc&.computed_datetime }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_datetime == right_result.assoc.computed_datetime
              expect(left_result.assoc.text).to be >= right_result.assoc.text
            end
          end
        end
      end

      context '{ datetime: :desc, assoc: { text: :asc } }' do
        let(:instructions) do
          { 'datetime': :desc, assoc: { 'text': :asc } }
        end

        it do
          expect(result.map(&:datetime)).to eq @all_foos.map(&:datetime).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.datetime == right_result.datetime
              expect(left_result.assoc.text).to be <= right_result.assoc.text
            end
          end
        end
      end

      context '{ computed_datetime: :asc, assoc: { text: :asc } }' do
        let(:instructions) do
          { 'computed_datetime': :asc, assoc: { 'text': :asc } }
        end

        it do
          expect(result.map(&:computed_datetime)).to eq @all_foos.map(&:computed_datetime).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_datetime == right_result.computed_datetime
              expect(left_result.assoc.text).to be <= right_result.assoc.text
            end
          end
        end
      end

      context '{ datetime: :desc, assoc: { computed_text: :desc } }' do
        let(:instructions) do
          { 'datetime': :desc, assoc: { 'computed_text': :desc } }
        end

        it do
          expect(result.map(&:datetime)).to eq @all_foos.map(&:datetime).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.datetime == right_result.datetime
              expect(left_result.assoc.computed_text).to be >= right_result.assoc.computed_text
            end
          end
        end
      end

      context '{ computed_datetime: :asc, assoc: { computed_text: :desc } }' do
        let(:instructions) do
          { 'computed_datetime': :asc, assoc: { 'computed_text': :desc } }
        end

        it do
          expect(result.map(&:computed_datetime)).to eq @all_foos.map(&:computed_datetime).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_datetime == right_result.computed_datetime
              expect(left_result.assoc.computed_text).to be >= right_result.assoc.computed_text
            end
          end
        end
      end

      context '{ assoc: { datetime: :desc }, text: :asc }' do
        let(:instructions) do
          { assoc: { 'datetime': :desc }, 'text': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.datetime }).to eq @all_foos.map { |x| x.assoc&.datetime }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.datetime == right_result.assoc.datetime
              expect(left_result.text).to be <= right_result.text
            end
          end
        end
      end

      context '{ assoc: { computed_datetime: :asc }, computed_text: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_datetime': :asc }, 'computed_text': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_datetime }).to eq @all_foos.map { |x| x.assoc&.computed_datetime }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_datetime == right_result.assoc.computed_datetime
              expect(left_result.computed_text).to be <= right_result.computed_text
            end
          end
        end
      end

      context '{ assoc: { datetime: :asc }, computed_text: :desc }' do
        let(:instructions) do
          { assoc: { 'datetime': :asc }, 'computed_text': :desc }
        end

        it do
          expect(result.map { |x| x.assoc&.datetime }).to eq @all_foos.map { |x| x.assoc&.datetime }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.datetime == right_result.assoc.datetime
              expect(left_result.computed_text).to be >= right_result.computed_text
            end
          end
        end
      end

      context '{ assoc: { computed_datetime: :desc }, text: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_datetime': :desc }, 'text': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_datetime }).to eq @all_foos.map { |x| x.assoc&.computed_datetime }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_datetime == right_result.assoc.computed_datetime
              expect(left_result.text).to be <= right_result.text
            end
          end
        end
      end
    end

    context 'with DATETIME and TIME type' do
      context '{ datetime: :asc, time: :asc }' do
        let(:instructions) do
          { 'datetime': :asc, 'time': :asc }
        end

        it do
          expect(result.map(&:datetime)).to eq @all_foos.map(&:datetime).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.datetime == right_result.datetime
              expect(left_result.time).to be <= right_result.time
            end
          end
        end
      end

      context '{ datetime: :desc, time: :desc }' do
        let(:instructions) do
          { 'datetime': :desc, 'time': :desc }
        end

        it do
          expect(result.map(&:datetime)).to eq @all_foos.map(&:datetime).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.datetime == right_result.datetime
              expect(left_result.time).to be >= right_result.time
            end
          end
        end
      end

      context '{ datetime: :asc, time: :desc }' do
        let(:instructions) do
          { 'datetime': :asc, 'time': :desc }
        end

        it do
          expect(result.map(&:datetime)).to eq @all_foos.map(&:datetime).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.datetime == right_result.datetime
              expect(left_result.time).to be >= right_result.time
            end
          end
        end
      end

      context '{ datetime: :desc, time: :asc }' do
        let(:instructions) do
          { 'datetime': :desc, 'time': :asc }
        end

        it do
          expect(result.map(&:datetime)).to eq @all_foos.map(&:datetime).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.datetime == right_result.datetime
              expect(left_result.time).to be <= right_result.time
            end
          end
        end
      end


      context '{ computed_datetime: :asc, computed_time: :asc }' do
        let(:instructions) do
          { 'computed_datetime': :asc, 'computed_time': :asc }
        end

        it do
          expect(result.map(&:computed_datetime)).to eq @all_foos.map(&:computed_datetime).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_datetime == right_result.computed_datetime
              expect(left_result.computed_time).to be <= right_result.computed_time
            end
          end
        end
      end

      context '{ datetime: :desc, computed_time: :desc }' do
        let(:instructions) do
          { 'datetime': :desc, 'computed_time': :desc }
        end

        it do
          expect(result.map(&:datetime)).to eq @all_foos.map(&:datetime).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.datetime == right_result.datetime
              expect(left_result.computed_time).to be >= right_result.computed_time
            end
          end
        end
      end

      context '{ computed_datetime: :asc, time: :desc }' do
        let(:instructions) do
          { 'computed_datetime': :asc, 'time': :desc }
        end

        it do
          expect(result.map(&:computed_datetime)).to eq @all_foos.map(&:computed_datetime).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_datetime == right_result.computed_datetime
              expect(left_result.time).to be >= right_result.time
            end
          end
        end
      end

      context '{ assoc: { datetime: :desc, time: :asc } }' do
        let(:instructions) do
          { assoc: { 'datetime': :desc, 'time': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.datetime }).to eq @all_foos.map { |x| x.assoc&.datetime }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.datetime == right_result.assoc.datetime
              expect(left_result.assoc.time).to be <= right_result.assoc.time
            end
          end
        end
      end

      context '{ assoc: { computed_datetime: :asc, computed_time: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_datetime': :asc, 'computed_time': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_datetime }).to eq @all_foos.map { |x| x.assoc&.computed_datetime }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_datetime == right_result.assoc.computed_datetime
              expect(left_result.assoc.computed_time).to be <= right_result.assoc.computed_time
            end
          end
        end
      end

      context '{ assoc: { datetime: :desc, computed_time: :desc } }' do
        let(:instructions) do
          { assoc: { 'datetime': :desc, 'computed_time': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.datetime }).to eq @all_foos.map { |x| x.assoc&.datetime }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.datetime == right_result.assoc.datetime
              expect(left_result.assoc.computed_time).to be >= right_result.assoc.computed_time
            end
          end
        end
      end

      context '{ assoc: { computed_datetime: :asc, time: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_datetime': :asc, 'time': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_datetime }).to eq @all_foos.map { |x| x.assoc&.computed_datetime }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_datetime == right_result.assoc.computed_datetime
              expect(left_result.assoc.time).to be >= right_result.assoc.time
            end
          end
        end
      end

      context '{ datetime: :desc, assoc: { time: :asc } }' do
        let(:instructions) do
          { 'datetime': :desc, assoc: { 'time': :asc } }
        end

        it do
          expect(result.map(&:datetime)).to eq @all_foos.map(&:datetime).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.datetime == right_result.datetime
              expect(left_result.assoc.time).to be <= right_result.assoc.time
            end
          end
        end
      end

      context '{ computed_datetime: :asc, assoc: { time: :asc } }' do
        let(:instructions) do
          { 'computed_datetime': :asc, assoc: { 'time': :asc } }
        end

        it do
          expect(result.map(&:computed_datetime)).to eq @all_foos.map(&:computed_datetime).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_datetime == right_result.computed_datetime
              expect(left_result.assoc.time).to be <= right_result.assoc.time
            end
          end
        end
      end

      context '{ datetime: :desc, assoc: { computed_time: :desc } }' do
        let(:instructions) do
          { 'datetime': :desc, assoc: { 'computed_time': :desc } }
        end

        it do
          expect(result.map(&:datetime)).to eq @all_foos.map(&:datetime).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.datetime == right_result.datetime
              expect(left_result.assoc.computed_time).to be >= right_result.assoc.computed_time
            end
          end
        end
      end

      context '{ computed_datetime: :asc, assoc: { computed_time: :desc } }' do
        let(:instructions) do
          { 'computed_datetime': :asc, assoc: { 'computed_time': :desc } }
        end

        it do
          expect(result.map(&:computed_datetime)).to eq @all_foos.map(&:computed_datetime).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_datetime == right_result.computed_datetime
              expect(left_result.assoc.computed_time).to be >= right_result.assoc.computed_time
            end
          end
        end
      end

      context '{ assoc: { datetime: :desc }, time: :asc }' do
        let(:instructions) do
          { assoc: { 'datetime': :desc }, 'time': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.datetime }).to eq @all_foos.map { |x| x.assoc&.datetime }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.datetime == right_result.assoc.datetime
              expect(left_result.time).to be <= right_result.time
            end
          end
        end
      end

      context '{ assoc: { computed_datetime: :asc }, computed_time: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_datetime': :asc }, 'computed_time': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_datetime }).to eq @all_foos.map { |x| x.assoc&.computed_datetime }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_datetime == right_result.assoc.computed_datetime
              expect(left_result.computed_time).to be <= right_result.computed_time
            end
          end
        end
      end

      context '{ assoc: { datetime: :asc }, computed_time: :desc }' do
        let(:instructions) do
          { assoc: { 'datetime': :asc }, 'computed_time': :desc }
        end

        it do
          expect(result.map { |x| x.assoc&.datetime }).to eq @all_foos.map { |x| x.assoc&.datetime }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.datetime == right_result.assoc.datetime
              expect(left_result.computed_time).to be >= right_result.computed_time
            end
          end
        end
      end

      context '{ assoc: { computed_datetime: :desc }, time: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_datetime': :desc }, 'time': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_datetime }).to eq @all_foos.map { |x| x.assoc&.computed_datetime }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_datetime == right_result.assoc.computed_datetime
              expect(left_result.time).to be <= right_result.time
            end
          end
        end
      end
    end


    context 'with DECIMAL and FLOAT type' do
      context '{ decimal: :asc, float: :asc }' do
        let(:instructions) do
          { 'decimal': :asc, 'float': :asc }
        end

        it do
          expect(result.map(&:decimal)).to eq @all_foos.map(&:decimal).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.decimal == right_result.decimal
              expect(left_result.float).to be <= right_result.float
            end
          end
        end
      end

      context '{ decimal: :desc, float: :desc }' do
        let(:instructions) do
          { 'decimal': :desc, 'float': :desc }
        end

        it do
          expect(result.map(&:decimal)).to eq @all_foos.map(&:decimal).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.decimal == right_result.decimal
              expect(left_result.float).to be >= right_result.float
            end
          end
        end
      end

      context '{ decimal: :asc, float: :desc }' do
        let(:instructions) do
          { 'decimal': :asc, 'float': :desc }
        end

        it do
          expect(result.map(&:decimal)).to eq @all_foos.map(&:decimal).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.decimal == right_result.decimal
              expect(left_result.float).to be >= right_result.float
            end
          end
        end
      end

      context '{ decimal: :desc, float: :asc }' do
        let(:instructions) do
          { 'decimal': :desc, 'float': :asc }
        end

        it do
          expect(result.map(&:decimal)).to eq @all_foos.map(&:decimal).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.decimal == right_result.decimal
              expect(left_result.float).to be <= right_result.float
            end
          end
        end
      end


      context '{ computed_decimal: :asc, computed_float: :asc }' do
        let(:instructions) do
          { 'computed_decimal': :asc, 'computed_float': :asc }
        end

        it do
          expect(result.map(&:computed_decimal)).to eq @all_foos.map(&:computed_decimal).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_decimal == right_result.computed_decimal
              expect(left_result.computed_float).to be <= right_result.computed_float
            end
          end
        end
      end

      context '{ decimal: :desc, computed_float: :desc }' do
        let(:instructions) do
          { 'decimal': :desc, 'computed_float': :desc }
        end

        it do
          expect(result.map(&:decimal)).to eq @all_foos.map(&:decimal).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.decimal == right_result.decimal
              expect(left_result.computed_float).to be >= right_result.computed_float
            end
          end
        end
      end

      context '{ computed_decimal: :asc, float: :desc }' do
        let(:instructions) do
          { 'computed_decimal': :asc, 'float': :desc }
        end

        it do
          expect(result.map(&:computed_decimal)).to eq @all_foos.map(&:computed_decimal).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_decimal == right_result.computed_decimal
              expect(left_result.float).to be >= right_result.float
            end
          end
        end
      end

      context '{ assoc: { decimal: :desc, float: :asc } }' do
        let(:instructions) do
          { assoc: { 'decimal': :desc, 'float': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.decimal }).to eq @all_foos.map { |x| x.assoc&.decimal }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.decimal == right_result.assoc.decimal
              expect(left_result.assoc.float).to be <= right_result.assoc.float
            end
          end
        end
      end

      context '{ assoc: { computed_decimal: :asc, computed_float: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_decimal': :asc, 'computed_float': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_decimal }).to eq @all_foos.map { |x| x.assoc&.computed_decimal }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_decimal == right_result.assoc.computed_decimal
              expect(left_result.assoc.computed_float).to be <= right_result.assoc.computed_float
            end
          end
        end
      end

      context '{ assoc: { decimal: :desc, computed_float: :desc } }' do
        let(:instructions) do
          { assoc: { 'decimal': :desc, 'computed_float': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.decimal }).to eq @all_foos.map { |x| x.assoc&.decimal }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.decimal == right_result.assoc.decimal
              expect(left_result.assoc.computed_float).to be >= right_result.assoc.computed_float
            end
          end
        end
      end

      context '{ assoc: { computed_decimal: :asc, float: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_decimal': :asc, 'float': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_decimal }).to eq @all_foos.map { |x| x.assoc&.computed_decimal }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_decimal == right_result.assoc.computed_decimal
              expect(left_result.assoc.float).to be >= right_result.assoc.float
            end
          end
        end
      end

      context '{ decimal: :desc, assoc: { float: :asc } }' do
        let(:instructions) do
          { 'decimal': :desc, assoc: { 'float': :asc } }
        end

        it do
          expect(result.map(&:decimal)).to eq @all_foos.map(&:decimal).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.decimal == right_result.decimal
              expect(left_result.assoc.float).to be <= right_result.assoc.float
            end
          end
        end
      end

      context '{ computed_decimal: :asc, assoc: { float: :asc } }' do
        let(:instructions) do
          { 'computed_decimal': :asc, assoc: { 'float': :asc } }
        end

        it do
          expect(result.map(&:computed_decimal)).to eq @all_foos.map(&:computed_decimal).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_decimal == right_result.computed_decimal
              expect(left_result.assoc.float).to be <= right_result.assoc.float
            end
          end
        end
      end

      context '{ decimal: :desc, assoc: { computed_float: :desc } }' do
        let(:instructions) do
          { 'decimal': :desc, assoc: { 'computed_float': :desc } }
        end

        it do
          expect(result.map(&:decimal)).to eq @all_foos.map(&:decimal).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.decimal == right_result.decimal
              expect(left_result.assoc.computed_float).to be >= right_result.assoc.computed_float
            end
          end
        end
      end

      context '{ computed_decimal: :asc, assoc: { computed_float: :desc } }' do
        let(:instructions) do
          { 'computed_decimal': :asc, assoc: { 'computed_float': :desc } }
        end

        it do
          expect(result.map(&:computed_decimal)).to eq @all_foos.map(&:computed_decimal).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_decimal == right_result.computed_decimal
              expect(left_result.assoc.computed_float).to be >= right_result.assoc.computed_float
            end
          end
        end
      end

      context '{ assoc: { decimal: :desc }, float: :asc }' do
        let(:instructions) do
          { assoc: { 'decimal': :desc }, 'float': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.decimal }).to eq @all_foos.map { |x| x.assoc&.decimal }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.decimal == right_result.assoc.decimal
              expect(left_result.float).to be <= right_result.float
            end
          end
        end
      end

      context '{ assoc: { computed_decimal: :asc }, computed_float: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_decimal': :asc }, 'computed_float': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_decimal }).to eq @all_foos.map { |x| x.assoc&.computed_decimal }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_decimal == right_result.assoc.computed_decimal
              expect(left_result.computed_float).to be <= right_result.computed_float
            end
          end
        end
      end

      context '{ assoc: { decimal: :asc }, computed_float: :desc }' do
        let(:instructions) do
          { assoc: { 'decimal': :asc }, 'computed_float': :desc }
        end

        it do
          expect(result.map { |x| x.assoc&.decimal }).to eq @all_foos.map { |x| x.assoc&.decimal }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.decimal == right_result.assoc.decimal
              expect(left_result.computed_float).to be >= right_result.computed_float
            end
          end
        end
      end

      context '{ assoc: { computed_decimal: :desc }, float: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_decimal': :desc }, 'float': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_decimal }).to eq @all_foos.map { |x| x.assoc&.computed_decimal }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_decimal == right_result.assoc.computed_decimal
              expect(left_result.float).to be <= right_result.float
            end
          end
        end
      end
    end

    context 'with DECIMAL and INTEGER type' do
      context '{ decimal: :asc, integer: :asc }' do
        let(:instructions) do
          { 'decimal': :asc, 'integer': :asc }
        end

        it do
          expect(result.map(&:decimal)).to eq @all_foos.map(&:decimal).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.decimal == right_result.decimal
              expect(left_result.integer).to be <= right_result.integer
            end
          end
        end
      end

      context '{ decimal: :desc, integer: :desc }' do
        let(:instructions) do
          { 'decimal': :desc, 'integer': :desc }
        end

        it do
          expect(result.map(&:decimal)).to eq @all_foos.map(&:decimal).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.decimal == right_result.decimal
              expect(left_result.integer).to be >= right_result.integer
            end
          end
        end
      end

      context '{ decimal: :asc, integer: :desc }' do
        let(:instructions) do
          { 'decimal': :asc, 'integer': :desc }
        end

        it do
          expect(result.map(&:decimal)).to eq @all_foos.map(&:decimal).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.decimal == right_result.decimal
              expect(left_result.integer).to be >= right_result.integer
            end
          end
        end
      end

      context '{ decimal: :desc, integer: :asc }' do
        let(:instructions) do
          { 'decimal': :desc, 'integer': :asc }
        end

        it do
          expect(result.map(&:decimal)).to eq @all_foos.map(&:decimal).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.decimal == right_result.decimal
              expect(left_result.integer).to be <= right_result.integer
            end
          end
        end
      end


      context '{ computed_decimal: :asc, computed_integer: :asc }' do
        let(:instructions) do
          { 'computed_decimal': :asc, 'computed_integer': :asc }
        end

        it do
          expect(result.map(&:computed_decimal)).to eq @all_foos.map(&:computed_decimal).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_decimal == right_result.computed_decimal
              expect(left_result.computed_integer).to be <= right_result.computed_integer
            end
          end
        end
      end

      context '{ decimal: :desc, computed_integer: :desc }' do
        let(:instructions) do
          { 'decimal': :desc, 'computed_integer': :desc }
        end

        it do
          expect(result.map(&:decimal)).to eq @all_foos.map(&:decimal).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.decimal == right_result.decimal
              expect(left_result.computed_integer).to be >= right_result.computed_integer
            end
          end
        end
      end

      context '{ computed_decimal: :asc, integer: :desc }' do
        let(:instructions) do
          { 'computed_decimal': :asc, 'integer': :desc }
        end

        it do
          expect(result.map(&:computed_decimal)).to eq @all_foos.map(&:computed_decimal).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_decimal == right_result.computed_decimal
              expect(left_result.integer).to be >= right_result.integer
            end
          end
        end
      end

      context '{ assoc: { decimal: :desc, integer: :asc } }' do
        let(:instructions) do
          { assoc: { 'decimal': :desc, 'integer': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.decimal }).to eq @all_foos.map { |x| x.assoc&.decimal }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.decimal == right_result.assoc.decimal
              expect(left_result.assoc.integer).to be <= right_result.assoc.integer
            end
          end
        end
      end

      context '{ assoc: { computed_decimal: :asc, computed_integer: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_decimal': :asc, 'computed_integer': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_decimal }).to eq @all_foos.map { |x| x.assoc&.computed_decimal }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_decimal == right_result.assoc.computed_decimal
              expect(left_result.assoc.computed_integer).to be <= right_result.assoc.computed_integer
            end
          end
        end
      end

      context '{ assoc: { decimal: :desc, computed_integer: :desc } }' do
        let(:instructions) do
          { assoc: { 'decimal': :desc, 'computed_integer': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.decimal }).to eq @all_foos.map { |x| x.assoc&.decimal }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.decimal == right_result.assoc.decimal
              expect(left_result.assoc.computed_integer).to be >= right_result.assoc.computed_integer
            end
          end
        end
      end

      context '{ assoc: { computed_decimal: :asc, integer: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_decimal': :asc, 'integer': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_decimal }).to eq @all_foos.map { |x| x.assoc&.computed_decimal }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_decimal == right_result.assoc.computed_decimal
              expect(left_result.assoc.integer).to be >= right_result.assoc.integer
            end
          end
        end
      end

      context '{ decimal: :desc, assoc: { integer: :asc } }' do
        let(:instructions) do
          { 'decimal': :desc, assoc: { 'integer': :asc } }
        end

        it do
          expect(result.map(&:decimal)).to eq @all_foos.map(&:decimal).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.decimal == right_result.decimal
              expect(left_result.assoc.integer).to be <= right_result.assoc.integer
            end
          end
        end
      end

      context '{ computed_decimal: :asc, assoc: { integer: :asc } }' do
        let(:instructions) do
          { 'computed_decimal': :asc, assoc: { 'integer': :asc } }
        end

        it do
          expect(result.map(&:computed_decimal)).to eq @all_foos.map(&:computed_decimal).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_decimal == right_result.computed_decimal
              expect(left_result.assoc.integer).to be <= right_result.assoc.integer
            end
          end
        end
      end

      context '{ decimal: :desc, assoc: { computed_integer: :desc } }' do
        let(:instructions) do
          { 'decimal': :desc, assoc: { 'computed_integer': :desc } }
        end

        it do
          expect(result.map(&:decimal)).to eq @all_foos.map(&:decimal).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.decimal == right_result.decimal
              expect(left_result.assoc.computed_integer).to be >= right_result.assoc.computed_integer
            end
          end
        end
      end

      context '{ computed_decimal: :asc, assoc: { computed_integer: :desc } }' do
        let(:instructions) do
          { 'computed_decimal': :asc, assoc: { 'computed_integer': :desc } }
        end

        it do
          expect(result.map(&:computed_decimal)).to eq @all_foos.map(&:computed_decimal).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_decimal == right_result.computed_decimal
              expect(left_result.assoc.computed_integer).to be >= right_result.assoc.computed_integer
            end
          end
        end
      end

      context '{ assoc: { decimal: :desc }, integer: :asc }' do
        let(:instructions) do
          { assoc: { 'decimal': :desc }, 'integer': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.decimal }).to eq @all_foos.map { |x| x.assoc&.decimal }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.decimal == right_result.assoc.decimal
              expect(left_result.integer).to be <= right_result.integer
            end
          end
        end
      end

      context '{ assoc: { computed_decimal: :asc }, computed_integer: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_decimal': :asc }, 'computed_integer': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_decimal }).to eq @all_foos.map { |x| x.assoc&.computed_decimal }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_decimal == right_result.assoc.computed_decimal
              expect(left_result.computed_integer).to be <= right_result.computed_integer
            end
          end
        end
      end

      context '{ assoc: { decimal: :asc }, computed_integer: :desc }' do
        let(:instructions) do
          { assoc: { 'decimal': :asc }, 'computed_integer': :desc }
        end

        it do
          expect(result.map { |x| x.assoc&.decimal }).to eq @all_foos.map { |x| x.assoc&.decimal }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.decimal == right_result.assoc.decimal
              expect(left_result.computed_integer).to be >= right_result.computed_integer
            end
          end
        end
      end

      context '{ assoc: { computed_decimal: :desc }, integer: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_decimal': :desc }, 'integer': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_decimal }).to eq @all_foos.map { |x| x.assoc&.computed_decimal }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_decimal == right_result.assoc.computed_decimal
              expect(left_result.integer).to be <= right_result.integer
            end
          end
        end
      end
    end

    context 'with DECIMAL and STRING type' do
      context '{ decimal: :asc, string: :asc }' do
        let(:instructions) do
          { 'decimal': :asc, 'string': :asc }
        end

        it do
          expect(result.map(&:decimal)).to eq @all_foos.map(&:decimal).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.decimal == right_result.decimal
              expect(left_result.string).to be <= right_result.string
            end
          end
        end
      end

      context '{ decimal: :desc, string: :desc }' do
        let(:instructions) do
          { 'decimal': :desc, 'string': :desc }
        end

        it do
          expect(result.map(&:decimal)).to eq @all_foos.map(&:decimal).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.decimal == right_result.decimal
              expect(left_result.string).to be >= right_result.string
            end
          end
        end
      end

      context '{ decimal: :asc, string: :desc }' do
        let(:instructions) do
          { 'decimal': :asc, 'string': :desc }
        end

        it do
          expect(result.map(&:decimal)).to eq @all_foos.map(&:decimal).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.decimal == right_result.decimal
              expect(left_result.string).to be >= right_result.string
            end
          end
        end
      end

      context '{ decimal: :desc, string: :asc }' do
        let(:instructions) do
          { 'decimal': :desc, 'string': :asc }
        end

        it do
          expect(result.map(&:decimal)).to eq @all_foos.map(&:decimal).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.decimal == right_result.decimal
              expect(left_result.string).to be <= right_result.string
            end
          end
        end
      end


      context '{ computed_decimal: :asc, computed_string: :asc }' do
        let(:instructions) do
          { 'computed_decimal': :asc, 'computed_string': :asc }
        end

        it do
          expect(result.map(&:computed_decimal)).to eq @all_foos.map(&:computed_decimal).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_decimal == right_result.computed_decimal
              expect(left_result.computed_string).to be <= right_result.computed_string
            end
          end
        end
      end

      context '{ decimal: :desc, computed_string: :desc }' do
        let(:instructions) do
          { 'decimal': :desc, 'computed_string': :desc }
        end

        it do
          expect(result.map(&:decimal)).to eq @all_foos.map(&:decimal).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.decimal == right_result.decimal
              expect(left_result.computed_string).to be >= right_result.computed_string
            end
          end
        end
      end

      context '{ computed_decimal: :asc, string: :desc }' do
        let(:instructions) do
          { 'computed_decimal': :asc, 'string': :desc }
        end

        it do
          expect(result.map(&:computed_decimal)).to eq @all_foos.map(&:computed_decimal).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_decimal == right_result.computed_decimal
              expect(left_result.string).to be >= right_result.string
            end
          end
        end
      end

      context '{ assoc: { decimal: :desc, string: :asc } }' do
        let(:instructions) do
          { assoc: { 'decimal': :desc, 'string': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.decimal }).to eq @all_foos.map { |x| x.assoc&.decimal }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.decimal == right_result.assoc.decimal
              expect(left_result.assoc.string).to be <= right_result.assoc.string
            end
          end
        end
      end

      context '{ assoc: { computed_decimal: :asc, computed_string: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_decimal': :asc, 'computed_string': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_decimal }).to eq @all_foos.map { |x| x.assoc&.computed_decimal }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_decimal == right_result.assoc.computed_decimal
              expect(left_result.assoc.computed_string).to be <= right_result.assoc.computed_string
            end
          end
        end
      end

      context '{ assoc: { decimal: :desc, computed_string: :desc } }' do
        let(:instructions) do
          { assoc: { 'decimal': :desc, 'computed_string': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.decimal }).to eq @all_foos.map { |x| x.assoc&.decimal }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.decimal == right_result.assoc.decimal
              expect(left_result.assoc.computed_string).to be >= right_result.assoc.computed_string
            end
          end
        end
      end

      context '{ assoc: { computed_decimal: :asc, string: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_decimal': :asc, 'string': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_decimal }).to eq @all_foos.map { |x| x.assoc&.computed_decimal }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_decimal == right_result.assoc.computed_decimal
              expect(left_result.assoc.string).to be >= right_result.assoc.string
            end
          end
        end
      end

      context '{ decimal: :desc, assoc: { string: :asc } }' do
        let(:instructions) do
          { 'decimal': :desc, assoc: { 'string': :asc } }
        end

        it do
          expect(result.map(&:decimal)).to eq @all_foos.map(&:decimal).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.decimal == right_result.decimal
              expect(left_result.assoc.string).to be <= right_result.assoc.string
            end
          end
        end
      end

      context '{ computed_decimal: :asc, assoc: { string: :asc } }' do
        let(:instructions) do
          { 'computed_decimal': :asc, assoc: { 'string': :asc } }
        end

        it do
          expect(result.map(&:computed_decimal)).to eq @all_foos.map(&:computed_decimal).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_decimal == right_result.computed_decimal
              expect(left_result.assoc.string).to be <= right_result.assoc.string
            end
          end
        end
      end

      context '{ decimal: :desc, assoc: { computed_string: :desc } }' do
        let(:instructions) do
          { 'decimal': :desc, assoc: { 'computed_string': :desc } }
        end

        it do
          expect(result.map(&:decimal)).to eq @all_foos.map(&:decimal).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.decimal == right_result.decimal
              expect(left_result.assoc.computed_string).to be >= right_result.assoc.computed_string
            end
          end
        end
      end

      context '{ computed_decimal: :asc, assoc: { computed_string: :desc } }' do
        let(:instructions) do
          { 'computed_decimal': :asc, assoc: { 'computed_string': :desc } }
        end

        it do
          expect(result.map(&:computed_decimal)).to eq @all_foos.map(&:computed_decimal).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_decimal == right_result.computed_decimal
              expect(left_result.assoc.computed_string).to be >= right_result.assoc.computed_string
            end
          end
        end
      end

      context '{ assoc: { decimal: :desc }, string: :asc }' do
        let(:instructions) do
          { assoc: { 'decimal': :desc }, 'string': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.decimal }).to eq @all_foos.map { |x| x.assoc&.decimal }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.decimal == right_result.assoc.decimal
              expect(left_result.string).to be <= right_result.string
            end
          end
        end
      end

      context '{ assoc: { computed_decimal: :asc }, computed_string: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_decimal': :asc }, 'computed_string': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_decimal }).to eq @all_foos.map { |x| x.assoc&.computed_decimal }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_decimal == right_result.assoc.computed_decimal
              expect(left_result.computed_string).to be <= right_result.computed_string
            end
          end
        end
      end

      context '{ assoc: { decimal: :asc }, computed_string: :desc }' do
        let(:instructions) do
          { assoc: { 'decimal': :asc }, 'computed_string': :desc }
        end

        it do
          expect(result.map { |x| x.assoc&.decimal }).to eq @all_foos.map { |x| x.assoc&.decimal }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.decimal == right_result.assoc.decimal
              expect(left_result.computed_string).to be >= right_result.computed_string
            end
          end
        end
      end

      context '{ assoc: { computed_decimal: :desc }, string: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_decimal': :desc }, 'string': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_decimal }).to eq @all_foos.map { |x| x.assoc&.computed_decimal }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_decimal == right_result.assoc.computed_decimal
              expect(left_result.string).to be <= right_result.string
            end
          end
        end
      end
    end

    context 'with DECIMAL and TEXT type' do
      context '{ decimal: :asc, text: :asc }' do
        let(:instructions) do
          { 'decimal': :asc, 'text': :asc }
        end

        it do
          expect(result.map(&:decimal)).to eq @all_foos.map(&:decimal).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.decimal == right_result.decimal
              expect(left_result.text).to be <= right_result.text
            end
          end
        end
      end

      context '{ decimal: :desc, text: :desc }' do
        let(:instructions) do
          { 'decimal': :desc, 'text': :desc }
        end

        it do
          expect(result.map(&:decimal)).to eq @all_foos.map(&:decimal).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.decimal == right_result.decimal
              expect(left_result.text).to be >= right_result.text
            end
          end
        end
      end

      context '{ decimal: :asc, text: :desc }' do
        let(:instructions) do
          { 'decimal': :asc, 'text': :desc }
        end

        it do
          expect(result.map(&:decimal)).to eq @all_foos.map(&:decimal).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.decimal == right_result.decimal
              expect(left_result.text).to be >= right_result.text
            end
          end
        end
      end

      context '{ decimal: :desc, text: :asc }' do
        let(:instructions) do
          { 'decimal': :desc, 'text': :asc }
        end

        it do
          expect(result.map(&:decimal)).to eq @all_foos.map(&:decimal).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.decimal == right_result.decimal
              expect(left_result.text).to be <= right_result.text
            end
          end
        end
      end


      context '{ computed_decimal: :asc, computed_text: :asc }' do
        let(:instructions) do
          { 'computed_decimal': :asc, 'computed_text': :asc }
        end

        it do
          expect(result.map(&:computed_decimal)).to eq @all_foos.map(&:computed_decimal).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_decimal == right_result.computed_decimal
              expect(left_result.computed_text).to be <= right_result.computed_text
            end
          end
        end
      end

      context '{ decimal: :desc, computed_text: :desc }' do
        let(:instructions) do
          { 'decimal': :desc, 'computed_text': :desc }
        end

        it do
          expect(result.map(&:decimal)).to eq @all_foos.map(&:decimal).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.decimal == right_result.decimal
              expect(left_result.computed_text).to be >= right_result.computed_text
            end
          end
        end
      end

      context '{ computed_decimal: :asc, text: :desc }' do
        let(:instructions) do
          { 'computed_decimal': :asc, 'text': :desc }
        end

        it do
          expect(result.map(&:computed_decimal)).to eq @all_foos.map(&:computed_decimal).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_decimal == right_result.computed_decimal
              expect(left_result.text).to be >= right_result.text
            end
          end
        end
      end

      context '{ assoc: { decimal: :desc, text: :asc } }' do
        let(:instructions) do
          { assoc: { 'decimal': :desc, 'text': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.decimal }).to eq @all_foos.map { |x| x.assoc&.decimal }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.decimal == right_result.assoc.decimal
              expect(left_result.assoc.text).to be <= right_result.assoc.text
            end
          end
        end
      end

      context '{ assoc: { computed_decimal: :asc, computed_text: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_decimal': :asc, 'computed_text': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_decimal }).to eq @all_foos.map { |x| x.assoc&.computed_decimal }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_decimal == right_result.assoc.computed_decimal
              expect(left_result.assoc.computed_text).to be <= right_result.assoc.computed_text
            end
          end
        end
      end

      context '{ assoc: { decimal: :desc, computed_text: :desc } }' do
        let(:instructions) do
          { assoc: { 'decimal': :desc, 'computed_text': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.decimal }).to eq @all_foos.map { |x| x.assoc&.decimal }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.decimal == right_result.assoc.decimal
              expect(left_result.assoc.computed_text).to be >= right_result.assoc.computed_text
            end
          end
        end
      end

      context '{ assoc: { computed_decimal: :asc, text: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_decimal': :asc, 'text': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_decimal }).to eq @all_foos.map { |x| x.assoc&.computed_decimal }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_decimal == right_result.assoc.computed_decimal
              expect(left_result.assoc.text).to be >= right_result.assoc.text
            end
          end
        end
      end

      context '{ decimal: :desc, assoc: { text: :asc } }' do
        let(:instructions) do
          { 'decimal': :desc, assoc: { 'text': :asc } }
        end

        it do
          expect(result.map(&:decimal)).to eq @all_foos.map(&:decimal).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.decimal == right_result.decimal
              expect(left_result.assoc.text).to be <= right_result.assoc.text
            end
          end
        end
      end

      context '{ computed_decimal: :asc, assoc: { text: :asc } }' do
        let(:instructions) do
          { 'computed_decimal': :asc, assoc: { 'text': :asc } }
        end

        it do
          expect(result.map(&:computed_decimal)).to eq @all_foos.map(&:computed_decimal).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_decimal == right_result.computed_decimal
              expect(left_result.assoc.text).to be <= right_result.assoc.text
            end
          end
        end
      end

      context '{ decimal: :desc, assoc: { computed_text: :desc } }' do
        let(:instructions) do
          { 'decimal': :desc, assoc: { 'computed_text': :desc } }
        end

        it do
          expect(result.map(&:decimal)).to eq @all_foos.map(&:decimal).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.decimal == right_result.decimal
              expect(left_result.assoc.computed_text).to be >= right_result.assoc.computed_text
            end
          end
        end
      end

      context '{ computed_decimal: :asc, assoc: { computed_text: :desc } }' do
        let(:instructions) do
          { 'computed_decimal': :asc, assoc: { 'computed_text': :desc } }
        end

        it do
          expect(result.map(&:computed_decimal)).to eq @all_foos.map(&:computed_decimal).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_decimal == right_result.computed_decimal
              expect(left_result.assoc.computed_text).to be >= right_result.assoc.computed_text
            end
          end
        end
      end

      context '{ assoc: { decimal: :desc }, text: :asc }' do
        let(:instructions) do
          { assoc: { 'decimal': :desc }, 'text': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.decimal }).to eq @all_foos.map { |x| x.assoc&.decimal }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.decimal == right_result.assoc.decimal
              expect(left_result.text).to be <= right_result.text
            end
          end
        end
      end

      context '{ assoc: { computed_decimal: :asc }, computed_text: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_decimal': :asc }, 'computed_text': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_decimal }).to eq @all_foos.map { |x| x.assoc&.computed_decimal }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_decimal == right_result.assoc.computed_decimal
              expect(left_result.computed_text).to be <= right_result.computed_text
            end
          end
        end
      end

      context '{ assoc: { decimal: :asc }, computed_text: :desc }' do
        let(:instructions) do
          { assoc: { 'decimal': :asc }, 'computed_text': :desc }
        end

        it do
          expect(result.map { |x| x.assoc&.decimal }).to eq @all_foos.map { |x| x.assoc&.decimal }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.decimal == right_result.assoc.decimal
              expect(left_result.computed_text).to be >= right_result.computed_text
            end
          end
        end
      end

      context '{ assoc: { computed_decimal: :desc }, text: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_decimal': :desc }, 'text': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_decimal }).to eq @all_foos.map { |x| x.assoc&.computed_decimal }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_decimal == right_result.assoc.computed_decimal
              expect(left_result.text).to be <= right_result.text
            end
          end
        end
      end
    end

    context 'with DECIMAL and TIME type' do
      context '{ decimal: :asc, time: :asc }' do
        let(:instructions) do
          { 'decimal': :asc, 'time': :asc }
        end

        it do
          expect(result.map(&:decimal)).to eq @all_foos.map(&:decimal).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.decimal == right_result.decimal
              expect(left_result.time).to be <= right_result.time
            end
          end
        end
      end

      context '{ decimal: :desc, time: :desc }' do
        let(:instructions) do
          { 'decimal': :desc, 'time': :desc }
        end

        it do
          expect(result.map(&:decimal)).to eq @all_foos.map(&:decimal).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.decimal == right_result.decimal
              expect(left_result.time).to be >= right_result.time
            end
          end
        end
      end

      context '{ decimal: :asc, time: :desc }' do
        let(:instructions) do
          { 'decimal': :asc, 'time': :desc }
        end

        it do
          expect(result.map(&:decimal)).to eq @all_foos.map(&:decimal).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.decimal == right_result.decimal
              expect(left_result.time).to be >= right_result.time
            end
          end
        end
      end

      context '{ decimal: :desc, time: :asc }' do
        let(:instructions) do
          { 'decimal': :desc, 'time': :asc }
        end

        it do
          expect(result.map(&:decimal)).to eq @all_foos.map(&:decimal).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.decimal == right_result.decimal
              expect(left_result.time).to be <= right_result.time
            end
          end
        end
      end


      context '{ computed_decimal: :asc, computed_time: :asc }' do
        let(:instructions) do
          { 'computed_decimal': :asc, 'computed_time': :asc }
        end

        it do
          expect(result.map(&:computed_decimal)).to eq @all_foos.map(&:computed_decimal).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_decimal == right_result.computed_decimal
              expect(left_result.computed_time).to be <= right_result.computed_time
            end
          end
        end
      end

      context '{ decimal: :desc, computed_time: :desc }' do
        let(:instructions) do
          { 'decimal': :desc, 'computed_time': :desc }
        end

        it do
          expect(result.map(&:decimal)).to eq @all_foos.map(&:decimal).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.decimal == right_result.decimal
              expect(left_result.computed_time).to be >= right_result.computed_time
            end
          end
        end
      end

      context '{ computed_decimal: :asc, time: :desc }' do
        let(:instructions) do
          { 'computed_decimal': :asc, 'time': :desc }
        end

        it do
          expect(result.map(&:computed_decimal)).to eq @all_foos.map(&:computed_decimal).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_decimal == right_result.computed_decimal
              expect(left_result.time).to be >= right_result.time
            end
          end
        end
      end

      context '{ assoc: { decimal: :desc, time: :asc } }' do
        let(:instructions) do
          { assoc: { 'decimal': :desc, 'time': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.decimal }).to eq @all_foos.map { |x| x.assoc&.decimal }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.decimal == right_result.assoc.decimal
              expect(left_result.assoc.time).to be <= right_result.assoc.time
            end
          end
        end
      end

      context '{ assoc: { computed_decimal: :asc, computed_time: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_decimal': :asc, 'computed_time': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_decimal }).to eq @all_foos.map { |x| x.assoc&.computed_decimal }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_decimal == right_result.assoc.computed_decimal
              expect(left_result.assoc.computed_time).to be <= right_result.assoc.computed_time
            end
          end
        end
      end

      context '{ assoc: { decimal: :desc, computed_time: :desc } }' do
        let(:instructions) do
          { assoc: { 'decimal': :desc, 'computed_time': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.decimal }).to eq @all_foos.map { |x| x.assoc&.decimal }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.decimal == right_result.assoc.decimal
              expect(left_result.assoc.computed_time).to be >= right_result.assoc.computed_time
            end
          end
        end
      end

      context '{ assoc: { computed_decimal: :asc, time: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_decimal': :asc, 'time': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_decimal }).to eq @all_foos.map { |x| x.assoc&.computed_decimal }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_decimal == right_result.assoc.computed_decimal
              expect(left_result.assoc.time).to be >= right_result.assoc.time
            end
          end
        end
      end

      context '{ decimal: :desc, assoc: { time: :asc } }' do
        let(:instructions) do
          { 'decimal': :desc, assoc: { 'time': :asc } }
        end

        it do
          expect(result.map(&:decimal)).to eq @all_foos.map(&:decimal).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.decimal == right_result.decimal
              expect(left_result.assoc.time).to be <= right_result.assoc.time
            end
          end
        end
      end

      context '{ computed_decimal: :asc, assoc: { time: :asc } }' do
        let(:instructions) do
          { 'computed_decimal': :asc, assoc: { 'time': :asc } }
        end

        it do
          expect(result.map(&:computed_decimal)).to eq @all_foos.map(&:computed_decimal).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_decimal == right_result.computed_decimal
              expect(left_result.assoc.time).to be <= right_result.assoc.time
            end
          end
        end
      end

      context '{ decimal: :desc, assoc: { computed_time: :desc } }' do
        let(:instructions) do
          { 'decimal': :desc, assoc: { 'computed_time': :desc } }
        end

        it do
          expect(result.map(&:decimal)).to eq @all_foos.map(&:decimal).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.decimal == right_result.decimal
              expect(left_result.assoc.computed_time).to be >= right_result.assoc.computed_time
            end
          end
        end
      end

      context '{ computed_decimal: :asc, assoc: { computed_time: :desc } }' do
        let(:instructions) do
          { 'computed_decimal': :asc, assoc: { 'computed_time': :desc } }
        end

        it do
          expect(result.map(&:computed_decimal)).to eq @all_foos.map(&:computed_decimal).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_decimal == right_result.computed_decimal
              expect(left_result.assoc.computed_time).to be >= right_result.assoc.computed_time
            end
          end
        end
      end

      context '{ assoc: { decimal: :desc }, time: :asc }' do
        let(:instructions) do
          { assoc: { 'decimal': :desc }, 'time': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.decimal }).to eq @all_foos.map { |x| x.assoc&.decimal }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.decimal == right_result.assoc.decimal
              expect(left_result.time).to be <= right_result.time
            end
          end
        end
      end

      context '{ assoc: { computed_decimal: :asc }, computed_time: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_decimal': :asc }, 'computed_time': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_decimal }).to eq @all_foos.map { |x| x.assoc&.computed_decimal }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_decimal == right_result.assoc.computed_decimal
              expect(left_result.computed_time).to be <= right_result.computed_time
            end
          end
        end
      end

      context '{ assoc: { decimal: :asc }, computed_time: :desc }' do
        let(:instructions) do
          { assoc: { 'decimal': :asc }, 'computed_time': :desc }
        end

        it do
          expect(result.map { |x| x.assoc&.decimal }).to eq @all_foos.map { |x| x.assoc&.decimal }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.decimal == right_result.assoc.decimal
              expect(left_result.computed_time).to be >= right_result.computed_time
            end
          end
        end
      end

      context '{ assoc: { computed_decimal: :desc }, time: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_decimal': :desc }, 'time': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_decimal }).to eq @all_foos.map { |x| x.assoc&.computed_decimal }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_decimal == right_result.assoc.computed_decimal
              expect(left_result.time).to be <= right_result.time
            end
          end
        end
      end
    end


    context 'with FLOAT and INTEGER type' do
      context '{ float: :asc, integer: :asc }' do
        let(:instructions) do
          { 'float': :asc, 'integer': :asc }
        end

        it do
          expect(result.map(&:float)).to eq @all_foos.map(&:float).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.float == right_result.float
              expect(left_result.integer).to be <= right_result.integer
            end
          end
        end
      end

      context '{ float: :desc, integer: :desc }' do
        let(:instructions) do
          { 'float': :desc, 'integer': :desc }
        end

        it do
          expect(result.map(&:float)).to eq @all_foos.map(&:float).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.float == right_result.float
              expect(left_result.integer).to be >= right_result.integer
            end
          end
        end
      end

      context '{ float: :asc, integer: :desc }' do
        let(:instructions) do
          { 'float': :asc, 'integer': :desc }
        end

        it do
          expect(result.map(&:float)).to eq @all_foos.map(&:float).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.float == right_result.float
              expect(left_result.integer).to be >= right_result.integer
            end
          end
        end
      end

      context '{ float: :desc, integer: :asc }' do
        let(:instructions) do
          { 'float': :desc, 'integer': :asc }
        end

        it do
          expect(result.map(&:float)).to eq @all_foos.map(&:float).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.float == right_result.float
              expect(left_result.integer).to be <= right_result.integer
            end
          end
        end
      end


      context '{ computed_float: :asc, computed_integer: :asc }' do
        let(:instructions) do
          { 'computed_float': :asc, 'computed_integer': :asc }
        end

        it do
          expect(result.map(&:computed_float)).to eq @all_foos.map(&:computed_float).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_float == right_result.computed_float
              expect(left_result.computed_integer).to be <= right_result.computed_integer
            end
          end
        end
      end

      context '{ float: :desc, computed_integer: :desc }' do
        let(:instructions) do
          { 'float': :desc, 'computed_integer': :desc }
        end

        it do
          expect(result.map(&:float)).to eq @all_foos.map(&:float).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.float == right_result.float
              expect(left_result.computed_integer).to be >= right_result.computed_integer
            end
          end
        end
      end

      context '{ computed_float: :asc, integer: :desc }' do
        let(:instructions) do
          { 'computed_float': :asc, 'integer': :desc }
        end

        it do
          expect(result.map(&:computed_float)).to eq @all_foos.map(&:computed_float).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_float == right_result.computed_float
              expect(left_result.integer).to be >= right_result.integer
            end
          end
        end
      end

      context '{ assoc: { float: :desc, integer: :asc } }' do
        let(:instructions) do
          { assoc: { 'float': :desc, 'integer': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.float }).to eq @all_foos.map { |x| x.assoc&.float }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.float == right_result.assoc.float
              expect(left_result.assoc.integer).to be <= right_result.assoc.integer
            end
          end
        end
      end

      context '{ assoc: { computed_float: :asc, computed_integer: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_float': :asc, 'computed_integer': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_float }).to eq @all_foos.map { |x| x.assoc&.computed_float }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_float == right_result.assoc.computed_float
              expect(left_result.assoc.computed_integer).to be <= right_result.assoc.computed_integer
            end
          end
        end
      end

      context '{ assoc: { float: :desc, computed_integer: :desc } }' do
        let(:instructions) do
          { assoc: { 'float': :desc, 'computed_integer': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.float }).to eq @all_foos.map { |x| x.assoc&.float }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.float == right_result.assoc.float
              expect(left_result.assoc.computed_integer).to be >= right_result.assoc.computed_integer
            end
          end
        end
      end

      context '{ assoc: { computed_float: :asc, integer: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_float': :asc, 'integer': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_float }).to eq @all_foos.map { |x| x.assoc&.computed_float }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_float == right_result.assoc.computed_float
              expect(left_result.assoc.integer).to be >= right_result.assoc.integer
            end
          end
        end
      end

      context '{ float: :desc, assoc: { integer: :asc } }' do
        let(:instructions) do
          { 'float': :desc, assoc: { 'integer': :asc } }
        end

        it do
          expect(result.map(&:float)).to eq @all_foos.map(&:float).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.float == right_result.float
              expect(left_result.assoc.integer).to be <= right_result.assoc.integer
            end
          end
        end
      end

      context '{ computed_float: :asc, assoc: { integer: :asc } }' do
        let(:instructions) do
          { 'computed_float': :asc, assoc: { 'integer': :asc } }
        end

        it do
          expect(result.map(&:computed_float)).to eq @all_foos.map(&:computed_float).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_float == right_result.computed_float
              expect(left_result.assoc.integer).to be <= right_result.assoc.integer
            end
          end
        end
      end

      context '{ float: :desc, assoc: { computed_integer: :desc } }' do
        let(:instructions) do
          { 'float': :desc, assoc: { 'computed_integer': :desc } }
        end

        it do
          expect(result.map(&:float)).to eq @all_foos.map(&:float).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.float == right_result.float
              expect(left_result.assoc.computed_integer).to be >= right_result.assoc.computed_integer
            end
          end
        end
      end

      context '{ computed_float: :asc, assoc: { computed_integer: :desc } }' do
        let(:instructions) do
          { 'computed_float': :asc, assoc: { 'computed_integer': :desc } }
        end

        it do
          expect(result.map(&:computed_float)).to eq @all_foos.map(&:computed_float).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_float == right_result.computed_float
              expect(left_result.assoc.computed_integer).to be >= right_result.assoc.computed_integer
            end
          end
        end
      end

      context '{ assoc: { float: :desc }, integer: :asc }' do
        let(:instructions) do
          { assoc: { 'float': :desc }, 'integer': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.float }).to eq @all_foos.map { |x| x.assoc&.float }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.float == right_result.assoc.float
              expect(left_result.integer).to be <= right_result.integer
            end
          end
        end
      end

      context '{ assoc: { computed_float: :asc }, computed_integer: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_float': :asc }, 'computed_integer': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_float }).to eq @all_foos.map { |x| x.assoc&.computed_float }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_float == right_result.assoc.computed_float
              expect(left_result.computed_integer).to be <= right_result.computed_integer
            end
          end
        end
      end

      context '{ assoc: { float: :asc }, computed_integer: :desc }' do
        let(:instructions) do
          { assoc: { 'float': :asc }, 'computed_integer': :desc }
        end

        it do
          expect(result.map { |x| x.assoc&.float }).to eq @all_foos.map { |x| x.assoc&.float }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.float == right_result.assoc.float
              expect(left_result.computed_integer).to be >= right_result.computed_integer
            end
          end
        end
      end

      context '{ assoc: { computed_float: :desc }, integer: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_float': :desc }, 'integer': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_float }).to eq @all_foos.map { |x| x.assoc&.computed_float }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_float == right_result.assoc.computed_float
              expect(left_result.integer).to be <= right_result.integer
            end
          end
        end
      end
    end

    context 'with FLOAT and STRING type' do
      context '{ float: :asc, string: :asc }' do
        let(:instructions) do
          { 'float': :asc, 'string': :asc }
        end

        it do
          expect(result.map(&:float)).to eq @all_foos.map(&:float).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.float == right_result.float
              expect(left_result.string).to be <= right_result.string
            end
          end
        end
      end

      context '{ float: :desc, string: :desc }' do
        let(:instructions) do
          { 'float': :desc, 'string': :desc }
        end

        it do
          expect(result.map(&:float)).to eq @all_foos.map(&:float).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.float == right_result.float
              expect(left_result.string).to be >= right_result.string
            end
          end
        end
      end

      context '{ float: :asc, string: :desc }' do
        let(:instructions) do
          { 'float': :asc, 'string': :desc }
        end

        it do
          expect(result.map(&:float)).to eq @all_foos.map(&:float).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.float == right_result.float
              expect(left_result.string).to be >= right_result.string
            end
          end
        end
      end

      context '{ float: :desc, string: :asc }' do
        let(:instructions) do
          { 'float': :desc, 'string': :asc }
        end

        it do
          expect(result.map(&:float)).to eq @all_foos.map(&:float).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.float == right_result.float
              expect(left_result.string).to be <= right_result.string
            end
          end
        end
      end


      context '{ computed_float: :asc, computed_string: :asc }' do
        let(:instructions) do
          { 'computed_float': :asc, 'computed_string': :asc }
        end

        it do
          expect(result.map(&:computed_float)).to eq @all_foos.map(&:computed_float).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_float == right_result.computed_float
              expect(left_result.computed_string).to be <= right_result.computed_string
            end
          end
        end
      end

      context '{ float: :desc, computed_string: :desc }' do
        let(:instructions) do
          { 'float': :desc, 'computed_string': :desc }
        end

        it do
          expect(result.map(&:float)).to eq @all_foos.map(&:float).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.float == right_result.float
              expect(left_result.computed_string).to be >= right_result.computed_string
            end
          end
        end
      end

      context '{ computed_float: :asc, string: :desc }' do
        let(:instructions) do
          { 'computed_float': :asc, 'string': :desc }
        end

        it do
          expect(result.map(&:computed_float)).to eq @all_foos.map(&:computed_float).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_float == right_result.computed_float
              expect(left_result.string).to be >= right_result.string
            end
          end
        end
      end

      context '{ assoc: { float: :desc, string: :asc } }' do
        let(:instructions) do
          { assoc: { 'float': :desc, 'string': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.float }).to eq @all_foos.map { |x| x.assoc&.float }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.float == right_result.assoc.float
              expect(left_result.assoc.string).to be <= right_result.assoc.string
            end
          end
        end
      end

      context '{ assoc: { computed_float: :asc, computed_string: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_float': :asc, 'computed_string': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_float }).to eq @all_foos.map { |x| x.assoc&.computed_float }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_float == right_result.assoc.computed_float
              expect(left_result.assoc.computed_string).to be <= right_result.assoc.computed_string
            end
          end
        end
      end

      context '{ assoc: { float: :desc, computed_string: :desc } }' do
        let(:instructions) do
          { assoc: { 'float': :desc, 'computed_string': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.float }).to eq @all_foos.map { |x| x.assoc&.float }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.float == right_result.assoc.float
              expect(left_result.assoc.computed_string).to be >= right_result.assoc.computed_string
            end
          end
        end
      end

      context '{ assoc: { computed_float: :asc, string: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_float': :asc, 'string': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_float }).to eq @all_foos.map { |x| x.assoc&.computed_float }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_float == right_result.assoc.computed_float
              expect(left_result.assoc.string).to be >= right_result.assoc.string
            end
          end
        end
      end

      context '{ float: :desc, assoc: { string: :asc } }' do
        let(:instructions) do
          { 'float': :desc, assoc: { 'string': :asc } }
        end

        it do
          expect(result.map(&:float)).to eq @all_foos.map(&:float).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.float == right_result.float
              expect(left_result.assoc.string).to be <= right_result.assoc.string
            end
          end
        end
      end

      context '{ computed_float: :asc, assoc: { string: :asc } }' do
        let(:instructions) do
          { 'computed_float': :asc, assoc: { 'string': :asc } }
        end

        it do
          expect(result.map(&:computed_float)).to eq @all_foos.map(&:computed_float).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_float == right_result.computed_float
              expect(left_result.assoc.string).to be <= right_result.assoc.string
            end
          end
        end
      end

      context '{ float: :desc, assoc: { computed_string: :desc } }' do
        let(:instructions) do
          { 'float': :desc, assoc: { 'computed_string': :desc } }
        end

        it do
          expect(result.map(&:float)).to eq @all_foos.map(&:float).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.float == right_result.float
              expect(left_result.assoc.computed_string).to be >= right_result.assoc.computed_string
            end
          end
        end
      end

      context '{ computed_float: :asc, assoc: { computed_string: :desc } }' do
        let(:instructions) do
          { 'computed_float': :asc, assoc: { 'computed_string': :desc } }
        end

        it do
          expect(result.map(&:computed_float)).to eq @all_foos.map(&:computed_float).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_float == right_result.computed_float
              expect(left_result.assoc.computed_string).to be >= right_result.assoc.computed_string
            end
          end
        end
      end

      context '{ assoc: { float: :desc }, string: :asc }' do
        let(:instructions) do
          { assoc: { 'float': :desc }, 'string': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.float }).to eq @all_foos.map { |x| x.assoc&.float }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.float == right_result.assoc.float
              expect(left_result.string).to be <= right_result.string
            end
          end
        end
      end

      context '{ assoc: { computed_float: :asc }, computed_string: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_float': :asc }, 'computed_string': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_float }).to eq @all_foos.map { |x| x.assoc&.computed_float }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_float == right_result.assoc.computed_float
              expect(left_result.computed_string).to be <= right_result.computed_string
            end
          end
        end
      end

      context '{ assoc: { float: :asc }, computed_string: :desc }' do
        let(:instructions) do
          { assoc: { 'float': :asc }, 'computed_string': :desc }
        end

        it do
          expect(result.map { |x| x.assoc&.float }).to eq @all_foos.map { |x| x.assoc&.float }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.float == right_result.assoc.float
              expect(left_result.computed_string).to be >= right_result.computed_string
            end
          end
        end
      end

      context '{ assoc: { computed_float: :desc }, string: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_float': :desc }, 'string': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_float }).to eq @all_foos.map { |x| x.assoc&.computed_float }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_float == right_result.assoc.computed_float
              expect(left_result.string).to be <= right_result.string
            end
          end
        end
      end
    end

    context 'with FLOAT and TEXT type' do
      context '{ float: :asc, text: :asc }' do
        let(:instructions) do
          { 'float': :asc, 'text': :asc }
        end

        it do
          expect(result.map(&:float)).to eq @all_foos.map(&:float).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.float == right_result.float
              expect(left_result.text).to be <= right_result.text
            end
          end
        end
      end

      context '{ float: :desc, text: :desc }' do
        let(:instructions) do
          { 'float': :desc, 'text': :desc }
        end

        it do
          expect(result.map(&:float)).to eq @all_foos.map(&:float).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.float == right_result.float
              expect(left_result.text).to be >= right_result.text
            end
          end
        end
      end

      context '{ float: :asc, text: :desc }' do
        let(:instructions) do
          { 'float': :asc, 'text': :desc }
        end

        it do
          expect(result.map(&:float)).to eq @all_foos.map(&:float).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.float == right_result.float
              expect(left_result.text).to be >= right_result.text
            end
          end
        end
      end

      context '{ float: :desc, text: :asc }' do
        let(:instructions) do
          { 'float': :desc, 'text': :asc }
        end

        it do
          expect(result.map(&:float)).to eq @all_foos.map(&:float).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.float == right_result.float
              expect(left_result.text).to be <= right_result.text
            end
          end
        end
      end


      context '{ computed_float: :asc, computed_text: :asc }' do
        let(:instructions) do
          { 'computed_float': :asc, 'computed_text': :asc }
        end

        it do
          expect(result.map(&:computed_float)).to eq @all_foos.map(&:computed_float).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_float == right_result.computed_float
              expect(left_result.computed_text).to be <= right_result.computed_text
            end
          end
        end
      end

      context '{ float: :desc, computed_text: :desc }' do
        let(:instructions) do
          { 'float': :desc, 'computed_text': :desc }
        end

        it do
          expect(result.map(&:float)).to eq @all_foos.map(&:float).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.float == right_result.float
              expect(left_result.computed_text).to be >= right_result.computed_text
            end
          end
        end
      end

      context '{ computed_float: :asc, text: :desc }' do
        let(:instructions) do
          { 'computed_float': :asc, 'text': :desc }
        end

        it do
          expect(result.map(&:computed_float)).to eq @all_foos.map(&:computed_float).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_float == right_result.computed_float
              expect(left_result.text).to be >= right_result.text
            end
          end
        end
      end

      context '{ assoc: { float: :desc, text: :asc } }' do
        let(:instructions) do
          { assoc: { 'float': :desc, 'text': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.float }).to eq @all_foos.map { |x| x.assoc&.float }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.float == right_result.assoc.float
              expect(left_result.assoc.text).to be <= right_result.assoc.text
            end
          end
        end
      end

      context '{ assoc: { computed_float: :asc, computed_text: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_float': :asc, 'computed_text': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_float }).to eq @all_foos.map { |x| x.assoc&.computed_float }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_float == right_result.assoc.computed_float
              expect(left_result.assoc.computed_text).to be <= right_result.assoc.computed_text
            end
          end
        end
      end

      context '{ assoc: { float: :desc, computed_text: :desc } }' do
        let(:instructions) do
          { assoc: { 'float': :desc, 'computed_text': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.float }).to eq @all_foos.map { |x| x.assoc&.float }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.float == right_result.assoc.float
              expect(left_result.assoc.computed_text).to be >= right_result.assoc.computed_text
            end
          end
        end
      end

      context '{ assoc: { computed_float: :asc, text: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_float': :asc, 'text': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_float }).to eq @all_foos.map { |x| x.assoc&.computed_float }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_float == right_result.assoc.computed_float
              expect(left_result.assoc.text).to be >= right_result.assoc.text
            end
          end
        end
      end

      context '{ float: :desc, assoc: { text: :asc } }' do
        let(:instructions) do
          { 'float': :desc, assoc: { 'text': :asc } }
        end

        it do
          expect(result.map(&:float)).to eq @all_foos.map(&:float).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.float == right_result.float
              expect(left_result.assoc.text).to be <= right_result.assoc.text
            end
          end
        end
      end

      context '{ computed_float: :asc, assoc: { text: :asc } }' do
        let(:instructions) do
          { 'computed_float': :asc, assoc: { 'text': :asc } }
        end

        it do
          expect(result.map(&:computed_float)).to eq @all_foos.map(&:computed_float).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_float == right_result.computed_float
              expect(left_result.assoc.text).to be <= right_result.assoc.text
            end
          end
        end
      end

      context '{ float: :desc, assoc: { computed_text: :desc } }' do
        let(:instructions) do
          { 'float': :desc, assoc: { 'computed_text': :desc } }
        end

        it do
          expect(result.map(&:float)).to eq @all_foos.map(&:float).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.float == right_result.float
              expect(left_result.assoc.computed_text).to be >= right_result.assoc.computed_text
            end
          end
        end
      end

      context '{ computed_float: :asc, assoc: { computed_text: :desc } }' do
        let(:instructions) do
          { 'computed_float': :asc, assoc: { 'computed_text': :desc } }
        end

        it do
          expect(result.map(&:computed_float)).to eq @all_foos.map(&:computed_float).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_float == right_result.computed_float
              expect(left_result.assoc.computed_text).to be >= right_result.assoc.computed_text
            end
          end
        end
      end

      context '{ assoc: { float: :desc }, text: :asc }' do
        let(:instructions) do
          { assoc: { 'float': :desc }, 'text': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.float }).to eq @all_foos.map { |x| x.assoc&.float }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.float == right_result.assoc.float
              expect(left_result.text).to be <= right_result.text
            end
          end
        end
      end

      context '{ assoc: { computed_float: :asc }, computed_text: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_float': :asc }, 'computed_text': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_float }).to eq @all_foos.map { |x| x.assoc&.computed_float }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_float == right_result.assoc.computed_float
              expect(left_result.computed_text).to be <= right_result.computed_text
            end
          end
        end
      end

      context '{ assoc: { float: :asc }, computed_text: :desc }' do
        let(:instructions) do
          { assoc: { 'float': :asc }, 'computed_text': :desc }
        end

        it do
          expect(result.map { |x| x.assoc&.float }).to eq @all_foos.map { |x| x.assoc&.float }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.float == right_result.assoc.float
              expect(left_result.computed_text).to be >= right_result.computed_text
            end
          end
        end
      end

      context '{ assoc: { computed_float: :desc }, text: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_float': :desc }, 'text': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_float }).to eq @all_foos.map { |x| x.assoc&.computed_float }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_float == right_result.assoc.computed_float
              expect(left_result.text).to be <= right_result.text
            end
          end
        end
      end
    end

    context 'with FLOAT and TIME type' do
      context '{ float: :asc, time: :asc }' do
        let(:instructions) do
          { 'float': :asc, 'time': :asc }
        end

        it do
          expect(result.map(&:float)).to eq @all_foos.map(&:float).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.float == right_result.float
              expect(left_result.time).to be <= right_result.time
            end
          end
        end
      end

      context '{ float: :desc, time: :desc }' do
        let(:instructions) do
          { 'float': :desc, 'time': :desc }
        end

        it do
          expect(result.map(&:float)).to eq @all_foos.map(&:float).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.float == right_result.float
              expect(left_result.time).to be >= right_result.time
            end
          end
        end
      end

      context '{ float: :asc, time: :desc }' do
        let(:instructions) do
          { 'float': :asc, 'time': :desc }
        end

        it do
          expect(result.map(&:float)).to eq @all_foos.map(&:float).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.float == right_result.float
              expect(left_result.time).to be >= right_result.time
            end
          end
        end
      end

      context '{ float: :desc, time: :asc }' do
        let(:instructions) do
          { 'float': :desc, 'time': :asc }
        end

        it do
          expect(result.map(&:float)).to eq @all_foos.map(&:float).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.float == right_result.float
              expect(left_result.time).to be <= right_result.time
            end
          end
        end
      end


      context '{ computed_float: :asc, computed_time: :asc }' do
        let(:instructions) do
          { 'computed_float': :asc, 'computed_time': :asc }
        end

        it do
          expect(result.map(&:computed_float)).to eq @all_foos.map(&:computed_float).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_float == right_result.computed_float
              expect(left_result.computed_time).to be <= right_result.computed_time
            end
          end
        end
      end

      context '{ float: :desc, computed_time: :desc }' do
        let(:instructions) do
          { 'float': :desc, 'computed_time': :desc }
        end

        it do
          expect(result.map(&:float)).to eq @all_foos.map(&:float).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.float == right_result.float
              expect(left_result.computed_time).to be >= right_result.computed_time
            end
          end
        end
      end

      context '{ computed_float: :asc, time: :desc }' do
        let(:instructions) do
          { 'computed_float': :asc, 'time': :desc }
        end

        it do
          expect(result.map(&:computed_float)).to eq @all_foos.map(&:computed_float).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_float == right_result.computed_float
              expect(left_result.time).to be >= right_result.time
            end
          end
        end
      end

      context '{ assoc: { float: :desc, time: :asc } }' do
        let(:instructions) do
          { assoc: { 'float': :desc, 'time': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.float }).to eq @all_foos.map { |x| x.assoc&.float }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.float == right_result.assoc.float
              expect(left_result.assoc.time).to be <= right_result.assoc.time
            end
          end
        end
      end

      context '{ assoc: { computed_float: :asc, computed_time: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_float': :asc, 'computed_time': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_float }).to eq @all_foos.map { |x| x.assoc&.computed_float }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_float == right_result.assoc.computed_float
              expect(left_result.assoc.computed_time).to be <= right_result.assoc.computed_time
            end
          end
        end
      end

      context '{ assoc: { float: :desc, computed_time: :desc } }' do
        let(:instructions) do
          { assoc: { 'float': :desc, 'computed_time': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.float }).to eq @all_foos.map { |x| x.assoc&.float }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.float == right_result.assoc.float
              expect(left_result.assoc.computed_time).to be >= right_result.assoc.computed_time
            end
          end
        end
      end

      context '{ assoc: { computed_float: :asc, time: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_float': :asc, 'time': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_float }).to eq @all_foos.map { |x| x.assoc&.computed_float }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_float == right_result.assoc.computed_float
              expect(left_result.assoc.time).to be >= right_result.assoc.time
            end
          end
        end
      end

      context '{ float: :desc, assoc: { time: :asc } }' do
        let(:instructions) do
          { 'float': :desc, assoc: { 'time': :asc } }
        end

        it do
          expect(result.map(&:float)).to eq @all_foos.map(&:float).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.float == right_result.float
              expect(left_result.assoc.time).to be <= right_result.assoc.time
            end
          end
        end
      end

      context '{ computed_float: :asc, assoc: { time: :asc } }' do
        let(:instructions) do
          { 'computed_float': :asc, assoc: { 'time': :asc } }
        end

        it do
          expect(result.map(&:computed_float)).to eq @all_foos.map(&:computed_float).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_float == right_result.computed_float
              expect(left_result.assoc.time).to be <= right_result.assoc.time
            end
          end
        end
      end

      context '{ float: :desc, assoc: { computed_time: :desc } }' do
        let(:instructions) do
          { 'float': :desc, assoc: { 'computed_time': :desc } }
        end

        it do
          expect(result.map(&:float)).to eq @all_foos.map(&:float).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.float == right_result.float
              expect(left_result.assoc.computed_time).to be >= right_result.assoc.computed_time
            end
          end
        end
      end

      context '{ computed_float: :asc, assoc: { computed_time: :desc } }' do
        let(:instructions) do
          { 'computed_float': :asc, assoc: { 'computed_time': :desc } }
        end

        it do
          expect(result.map(&:computed_float)).to eq @all_foos.map(&:computed_float).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_float == right_result.computed_float
              expect(left_result.assoc.computed_time).to be >= right_result.assoc.computed_time
            end
          end
        end
      end

      context '{ assoc: { float: :desc }, time: :asc }' do
        let(:instructions) do
          { assoc: { 'float': :desc }, 'time': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.float }).to eq @all_foos.map { |x| x.assoc&.float }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.float == right_result.assoc.float
              expect(left_result.time).to be <= right_result.time
            end
          end
        end
      end

      context '{ assoc: { computed_float: :asc }, computed_time: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_float': :asc }, 'computed_time': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_float }).to eq @all_foos.map { |x| x.assoc&.computed_float }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_float == right_result.assoc.computed_float
              expect(left_result.computed_time).to be <= right_result.computed_time
            end
          end
        end
      end

      context '{ assoc: { float: :asc }, computed_time: :desc }' do
        let(:instructions) do
          { assoc: { 'float': :asc }, 'computed_time': :desc }
        end

        it do
          expect(result.map { |x| x.assoc&.float }).to eq @all_foos.map { |x| x.assoc&.float }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.float == right_result.assoc.float
              expect(left_result.computed_time).to be >= right_result.computed_time
            end
          end
        end
      end

      context '{ assoc: { computed_float: :desc }, time: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_float': :desc }, 'time': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_float }).to eq @all_foos.map { |x| x.assoc&.computed_float }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_float == right_result.assoc.computed_float
              expect(left_result.time).to be <= right_result.time
            end
          end
        end
      end
    end


    context 'with INTEGER and STRING type' do
      context '{ integer: :asc, string: :asc }' do
        let(:instructions) do
          { 'integer': :asc, 'string': :asc }
        end

        it do
          expect(result.map(&:integer)).to eq @all_foos.map(&:integer).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.integer == right_result.integer
              expect(left_result.string).to be <= right_result.string
            end
          end
        end
      end

      context '{ integer: :desc, string: :desc }' do
        let(:instructions) do
          { 'integer': :desc, 'string': :desc }
        end

        it do
          expect(result.map(&:integer)).to eq @all_foos.map(&:integer).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.integer == right_result.integer
              expect(left_result.string).to be >= right_result.string
            end
          end
        end
      end

      context '{ integer: :asc, string: :desc }' do
        let(:instructions) do
          { 'integer': :asc, 'string': :desc }
        end

        it do
          expect(result.map(&:integer)).to eq @all_foos.map(&:integer).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.integer == right_result.integer
              expect(left_result.string).to be >= right_result.string
            end
          end
        end
      end

      context '{ integer: :desc, string: :asc }' do
        let(:instructions) do
          { 'integer': :desc, 'string': :asc }
        end

        it do
          expect(result.map(&:integer)).to eq @all_foos.map(&:integer).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.integer == right_result.integer
              expect(left_result.string).to be <= right_result.string
            end
          end
        end
      end


      context '{ computed_integer: :asc, computed_string: :asc }' do
        let(:instructions) do
          { 'computed_integer': :asc, 'computed_string': :asc }
        end

        it do
          expect(result.map(&:computed_integer)).to eq @all_foos.map(&:computed_integer).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_integer == right_result.computed_integer
              expect(left_result.computed_string).to be <= right_result.computed_string
            end
          end
        end
      end

      context '{ integer: :desc, computed_string: :desc }' do
        let(:instructions) do
          { 'integer': :desc, 'computed_string': :desc }
        end

        it do
          expect(result.map(&:integer)).to eq @all_foos.map(&:integer).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.integer == right_result.integer
              expect(left_result.computed_string).to be >= right_result.computed_string
            end
          end
        end
      end

      context '{ computed_integer: :asc, string: :desc }' do
        let(:instructions) do
          { 'computed_integer': :asc, 'string': :desc }
        end

        it do
          expect(result.map(&:computed_integer)).to eq @all_foos.map(&:computed_integer).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_integer == right_result.computed_integer
              expect(left_result.string).to be >= right_result.string
            end
          end
        end
      end

      context '{ assoc: { integer: :desc, string: :asc } }' do
        let(:instructions) do
          { assoc: { 'integer': :desc, 'string': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.integer }).to eq @all_foos.map { |x| x.assoc&.integer }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.integer == right_result.assoc.integer
              expect(left_result.assoc.string).to be <= right_result.assoc.string
            end
          end
        end
      end

      context '{ assoc: { computed_integer: :asc, computed_string: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_integer': :asc, 'computed_string': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_integer }).to eq @all_foos.map { |x| x.assoc&.computed_integer }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_integer == right_result.assoc.computed_integer
              expect(left_result.assoc.computed_string).to be <= right_result.assoc.computed_string
            end
          end
        end
      end

      context '{ assoc: { integer: :desc, computed_string: :desc } }' do
        let(:instructions) do
          { assoc: { 'integer': :desc, 'computed_string': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.integer }).to eq @all_foos.map { |x| x.assoc&.integer }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.integer == right_result.assoc.integer
              expect(left_result.assoc.computed_string).to be >= right_result.assoc.computed_string
            end
          end
        end
      end

      context '{ assoc: { computed_integer: :asc, string: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_integer': :asc, 'string': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_integer }).to eq @all_foos.map { |x| x.assoc&.computed_integer }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_integer == right_result.assoc.computed_integer
              expect(left_result.assoc.string).to be >= right_result.assoc.string
            end
          end
        end
      end

      context '{ integer: :desc, assoc: { string: :asc } }' do
        let(:instructions) do
          { 'integer': :desc, assoc: { 'string': :asc } }
        end

        it do
          expect(result.map(&:integer)).to eq @all_foos.map(&:integer).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.integer == right_result.integer
              expect(left_result.assoc.string).to be <= right_result.assoc.string
            end
          end
        end
      end

      context '{ computed_integer: :asc, assoc: { string: :asc } }' do
        let(:instructions) do
          { 'computed_integer': :asc, assoc: { 'string': :asc } }
        end

        it do
          expect(result.map(&:computed_integer)).to eq @all_foos.map(&:computed_integer).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_integer == right_result.computed_integer
              expect(left_result.assoc.string).to be <= right_result.assoc.string
            end
          end
        end
      end

      context '{ integer: :desc, assoc: { computed_string: :desc } }' do
        let(:instructions) do
          { 'integer': :desc, assoc: { 'computed_string': :desc } }
        end

        it do
          expect(result.map(&:integer)).to eq @all_foos.map(&:integer).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.integer == right_result.integer
              expect(left_result.assoc.computed_string).to be >= right_result.assoc.computed_string
            end
          end
        end
      end

      context '{ computed_integer: :asc, assoc: { computed_string: :desc } }' do
        let(:instructions) do
          { 'computed_integer': :asc, assoc: { 'computed_string': :desc } }
        end

        it do
          expect(result.map(&:computed_integer)).to eq @all_foos.map(&:computed_integer).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_integer == right_result.computed_integer
              expect(left_result.assoc.computed_string).to be >= right_result.assoc.computed_string
            end
          end
        end
      end

      context '{ assoc: { integer: :desc }, string: :asc }' do
        let(:instructions) do
          { assoc: { 'integer': :desc }, 'string': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.integer }).to eq @all_foos.map { |x| x.assoc&.integer }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.integer == right_result.assoc.integer
              expect(left_result.string).to be <= right_result.string
            end
          end
        end
      end

      context '{ assoc: { computed_integer: :asc }, computed_string: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_integer': :asc }, 'computed_string': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_integer }).to eq @all_foos.map { |x| x.assoc&.computed_integer }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_integer == right_result.assoc.computed_integer
              expect(left_result.computed_string).to be <= right_result.computed_string
            end
          end
        end
      end

      context '{ assoc: { integer: :asc }, computed_string: :desc }' do
        let(:instructions) do
          { assoc: { 'integer': :asc }, 'computed_string': :desc }
        end

        it do
          expect(result.map { |x| x.assoc&.integer }).to eq @all_foos.map { |x| x.assoc&.integer }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.integer == right_result.assoc.integer
              expect(left_result.computed_string).to be >= right_result.computed_string
            end
          end
        end
      end

      context '{ assoc: { computed_integer: :desc }, string: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_integer': :desc }, 'string': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_integer }).to eq @all_foos.map { |x| x.assoc&.computed_integer }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_integer == right_result.assoc.computed_integer
              expect(left_result.string).to be <= right_result.string
            end
          end
        end
      end
    end

    context 'with INTEGER and TEXT type' do
      context '{ integer: :asc, text: :asc }' do
        let(:instructions) do
          { 'integer': :asc, 'text': :asc }
        end

        it do
          expect(result.map(&:integer)).to eq @all_foos.map(&:integer).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.integer == right_result.integer
              expect(left_result.text).to be <= right_result.text
            end
          end
        end
      end

      context '{ integer: :desc, text: :desc }' do
        let(:instructions) do
          { 'integer': :desc, 'text': :desc }
        end

        it do
          expect(result.map(&:integer)).to eq @all_foos.map(&:integer).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.integer == right_result.integer
              expect(left_result.text).to be >= right_result.text
            end
          end
        end
      end

      context '{ integer: :asc, text: :desc }' do
        let(:instructions) do
          { 'integer': :asc, 'text': :desc }
        end

        it do
          expect(result.map(&:integer)).to eq @all_foos.map(&:integer).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.integer == right_result.integer
              expect(left_result.text).to be >= right_result.text
            end
          end
        end
      end

      context '{ integer: :desc, text: :asc }' do
        let(:instructions) do
          { 'integer': :desc, 'text': :asc }
        end

        it do
          expect(result.map(&:integer)).to eq @all_foos.map(&:integer).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.integer == right_result.integer
              expect(left_result.text).to be <= right_result.text
            end
          end
        end
      end


      context '{ computed_integer: :asc, computed_text: :asc }' do
        let(:instructions) do
          { 'computed_integer': :asc, 'computed_text': :asc }
        end

        it do
          expect(result.map(&:computed_integer)).to eq @all_foos.map(&:computed_integer).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_integer == right_result.computed_integer
              expect(left_result.computed_text).to be <= right_result.computed_text
            end
          end
        end
      end

      context '{ integer: :desc, computed_text: :desc }' do
        let(:instructions) do
          { 'integer': :desc, 'computed_text': :desc }
        end

        it do
          expect(result.map(&:integer)).to eq @all_foos.map(&:integer).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.integer == right_result.integer
              expect(left_result.computed_text).to be >= right_result.computed_text
            end
          end
        end
      end

      context '{ computed_integer: :asc, text: :desc }' do
        let(:instructions) do
          { 'computed_integer': :asc, 'text': :desc }
        end

        it do
          expect(result.map(&:computed_integer)).to eq @all_foos.map(&:computed_integer).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_integer == right_result.computed_integer
              expect(left_result.text).to be >= right_result.text
            end
          end
        end
      end

      context '{ assoc: { integer: :desc, text: :asc } }' do
        let(:instructions) do
          { assoc: { 'integer': :desc, 'text': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.integer }).to eq @all_foos.map { |x| x.assoc&.integer }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.integer == right_result.assoc.integer
              expect(left_result.assoc.text).to be <= right_result.assoc.text
            end
          end
        end
      end

      context '{ assoc: { computed_integer: :asc, computed_text: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_integer': :asc, 'computed_text': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_integer }).to eq @all_foos.map { |x| x.assoc&.computed_integer }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_integer == right_result.assoc.computed_integer
              expect(left_result.assoc.computed_text).to be <= right_result.assoc.computed_text
            end
          end
        end
      end

      context '{ assoc: { integer: :desc, computed_text: :desc } }' do
        let(:instructions) do
          { assoc: { 'integer': :desc, 'computed_text': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.integer }).to eq @all_foos.map { |x| x.assoc&.integer }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.integer == right_result.assoc.integer
              expect(left_result.assoc.computed_text).to be >= right_result.assoc.computed_text
            end
          end
        end
      end

      context '{ assoc: { computed_integer: :asc, text: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_integer': :asc, 'text': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_integer }).to eq @all_foos.map { |x| x.assoc&.computed_integer }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_integer == right_result.assoc.computed_integer
              expect(left_result.assoc.text).to be >= right_result.assoc.text
            end
          end
        end
      end

      context '{ integer: :desc, assoc: { text: :asc } }' do
        let(:instructions) do
          { 'integer': :desc, assoc: { 'text': :asc } }
        end

        it do
          expect(result.map(&:integer)).to eq @all_foos.map(&:integer).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.integer == right_result.integer
              expect(left_result.assoc.text).to be <= right_result.assoc.text
            end
          end
        end
      end

      context '{ computed_integer: :asc, assoc: { text: :asc } }' do
        let(:instructions) do
          { 'computed_integer': :asc, assoc: { 'text': :asc } }
        end

        it do
          expect(result.map(&:computed_integer)).to eq @all_foos.map(&:computed_integer).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_integer == right_result.computed_integer
              expect(left_result.assoc.text).to be <= right_result.assoc.text
            end
          end
        end
      end

      context '{ integer: :desc, assoc: { computed_text: :desc } }' do
        let(:instructions) do
          { 'integer': :desc, assoc: { 'computed_text': :desc } }
        end

        it do
          expect(result.map(&:integer)).to eq @all_foos.map(&:integer).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.integer == right_result.integer
              expect(left_result.assoc.computed_text).to be >= right_result.assoc.computed_text
            end
          end
        end
      end

      context '{ computed_integer: :asc, assoc: { computed_text: :desc } }' do
        let(:instructions) do
          { 'computed_integer': :asc, assoc: { 'computed_text': :desc } }
        end

        it do
          expect(result.map(&:computed_integer)).to eq @all_foos.map(&:computed_integer).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_integer == right_result.computed_integer
              expect(left_result.assoc.computed_text).to be >= right_result.assoc.computed_text
            end
          end
        end
      end

      context '{ assoc: { integer: :desc }, text: :asc }' do
        let(:instructions) do
          { assoc: { 'integer': :desc }, 'text': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.integer }).to eq @all_foos.map { |x| x.assoc&.integer }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.integer == right_result.assoc.integer
              expect(left_result.text).to be <= right_result.text
            end
          end
        end
      end

      context '{ assoc: { computed_integer: :asc }, computed_text: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_integer': :asc }, 'computed_text': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_integer }).to eq @all_foos.map { |x| x.assoc&.computed_integer }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_integer == right_result.assoc.computed_integer
              expect(left_result.computed_text).to be <= right_result.computed_text
            end
          end
        end
      end

      context '{ assoc: { integer: :asc }, computed_text: :desc }' do
        let(:instructions) do
          { assoc: { 'integer': :asc }, 'computed_text': :desc }
        end

        it do
          expect(result.map { |x| x.assoc&.integer }).to eq @all_foos.map { |x| x.assoc&.integer }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.integer == right_result.assoc.integer
              expect(left_result.computed_text).to be >= right_result.computed_text
            end
          end
        end
      end

      context '{ assoc: { computed_integer: :desc }, text: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_integer': :desc }, 'text': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_integer }).to eq @all_foos.map { |x| x.assoc&.computed_integer }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_integer == right_result.assoc.computed_integer
              expect(left_result.text).to be <= right_result.text
            end
          end
        end
      end
    end

    context 'with INTEGER and TIME type' do
      context '{ integer: :asc, time: :asc }' do
        let(:instructions) do
          { 'integer': :asc, 'time': :asc }
        end

        it do
          expect(result.map(&:integer)).to eq @all_foos.map(&:integer).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.integer == right_result.integer
              expect(left_result.time).to be <= right_result.time
            end
          end
        end
      end

      context '{ integer: :desc, time: :desc }' do
        let(:instructions) do
          { 'integer': :desc, 'time': :desc }
        end

        it do
          expect(result.map(&:integer)).to eq @all_foos.map(&:integer).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.integer == right_result.integer
              expect(left_result.time).to be >= right_result.time
            end
          end
        end
      end

      context '{ integer: :asc, time: :desc }' do
        let(:instructions) do
          { 'integer': :asc, 'time': :desc }
        end

        it do
          expect(result.map(&:integer)).to eq @all_foos.map(&:integer).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.integer == right_result.integer
              expect(left_result.time).to be >= right_result.time
            end
          end
        end
      end

      context '{ integer: :desc, time: :asc }' do
        let(:instructions) do
          { 'integer': :desc, 'time': :asc }
        end

        it do
          expect(result.map(&:integer)).to eq @all_foos.map(&:integer).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.integer == right_result.integer
              expect(left_result.time).to be <= right_result.time
            end
          end
        end
      end


      context '{ computed_integer: :asc, computed_time: :asc }' do
        let(:instructions) do
          { 'computed_integer': :asc, 'computed_time': :asc }
        end

        it do
          expect(result.map(&:computed_integer)).to eq @all_foos.map(&:computed_integer).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_integer == right_result.computed_integer
              expect(left_result.computed_time).to be <= right_result.computed_time
            end
          end
        end
      end

      context '{ integer: :desc, computed_time: :desc }' do
        let(:instructions) do
          { 'integer': :desc, 'computed_time': :desc }
        end

        it do
          expect(result.map(&:integer)).to eq @all_foos.map(&:integer).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.integer == right_result.integer
              expect(left_result.computed_time).to be >= right_result.computed_time
            end
          end
        end
      end

      context '{ computed_integer: :asc, time: :desc }' do
        let(:instructions) do
          { 'computed_integer': :asc, 'time': :desc }
        end

        it do
          expect(result.map(&:computed_integer)).to eq @all_foos.map(&:computed_integer).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_integer == right_result.computed_integer
              expect(left_result.time).to be >= right_result.time
            end
          end
        end
      end

      context '{ assoc: { integer: :desc, time: :asc } }' do
        let(:instructions) do
          { assoc: { 'integer': :desc, 'time': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.integer }).to eq @all_foos.map { |x| x.assoc&.integer }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.integer == right_result.assoc.integer
              expect(left_result.assoc.time).to be <= right_result.assoc.time
            end
          end
        end
      end

      context '{ assoc: { computed_integer: :asc, computed_time: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_integer': :asc, 'computed_time': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_integer }).to eq @all_foos.map { |x| x.assoc&.computed_integer }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_integer == right_result.assoc.computed_integer
              expect(left_result.assoc.computed_time).to be <= right_result.assoc.computed_time
            end
          end
        end
      end

      context '{ assoc: { integer: :desc, computed_time: :desc } }' do
        let(:instructions) do
          { assoc: { 'integer': :desc, 'computed_time': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.integer }).to eq @all_foos.map { |x| x.assoc&.integer }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.integer == right_result.assoc.integer
              expect(left_result.assoc.computed_time).to be >= right_result.assoc.computed_time
            end
          end
        end
      end

      context '{ assoc: { computed_integer: :asc, time: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_integer': :asc, 'time': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_integer }).to eq @all_foos.map { |x| x.assoc&.computed_integer }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_integer == right_result.assoc.computed_integer
              expect(left_result.assoc.time).to be >= right_result.assoc.time
            end
          end
        end
      end

      context '{ integer: :desc, assoc: { time: :asc } }' do
        let(:instructions) do
          { 'integer': :desc, assoc: { 'time': :asc } }
        end

        it do
          expect(result.map(&:integer)).to eq @all_foos.map(&:integer).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.integer == right_result.integer
              expect(left_result.assoc.time).to be <= right_result.assoc.time
            end
          end
        end
      end

      context '{ computed_integer: :asc, assoc: { time: :asc } }' do
        let(:instructions) do
          { 'computed_integer': :asc, assoc: { 'time': :asc } }
        end

        it do
          expect(result.map(&:computed_integer)).to eq @all_foos.map(&:computed_integer).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_integer == right_result.computed_integer
              expect(left_result.assoc.time).to be <= right_result.assoc.time
            end
          end
        end
      end

      context '{ integer: :desc, assoc: { computed_time: :desc } }' do
        let(:instructions) do
          { 'integer': :desc, assoc: { 'computed_time': :desc } }
        end

        it do
          expect(result.map(&:integer)).to eq @all_foos.map(&:integer).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.integer == right_result.integer
              expect(left_result.assoc.computed_time).to be >= right_result.assoc.computed_time
            end
          end
        end
      end

      context '{ computed_integer: :asc, assoc: { computed_time: :desc } }' do
        let(:instructions) do
          { 'computed_integer': :asc, assoc: { 'computed_time': :desc } }
        end

        it do
          expect(result.map(&:computed_integer)).to eq @all_foos.map(&:computed_integer).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_integer == right_result.computed_integer
              expect(left_result.assoc.computed_time).to be >= right_result.assoc.computed_time
            end
          end
        end
      end

      context '{ assoc: { integer: :desc }, time: :asc }' do
        let(:instructions) do
          { assoc: { 'integer': :desc }, 'time': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.integer }).to eq @all_foos.map { |x| x.assoc&.integer }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.integer == right_result.assoc.integer
              expect(left_result.time).to be <= right_result.time
            end
          end
        end
      end

      context '{ assoc: { computed_integer: :asc }, computed_time: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_integer': :asc }, 'computed_time': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_integer }).to eq @all_foos.map { |x| x.assoc&.computed_integer }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_integer == right_result.assoc.computed_integer
              expect(left_result.computed_time).to be <= right_result.computed_time
            end
          end
        end
      end

      context '{ assoc: { integer: :asc }, computed_time: :desc }' do
        let(:instructions) do
          { assoc: { 'integer': :asc }, 'computed_time': :desc }
        end

        it do
          expect(result.map { |x| x.assoc&.integer }).to eq @all_foos.map { |x| x.assoc&.integer }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.integer == right_result.assoc.integer
              expect(left_result.computed_time).to be >= right_result.computed_time
            end
          end
        end
      end

      context '{ assoc: { computed_integer: :desc }, time: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_integer': :desc }, 'time': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_integer }).to eq @all_foos.map { |x| x.assoc&.computed_integer }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_integer == right_result.assoc.computed_integer
              expect(left_result.time).to be <= right_result.time
            end
          end
        end
      end
    end


    context 'with STRING and TEXT type' do
      context '{ string: :asc, text: :asc }' do
        let(:instructions) do
          { 'string': :asc, 'text': :asc }
        end

        it do
          expect(result.map(&:string)).to eq @all_foos.map(&:string).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.string == right_result.string
              expect(left_result.text).to be <= right_result.text
            end
          end
        end
      end

      context '{ string: :desc, text: :desc }' do
        let(:instructions) do
          { 'string': :desc, 'text': :desc }
        end

        it do
          expect(result.map(&:string)).to eq @all_foos.map(&:string).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.string == right_result.string
              expect(left_result.text).to be >= right_result.text
            end
          end
        end
      end

      context '{ string: :asc, text: :desc }' do
        let(:instructions) do
          { 'string': :asc, 'text': :desc }
        end

        it do
          expect(result.map(&:string)).to eq @all_foos.map(&:string).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.string == right_result.string
              expect(left_result.text).to be >= right_result.text
            end
          end
        end
      end

      context '{ string: :desc, text: :asc }' do
        let(:instructions) do
          { 'string': :desc, 'text': :asc }
        end

        it do
          expect(result.map(&:string)).to eq @all_foos.map(&:string).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.string == right_result.string
              expect(left_result.text).to be <= right_result.text
            end
          end
        end
      end


      context '{ computed_string: :asc, computed_text: :asc }' do
        let(:instructions) do
          { 'computed_string': :asc, 'computed_text': :asc }
        end

        it do
          expect(result.map(&:computed_string)).to eq @all_foos.map(&:computed_string).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_string == right_result.computed_string
              expect(left_result.computed_text).to be <= right_result.computed_text
            end
          end
        end
      end

      context '{ string: :desc, computed_text: :desc }' do
        let(:instructions) do
          { 'string': :desc, 'computed_text': :desc }
        end

        it do
          expect(result.map(&:string)).to eq @all_foos.map(&:string).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.string == right_result.string
              expect(left_result.computed_text).to be >= right_result.computed_text
            end
          end
        end
      end

      context '{ computed_string: :asc, text: :desc }' do
        let(:instructions) do
          { 'computed_string': :asc, 'text': :desc }
        end

        it do
          expect(result.map(&:computed_string)).to eq @all_foos.map(&:computed_string).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_string == right_result.computed_string
              expect(left_result.text).to be >= right_result.text
            end
          end
        end
      end

      context '{ assoc: { string: :desc, text: :asc } }' do
        let(:instructions) do
          { assoc: { 'string': :desc, 'text': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.string }).to eq @all_foos.map { |x| x.assoc&.string }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.string == right_result.assoc.string
              expect(left_result.assoc.text).to be <= right_result.assoc.text
            end
          end
        end
      end

      context '{ assoc: { computed_string: :asc, computed_text: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_string': :asc, 'computed_text': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_string }).to eq @all_foos.map { |x| x.assoc&.computed_string }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_string == right_result.assoc.computed_string
              expect(left_result.assoc.computed_text).to be <= right_result.assoc.computed_text
            end
          end
        end
      end

      context '{ assoc: { string: :desc, computed_text: :desc } }' do
        let(:instructions) do
          { assoc: { 'string': :desc, 'computed_text': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.string }).to eq @all_foos.map { |x| x.assoc&.string }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.string == right_result.assoc.string
              expect(left_result.assoc.computed_text).to be >= right_result.assoc.computed_text
            end
          end
        end
      end

      context '{ assoc: { computed_string: :asc, text: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_string': :asc, 'text': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_string }).to eq @all_foos.map { |x| x.assoc&.computed_string }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_string == right_result.assoc.computed_string
              expect(left_result.assoc.text).to be >= right_result.assoc.text
            end
          end
        end
      end

      context '{ string: :desc, assoc: { text: :asc } }' do
        let(:instructions) do
          { 'string': :desc, assoc: { 'text': :asc } }
        end

        it do
          expect(result.map(&:string)).to eq @all_foos.map(&:string).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.string == right_result.string
              expect(left_result.assoc.text).to be <= right_result.assoc.text
            end
          end
        end
      end

      context '{ computed_string: :asc, assoc: { text: :asc } }' do
        let(:instructions) do
          { 'computed_string': :asc, assoc: { 'text': :asc } }
        end

        it do
          expect(result.map(&:computed_string)).to eq @all_foos.map(&:computed_string).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_string == right_result.computed_string
              expect(left_result.assoc.text).to be <= right_result.assoc.text
            end
          end
        end
      end

      context '{ string: :desc, assoc: { computed_text: :desc } }' do
        let(:instructions) do
          { 'string': :desc, assoc: { 'computed_text': :desc } }
        end

        it do
          expect(result.map(&:string)).to eq @all_foos.map(&:string).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.string == right_result.string
              expect(left_result.assoc.computed_text).to be >= right_result.assoc.computed_text
            end
          end
        end
      end

      context '{ computed_string: :asc, assoc: { computed_text: :desc } }' do
        let(:instructions) do
          { 'computed_string': :asc, assoc: { 'computed_text': :desc } }
        end

        it do
          expect(result.map(&:computed_string)).to eq @all_foos.map(&:computed_string).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_string == right_result.computed_string
              expect(left_result.assoc.computed_text).to be >= right_result.assoc.computed_text
            end
          end
        end
      end

      context '{ assoc: { string: :desc }, text: :asc }' do
        let(:instructions) do
          { assoc: { 'string': :desc }, 'text': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.string }).to eq @all_foos.map { |x| x.assoc&.string }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.string == right_result.assoc.string
              expect(left_result.text).to be <= right_result.text
            end
          end
        end
      end

      context '{ assoc: { computed_string: :asc }, computed_text: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_string': :asc }, 'computed_text': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_string }).to eq @all_foos.map { |x| x.assoc&.computed_string }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_string == right_result.assoc.computed_string
              expect(left_result.computed_text).to be <= right_result.computed_text
            end
          end
        end
      end

      context '{ assoc: { string: :asc }, computed_text: :desc }' do
        let(:instructions) do
          { assoc: { 'string': :asc }, 'computed_text': :desc }
        end

        it do
          expect(result.map { |x| x.assoc&.string }).to eq @all_foos.map { |x| x.assoc&.string }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.string == right_result.assoc.string
              expect(left_result.computed_text).to be >= right_result.computed_text
            end
          end
        end
      end

      context '{ assoc: { computed_string: :desc }, text: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_string': :desc }, 'text': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_string }).to eq @all_foos.map { |x| x.assoc&.computed_string }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_string == right_result.assoc.computed_string
              expect(left_result.text).to be <= right_result.text
            end
          end
        end
      end
    end

    context 'with STRING and TIME type' do
      context '{ string: :asc, time: :asc }' do
        let(:instructions) do
          { 'string': :asc, 'time': :asc }
        end

        it do
          expect(result.map(&:string)).to eq @all_foos.map(&:string).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.string == right_result.string
              expect(left_result.time).to be <= right_result.time
            end
          end
        end
      end

      context '{ string: :desc, time: :desc }' do
        let(:instructions) do
          { 'string': :desc, 'time': :desc }
        end

        it do
          expect(result.map(&:string)).to eq @all_foos.map(&:string).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.string == right_result.string
              expect(left_result.time).to be >= right_result.time
            end
          end
        end
      end

      context '{ string: :asc, time: :desc }' do
        let(:instructions) do
          { 'string': :asc, 'time': :desc }
        end

        it do
          expect(result.map(&:string)).to eq @all_foos.map(&:string).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.string == right_result.string
              expect(left_result.time).to be >= right_result.time
            end
          end
        end
      end

      context '{ string: :desc, time: :asc }' do
        let(:instructions) do
          { 'string': :desc, 'time': :asc }
        end

        it do
          expect(result.map(&:string)).to eq @all_foos.map(&:string).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.string == right_result.string
              expect(left_result.time).to be <= right_result.time
            end
          end
        end
      end


      context '{ computed_string: :asc, computed_time: :asc }' do
        let(:instructions) do
          { 'computed_string': :asc, 'computed_time': :asc }
        end

        it do
          expect(result.map(&:computed_string)).to eq @all_foos.map(&:computed_string).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_string == right_result.computed_string
              expect(left_result.computed_time).to be <= right_result.computed_time
            end
          end
        end
      end

      context '{ string: :desc, computed_time: :desc }' do
        let(:instructions) do
          { 'string': :desc, 'computed_time': :desc }
        end

        it do
          expect(result.map(&:string)).to eq @all_foos.map(&:string).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.string == right_result.string
              expect(left_result.computed_time).to be >= right_result.computed_time
            end
          end
        end
      end

      context '{ computed_string: :asc, time: :desc }' do
        let(:instructions) do
          { 'computed_string': :asc, 'time': :desc }
        end

        it do
          expect(result.map(&:computed_string)).to eq @all_foos.map(&:computed_string).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_string == right_result.computed_string
              expect(left_result.time).to be >= right_result.time
            end
          end
        end
      end

      context '{ assoc: { string: :desc, time: :asc } }' do
        let(:instructions) do
          { assoc: { 'string': :desc, 'time': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.string }).to eq @all_foos.map { |x| x.assoc&.string }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.string == right_result.assoc.string
              expect(left_result.assoc.time).to be <= right_result.assoc.time
            end
          end
        end
      end

      context '{ assoc: { computed_string: :asc, computed_time: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_string': :asc, 'computed_time': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_string }).to eq @all_foos.map { |x| x.assoc&.computed_string }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_string == right_result.assoc.computed_string
              expect(left_result.assoc.computed_time).to be <= right_result.assoc.computed_time
            end
          end
        end
      end

      context '{ assoc: { string: :desc, computed_time: :desc } }' do
        let(:instructions) do
          { assoc: { 'string': :desc, 'computed_time': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.string }).to eq @all_foos.map { |x| x.assoc&.string }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.string == right_result.assoc.string
              expect(left_result.assoc.computed_time).to be >= right_result.assoc.computed_time
            end
          end
        end
      end

      context '{ assoc: { computed_string: :asc, time: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_string': :asc, 'time': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_string }).to eq @all_foos.map { |x| x.assoc&.computed_string }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_string == right_result.assoc.computed_string
              expect(left_result.assoc.time).to be >= right_result.assoc.time
            end
          end
        end
      end

      context '{ string: :desc, assoc: { time: :asc } }' do
        let(:instructions) do
          { 'string': :desc, assoc: { 'time': :asc } }
        end

        it do
          expect(result.map(&:string)).to eq @all_foos.map(&:string).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.string == right_result.string
              expect(left_result.assoc.time).to be <= right_result.assoc.time
            end
          end
        end
      end

      context '{ computed_string: :asc, assoc: { time: :asc } }' do
        let(:instructions) do
          { 'computed_string': :asc, assoc: { 'time': :asc } }
        end

        it do
          expect(result.map(&:computed_string)).to eq @all_foos.map(&:computed_string).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_string == right_result.computed_string
              expect(left_result.assoc.time).to be <= right_result.assoc.time
            end
          end
        end
      end

      context '{ string: :desc, assoc: { computed_time: :desc } }' do
        let(:instructions) do
          { 'string': :desc, assoc: { 'computed_time': :desc } }
        end

        it do
          expect(result.map(&:string)).to eq @all_foos.map(&:string).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.string == right_result.string
              expect(left_result.assoc.computed_time).to be >= right_result.assoc.computed_time
            end
          end
        end
      end

      context '{ computed_string: :asc, assoc: { computed_time: :desc } }' do
        let(:instructions) do
          { 'computed_string': :asc, assoc: { 'computed_time': :desc } }
        end

        it do
          expect(result.map(&:computed_string)).to eq @all_foos.map(&:computed_string).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_string == right_result.computed_string
              expect(left_result.assoc.computed_time).to be >= right_result.assoc.computed_time
            end
          end
        end
      end

      context '{ assoc: { string: :desc }, time: :asc }' do
        let(:instructions) do
          { assoc: { 'string': :desc }, 'time': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.string }).to eq @all_foos.map { |x| x.assoc&.string }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.string == right_result.assoc.string
              expect(left_result.time).to be <= right_result.time
            end
          end
        end
      end

      context '{ assoc: { computed_string: :asc }, computed_time: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_string': :asc }, 'computed_time': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_string }).to eq @all_foos.map { |x| x.assoc&.computed_string }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_string == right_result.assoc.computed_string
              expect(left_result.computed_time).to be <= right_result.computed_time
            end
          end
        end
      end

      context '{ assoc: { string: :asc }, computed_time: :desc }' do
        let(:instructions) do
          { assoc: { 'string': :asc }, 'computed_time': :desc }
        end

        it do
          expect(result.map { |x| x.assoc&.string }).to eq @all_foos.map { |x| x.assoc&.string }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.string == right_result.assoc.string
              expect(left_result.computed_time).to be >= right_result.computed_time
            end
          end
        end
      end

      context '{ assoc: { computed_string: :desc }, time: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_string': :desc }, 'time': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_string }).to eq @all_foos.map { |x| x.assoc&.computed_string }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_string == right_result.assoc.computed_string
              expect(left_result.time).to be <= right_result.time
            end
          end
        end
      end
    end


    context 'with TEXT and TIME type' do
      context '{ text: :asc, time: :asc }' do
        let(:instructions) do
          { 'text': :asc, 'time': :asc }
        end

        it do
          expect(result.map(&:text)).to eq @all_foos.map(&:text).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.text == right_result.text
              expect(left_result.time).to be <= right_result.time
            end
          end
        end
      end

      context '{ text: :desc, time: :desc }' do
        let(:instructions) do
          { 'text': :desc, 'time': :desc }
        end

        it do
          expect(result.map(&:text)).to eq @all_foos.map(&:text).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.text == right_result.text
              expect(left_result.time).to be >= right_result.time
            end
          end
        end
      end

      context '{ text: :asc, time: :desc }' do
        let(:instructions) do
          { 'text': :asc, 'time': :desc }
        end

        it do
          expect(result.map(&:text)).to eq @all_foos.map(&:text).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.text == right_result.text
              expect(left_result.time).to be >= right_result.time
            end
          end
        end
      end

      context '{ text: :desc, time: :asc }' do
        let(:instructions) do
          { 'text': :desc, 'time': :asc }
        end

        it do
          expect(result.map(&:text)).to eq @all_foos.map(&:text).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.text == right_result.text
              expect(left_result.time).to be <= right_result.time
            end
          end
        end
      end


      context '{ computed_text: :asc, computed_time: :asc }' do
        let(:instructions) do
          { 'computed_text': :asc, 'computed_time': :asc }
        end

        it do
          expect(result.map(&:computed_text)).to eq @all_foos.map(&:computed_text).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_text == right_result.computed_text
              expect(left_result.computed_time).to be <= right_result.computed_time
            end
          end
        end
      end

      context '{ text: :desc, computed_time: :desc }' do
        let(:instructions) do
          { 'text': :desc, 'computed_time': :desc }
        end

        it do
          expect(result.map(&:text)).to eq @all_foos.map(&:text).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.text == right_result.text
              expect(left_result.computed_time).to be >= right_result.computed_time
            end
          end
        end
      end

      context '{ computed_text: :asc, time: :desc }' do
        let(:instructions) do
          { 'computed_text': :asc, 'time': :desc }
        end

        it do
          expect(result.map(&:computed_text)).to eq @all_foos.map(&:computed_text).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_text == right_result.computed_text
              expect(left_result.time).to be >= right_result.time
            end
          end
        end
      end

      context '{ assoc: { text: :desc, time: :asc } }' do
        let(:instructions) do
          { assoc: { 'text': :desc, 'time': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.text }).to eq @all_foos.map { |x| x.assoc&.text }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.text == right_result.assoc.text
              expect(left_result.assoc.time).to be <= right_result.assoc.time
            end
          end
        end
      end

      context '{ assoc: { computed_text: :asc, computed_time: :asc } }' do
        let(:instructions) do
          { assoc: { 'computed_text': :asc, 'computed_time': :asc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_text }).to eq @all_foos.map { |x| x.assoc&.computed_text }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_text == right_result.assoc.computed_text
              expect(left_result.assoc.computed_time).to be <= right_result.assoc.computed_time
            end
          end
        end
      end

      context '{ assoc: { text: :desc, computed_time: :desc } }' do
        let(:instructions) do
          { assoc: { 'text': :desc, 'computed_time': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.text }).to eq @all_foos.map { |x| x.assoc&.text }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.text == right_result.assoc.text
              expect(left_result.assoc.computed_time).to be >= right_result.assoc.computed_time
            end
          end
        end
      end

      context '{ assoc: { computed_text: :asc, time: :desc } }' do
        let(:instructions) do
          { assoc: { 'computed_text': :asc, 'time': :desc } }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_text }).to eq @all_foos.map { |x| x.assoc&.computed_text }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_text == right_result.assoc.computed_text
              expect(left_result.assoc.time).to be >= right_result.assoc.time
            end
          end
        end
      end

      context '{ text: :desc, assoc: { time: :asc } }' do
        let(:instructions) do
          { 'text': :desc, assoc: { 'time': :asc } }
        end

        it do
          expect(result.map(&:text)).to eq @all_foos.map(&:text).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.text == right_result.text
              expect(left_result.assoc.time).to be <= right_result.assoc.time
            end
          end
        end
      end

      context '{ computed_text: :asc, assoc: { time: :asc } }' do
        let(:instructions) do
          { 'computed_text': :asc, assoc: { 'time': :asc } }
        end

        it do
          expect(result.map(&:computed_text)).to eq @all_foos.map(&:computed_text).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_text == right_result.computed_text
              expect(left_result.assoc.time).to be <= right_result.assoc.time
            end
          end
        end
      end

      context '{ text: :desc, assoc: { computed_time: :desc } }' do
        let(:instructions) do
          { 'text': :desc, assoc: { 'computed_time': :desc } }
        end

        it do
          expect(result.map(&:text)).to eq @all_foos.map(&:text).sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.text == right_result.text
              expect(left_result.assoc.computed_time).to be >= right_result.assoc.computed_time
            end
          end
        end
      end

      context '{ computed_text: :asc, assoc: { computed_time: :desc } }' do
        let(:instructions) do
          { 'computed_text': :asc, assoc: { 'computed_time': :desc } }
        end

        it do
          expect(result.map(&:computed_text)).to eq @all_foos.map(&:computed_text).sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.computed_text == right_result.computed_text
              expect(left_result.assoc.computed_time).to be >= right_result.assoc.computed_time
            end
          end
        end
      end

      context '{ assoc: { text: :desc }, time: :asc }' do
        let(:instructions) do
          { assoc: { 'text': :desc }, 'time': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.text }).to eq @all_foos.map { |x| x.assoc&.text }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.text == right_result.assoc.text
              expect(left_result.time).to be <= right_result.time
            end
          end
        end
      end

      context '{ assoc: { computed_text: :asc }, computed_time: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_text': :asc }, 'computed_time': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_text }).to eq @all_foos.map { |x| x.assoc&.computed_text }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_text == right_result.assoc.computed_text
              expect(left_result.computed_time).to be <= right_result.computed_time
            end
          end
        end
      end

      context '{ assoc: { text: :asc }, computed_time: :desc }' do
        let(:instructions) do
          { assoc: { 'text': :asc }, 'computed_time': :desc }
        end

        it do
          expect(result.map { |x| x.assoc&.text }).to eq @all_foos.map { |x| x.assoc&.text }.sort!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.text == right_result.assoc.text
              expect(left_result.computed_time).to be >= right_result.computed_time
            end
          end
        end
      end

      context '{ assoc: { computed_text: :desc }, time: :asc }' do
        let(:instructions) do
          { assoc: { 'computed_text': :desc }, 'time': :asc }
        end

        it do
          expect(result.map { |x| x.assoc&.computed_text }).to eq @all_foos.map { |x| x.assoc&.computed_text }.sort!.reverse!

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.computed_text == right_result.assoc.computed_text
              expect(left_result.time).to be <= right_result.time
            end
          end
        end
      end
    end
  end
end

Foo.destroy_all
