# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveSet do
  before(:all) do
    @thing_1 = FactoryBot.create(:thing, string: 'a', integer: 1, boolean: true,
                                 date: 1.day.from_now.to_date, datetime: 1.day.from_now.to_datetime,
                                 decimal: 1.1, float: 1.1, time: 1.hour.from_now.to_time.to_s[12..-1],
                                         one: FactoryBot.create(:one, string: 'ra', integer: 9))
    @thing_2 = FactoryBot.create(:thing, string: 'a', integer: 2, boolean: true,
                                 date: 1.day.ago.to_date, datetime: 1.day.ago.to_datetime,
                                 decimal: 2.2, float: 2.2, time: 2.hours.from_now.to_time.to_s[12..-1],
                                         one: FactoryBot.create(:one, string: 'ra', integer: 8))
    @thing_3 = FactoryBot.create(:thing, string: 'z', integer: 1, boolean: true,
                                 date: 1.day.from_now.to_date, datetime: 1.day.from_now.to_datetime,
                                 decimal: 1.1, float: 1.1, time: 1.hour.ago.to_time.to_s[12..-1],
                                 one: FactoryBot.create(:one, string: 'rz', integer: 9))
    @thing_4 = FactoryBot.create(:thing, string: 'z', integer: 2, boolean: true,
                                 date: 1.day.ago.to_date, datetime: 1.day.ago.to_datetime,
                                 decimal: 2.2, float: 2.2, time: 2.hours.ago.to_time.to_s[12..-1],
                                 one: FactoryBot.create(:one, string: 'rz', integer: 8))
    @thing_5 = FactoryBot.create(:thing, string: 'A', integer: 1, boolean: false,
                                 date: 1.week.from_now.to_date, datetime: 1.week.from_now.to_datetime,
                                 decimal: 1.1, float: 1.1, time: 1.hour.from_now.to_time.to_s[12..-1],
                                         one: FactoryBot.create(:one, string: 'rA', integer: 9))
    @thing_6 = FactoryBot.create(:thing, string: 'A', integer: 2, boolean: false,
                                 date: 1.week.ago.to_date, datetime: 1.week.ago.to_datetime,
                                 decimal: 2.2, float: 2.2, time: 2.hours.from_now.to_time.to_s[12..-1],
                                         one: FactoryBot.create(:one, string: 'rA', integer: 8))
    @thing_7 = FactoryBot.create(:thing, string: 'Z', integer: 1, boolean: false,
                                 date: 1.week.from_now.to_date, datetime: 1.week.from_now.to_datetime,
                                 decimal: 1.1, float: 1.1, time: 1.hour.ago.to_time.to_s[12..-1],
                                         one: FactoryBot.create(:one, string: 'rZ', integer: 9))
    @thing_8 = FactoryBot.create(:thing, string: 'Z', integer: 2, boolean: false,
                                 date: 1.week.ago.to_date, datetime: 1.week.ago.to_datetime,
                                 decimal: 2.2, float: 2.2, time: 2.hours.ago.to_time.to_s[12..-1],
                                 one: FactoryBot.create(:one, string: 'rZ', integer: 8))
    @thing_9 = FactoryBot.create(:thing, :all_nil, one: FactoryBot.create(:one, :all_nil))
    @active_set = ActiveSet.new(Thing.all)
  end

  SORTABLE_TYPES = ApplicationRecord::FIELD_TYPES + ['string(i)']

  describe '#sort' do
    SORTABLE_TYPES.each do |type|
      all_possible_sort_instructions_for(type).each do |instruction|
        context instruction do
          it_should_behave_like 'a sorted collection', instruction do
            let(:result) { @active_set.sort(instruction) }
          end
        end
      end
    end

    SORTABLE_TYPES.combination(2).each do |type_1, type_2|
      all_possible_sort_instruction_combinations_for(type_1, type_2).each do |instructions|
        context instructions do
          it_should_behave_like 'a sorted collection', instructions do
            let(:result) { @active_set.sort(instructions) }
          end
        end
      end
    end

    # describe '#sort on a computed field with nil values in the set' do
    #   before(:each) do
    #     @a = OpenStruct.new(bar: 7)
    #     @b = OpenStruct.new(bar: nil)
    #     @c = OpenStruct.new(bar: 8)

    #     @active_set = ActiveSet.new([@a, @b, @c])
    #   end

    #   let(:result) { @active_set.sort(instructions) }

    #   context 'sorting ascending' do
    #     let(:instructions) do
    #       { 'bar': :asc }
    #     end

    #     it do
    #       expect(result.first).to eq @a
    #       expect(result.second).to eq @c
    #       expect(result.last).to eq @b
    #     end
    #   end

    #   context 'sorting desending' do
    #     let(:instructions) do
    #       { 'bar': :desc }
    #     end

    #     it do
    #       expect(result.first).to eq @b
    #       expect(result.second).to eq @c
    #       expect(result.last).to eq @a
    #     end
    #   end
    # end
  end
end
