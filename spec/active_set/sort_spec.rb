# frozen_string_literal: true

require 'spec_helper'

begin
  FactoryGirl.find_definitions
rescue FactoryGirl::DuplicateDefinitionError
end

FactoryGirl.create(:foo, string: 'a', integer: 1, boolean: true,
                   date: 1.day.from_now.to_date, datetime: 1.day.from_now.to_datetime,
                   decimal: 1.1, float: 1.1, time: 1.hour.from_now.to_time.to_s[12..-1],
                   assoc: FactoryGirl.create(:assoc, string: 'ra', integer: 9))
FactoryGirl.create(:foo, string: 'a', integer: 2, boolean: true,
                   date: 1.day.ago.to_date, datetime: 1.day.ago.to_datetime,
                   decimal: 2.2, float: 2.2, time: 2.hours.from_now.to_time.to_s[12..-1],
                   assoc: FactoryGirl.create(:assoc, string: 'ra', integer: 8))
FactoryGirl.create(:foo, string: 'z', integer: 1, boolean: true,
                   date: 1.day.from_now.to_date, datetime: 1.day.from_now.to_datetime,
                   decimal: 1.1, float: 1.1, time: 1.hour.ago.to_time.to_s[12..-1],
                   assoc: FactoryGirl.create(:assoc, string: 'rz', integer: 9))
FactoryGirl.create(:foo, string: 'z', integer: 2, boolean: true,
                   date: 1.day.ago.to_date, datetime: 1.day.ago.to_datetime,
                   decimal: 2.2, float: 2.2, time: 2.hours.ago.to_time.to_s[12..-1],
                   assoc: FactoryGirl.create(:assoc, string: 'rz', integer: 8))
FactoryGirl.create(:foo, string: 'A', integer: 1, boolean: false,
                   date: 1.week.from_now.to_date, datetime: 1.week.from_now.to_datetime,
                   decimal: 1.1, float: 1.1, time: 1.hour.from_now.to_time.to_s[12..-1],
                   assoc: FactoryGirl.create(:assoc, string: 'rA', integer: 9))
FactoryGirl.create(:foo, string: 'A', integer: 2, boolean: false,
                   date: 1.week.ago.to_date, datetime: 1.week.ago.to_datetime,
                   decimal: 2.2, float: 2.2, time: 2.hours.from_now.to_time.to_s[12..-1],
                   assoc: FactoryGirl.create(:assoc, string: 'rA', integer: 8))
FactoryGirl.create(:foo, string: 'Z', integer: 1, boolean: false,
                   date: 1.week.from_now.to_date, datetime: 1.week.from_now.to_datetime,
                   decimal: 1.1, float: 1.1, time: 1.hour.ago.to_time.to_s[12..-1],
                   assoc: FactoryGirl.create(:assoc, string: 'rZ', integer: 9))
FactoryGirl.create(:foo, string: 'Z', integer: 2, boolean: false,
                   date: 1.week.ago.to_date, datetime: 1.week.ago.to_datetime,
                   decimal: 2.2, float: 2.2, time: 2.hours.ago.to_time.to_s[12..-1],
                   assoc: FactoryGirl.create(:assoc, string: 'rZ', integer: 8))

SORTING_ACTIVE_SET = ActiveSet.new(Foo.all)

RSpec.describe ActiveSet do
  describe '#sort' do
    attribute_types = %i[binary boolean date datetime decimal float integer string text time]
    valid_directions = [:asc, 'asc', :desc, 'desc', :ascending, 'ascending', :descending, 'descending',
                        :ASC, 'ASC', :DESC, 'DESC', :ASCENDING, 'ASCENDING', :DESCENDING, 'DESCENDING']

    attribute_types.each do |type|
      { type => :asc }.tap do |instructions|
        it "#{instructions.inspect}" do
          result = SORTING_ACTIVE_SET.sort(instructions)
          if type == :boolean
            expect(result.map(& type)).to eq result.map(& type).sort_by { |bool| bool ? 1 : 0 }
          else
            expect(result.map(& type)).to eq result.map(& type).sort!
          end
        end
      end

      { "computed_#{type}" => :asc }.tap do |instructions|
        it "#{instructions.inspect}" do
          result = SORTING_ACTIVE_SET.sort(instructions)
          if type == :boolean
            expect(result.map(&:"computed_#{type}")).to eq result.map(&:"computed_#{type}").sort_by { |bool| bool ? 1 : 0 }
          else
            expect(result.map(&:"computed_#{type}")).to eq result.map(&:"computed_#{type}").sort!
          end
        end
      end

      { type => :desc }.tap do |instructions|
        it "#{instructions.inspect}" do
          result = SORTING_ACTIVE_SET.sort(instructions)
          if type == :boolean
            expect(result.map(& type)).to eq result.map(& type).sort_by { |bool| bool ? 1 : 0 }.reverse!
          else
            expect(result.map(& type)).to eq result.map(& type).sort!.reverse!
          end
        end
      end

      { "computed_#{type}" => :desc }.tap do |instructions|
        it "#{instructions.inspect}" do
          result = SORTING_ACTIVE_SET.sort(instructions)
          if type == :boolean
            expect(result.map(&:"computed_#{type}")).to eq result.map(&:"computed_#{type}").sort_by { |bool| bool ? 1 : 0 }.reverse!
          else
            expect(result.map(&:"computed_#{type}")).to eq result.map(&:"computed_#{type}").sort!.reverse!
          end
        end
      end

      { assoc: { type => 'ascending' } }.tap do |instructions|
        it "#{instructions.inspect}" do
          result = SORTING_ACTIVE_SET.sort(instructions)
          if type == :boolean
            expect(result.map(&:assoc).map(& type)).to eq result.map(&:assoc).map(& type).sort_by { |bool| bool ? 1 : 0 }
          else
            expect(result.map(&:assoc).map(& type)).to eq result.map(&:assoc).map(& type).sort!
          end
        end
      end

      { assoc: { "computed_#{type}" => 'ascending' } }.tap do |instructions|
        it "#{instructions.inspect}" do
          result = SORTING_ACTIVE_SET.sort(instructions)
          if type == :boolean
            expect(result.map(&:assoc).map(&:"computed_#{type}")).to eq result.map(&:assoc).map(&:"computed_#{type}").sort_by { |bool| bool ? 1 : 0 }
          else
            expect(result.map(&:assoc).map(&:"computed_#{type}")).to eq result.map(&:assoc).map(&:"computed_#{type}").sort!
          end
        end
      end

      { assoc: { type => 'descending' } }.tap do |instructions|
        it "#{instructions.inspect}" do
          result = SORTING_ACTIVE_SET.sort(instructions)
          if type == :boolean
            expect(result.map(&:assoc).map(& type)).to eq result.map(&:assoc).map(& type).sort_by { |bool| bool ? 1 : 0 }.reverse!
          else
            expect(result.map(&:assoc).map(& type)).to eq result.map(&:assoc).map(& type).sort!.reverse!
          end
        end
      end

      { assoc: { "computed_#{type}" => 'descending' } }.tap do |instructions|
        it "#{instructions.inspect}" do
          result = SORTING_ACTIVE_SET.sort(instructions)
          if type == :boolean
            expect(result.map(&:assoc).map(&:"computed_#{type}")).to eq result.map(&:assoc).map(&:"computed_#{type}").sort_by { |bool| bool ? 1 : 0 }.reverse!
          else
            expect(result.map(&:assoc).map(&:"computed_#{type}")).to eq result.map(&:assoc).map(&:"computed_#{type}").sort!.reverse!
          end
        end
      end
    end

    attribute_types.combination(2).each do |left_type, right_type|
      { left_type => 'asc', right_type => 'asc' }.tap do |instructions|
        it "#{instructions.inspect}" do
          result = SORTING_ACTIVE_SET.sort(instructions)

          if left_type == :boolean
            expect(result.map(& left_type)).to eq result.map(& left_type).sort_by { |bool| bool ? 1 : 0 }
          else
            expect(result.map(& left_type)).to eq result.map(& left_type).sort!
          end

          result.each_cons(2) do |left_result, right_result|
            if left_result.send(left_type) == right_result.send(left_type)
              expect(left_result.send(right_type)).to be <= right_result.send(right_type)
            end
          end
        end
      end

      { left_type => 'desc', right_type => 'desc' }.tap do |instructions|
        it "#{instructions.inspect}" do
          result = SORTING_ACTIVE_SET.sort(instructions)

          if left_type == :boolean
            expect(result.map(& left_type)).to eq result.map(& left_type).sort_by { |bool| bool ? 1 : 0 }.reverse!
          else
            expect(result.map(& left_type)).to eq result.map(& left_type).sort!.reverse!
          end

          result.each_cons(2) do |left_result, right_result|
            if left_result.send(left_type) == right_result.send(left_type)
              expect(left_result.send(right_type)).to be >= right_result.send(right_type)
            end
          end
        end
      end

      { left_type => 'asc', right_type => 'desc' }.tap do |instructions|
        it "#{instructions.inspect}" do
          result = SORTING_ACTIVE_SET.sort(instructions)

          if left_type == :boolean
            expect(result.map(& left_type)).to eq result.map(& left_type).sort_by { |bool| bool ? 1 : 0 }
          else
            expect(result.map(& left_type)).to eq result.map(& left_type).sort!
          end

          result.each_cons(2) do |left_result, right_result|
            if left_result.send(left_type) == right_result.send(left_type)
              expect(left_result.send(right_type)).to be >= right_result.send(right_type)
            end
          end
        end
      end

      { left_type => 'desc', right_type => 'asc' }.tap do |instructions|
        it "#{instructions.inspect}" do
          result = SORTING_ACTIVE_SET.sort(instructions)

          if left_type == :boolean
            expect(result.map(& left_type)).to eq result.map(& left_type).sort_by { |bool| bool ? 1 : 0 }.reverse!
          else
            expect(result.map(& left_type)).to eq result.map(& left_type).sort!.reverse!
          end

          result.each_cons(2) do |left_result, right_result|
            if left_result.send(left_type) == right_result.send(left_type)
              expect(left_result.send(right_type)).to be <= right_result.send(right_type)
            end
          end
        end
      end


      { "computed_#{left_type}" => 'asc', "computed_#{right_type}" => 'asc' }.tap do |instructions|
        it "#{instructions.inspect}" do
          result = SORTING_ACTIVE_SET.sort(instructions)

          if left_type == :boolean
            expect(result.map(&:"computed_#{left_type}")).to eq result.map(&:"computed_#{left_type}").sort_by { |bool| bool ? 1 : 0 }
          else
            expect(result.map(&:"computed_#{left_type}")).to eq result.map(&:"computed_#{left_type}").sort!
          end

          result.each_cons(2) do |left_result, right_result|
            if left_result.send("computed_#{left_type}") == right_result.send("computed_#{left_type}")
              expect(left_result.send("computed_#{right_type}")).to be <= right_result.send("computed_#{right_type}")
            end
          end
        end
      end

      { left_type => 'desc', "computed_#{right_type}" => 'desc' }.tap do |instructions|
        it "#{instructions.inspect}" do
          result = SORTING_ACTIVE_SET.sort(instructions)

          if left_type == :boolean
            expect(result.map(& left_type)).to eq result.map(& left_type).sort_by { |bool| bool ? 1 : 0 }.reverse!
          else
            expect(result.map(& left_type)).to eq result.map(& left_type).sort!.reverse!
          end

          result.each_cons(2) do |left_result, right_result|
            if left_result.send(left_type) == right_result.send(left_type)
              expect(left_result.send("computed_#{right_type}")).to be >= right_result.send("computed_#{right_type}")
            end
          end
        end
      end

      { "computed_#{left_type}" => 'asc', right_type => 'desc' }.tap do |instructions|
        it "#{instructions.inspect}" do
          result = SORTING_ACTIVE_SET.sort(instructions)

          if left_type == :boolean
            expect(result.map(&:"computed_#{left_type}")).to eq result.map(&:"computed_#{left_type}").sort_by { |bool| bool ? 1 : 0 }
          else
            expect(result.map(&:"computed_#{left_type}")).to eq result.map(&:"computed_#{left_type}").sort!
          end

          result.each_cons(2) do |left_result, right_result|
            if left_result.send("computed_#{left_type}") == right_result.send("computed_#{left_type}")
              expect(left_result.send(right_type)).to be >= right_result.send(right_type)
            end
          end
        end
      end

      { assoc: { left_type => 'desc', right_type => 'asc' } }.tap do |instructions|
        it "#{instructions.inspect}" do
          result = SORTING_ACTIVE_SET.sort(instructions)

          if left_type == :boolean
            expect(result.map(&:assoc).map(& left_type)).to eq result.map(&:assoc).map(& left_type).sort_by { |bool| bool ? 1 : 0 }.reverse!
          else
            expect(result.map(&:assoc).map(& left_type)).to eq result.map(&:assoc).map(& left_type).sort!.reverse!
          end

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.send(left_type) == right_result.assoc.send(left_type)
              expect(left_result.assoc.send(right_type)).to be <= right_result.assoc.send(right_type)
            end
          end
        end
      end

      { assoc: { "computed_#{left_type}" => 'asc', "computed_#{right_type}" => 'asc' } }.tap do |instructions|
        it "#{instructions.inspect}" do
          result = SORTING_ACTIVE_SET.sort(instructions)

          if left_type == :boolean
            expect(result.map(&:assoc).map(&:"computed_#{left_type}")).to eq result.map(&:assoc).map(&:"computed_#{left_type}").sort_by { |bool| bool ? 1 : 0 }
          else
            expect(result.map(&:assoc).map(&:"computed_#{left_type}")).to eq result.map(&:assoc).map(&:"computed_#{left_type}").sort!
          end

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.send("computed_#{left_type}") == right_result.assoc.send("computed_#{left_type}")
              expect(left_result.assoc.send("computed_#{right_type}")).to be <= right_result.assoc.send("computed_#{right_type}")
            end
          end
        end
      end

      { assoc: { left_type => 'desc', "computed_#{right_type}" => 'desc' } }.tap do |instructions|
        it "#{instructions.inspect}" do
          result = SORTING_ACTIVE_SET.sort(instructions)

          if left_type == :boolean
            expect(result.map(&:assoc).map(& left_type)).to eq result.map(&:assoc).map(& left_type).sort_by { |bool| bool ? 1 : 0 }.reverse!
          else
            expect(result.map(&:assoc).map(& left_type)).to eq result.map(&:assoc).map(& left_type).sort!.reverse!
          end

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.send(left_type) == right_result.assoc.send(left_type)
              expect(left_result.assoc.send("computed_#{right_type}")).to be >= right_result.assoc.send("computed_#{right_type}")
            end
          end
        end
      end

      { assoc: { "computed_#{left_type}" => 'asc', right_type => 'desc' } }.tap do |instructions|
        it "#{instructions.inspect}" do
          result = SORTING_ACTIVE_SET.sort(instructions)

          if left_type == :boolean
            expect(result.map(&:assoc).map(&:"computed_#{left_type}")).to eq result.map(&:assoc).map(&:"computed_#{left_type}").sort_by { |bool| bool ? 1 : 0 }
          else
            expect(result.map(&:assoc).map(&:"computed_#{left_type}")).to eq result.map(&:assoc).map(&:"computed_#{left_type}").sort!
          end

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.send("computed_#{left_type}") == right_result.assoc.send("computed_#{left_type}")
              expect(left_result.assoc.send(right_type)).to be >= right_result.assoc.send(right_type)
            end
          end
        end
      end

      { left_type => 'desc', assoc: { right_type => 'asc' } }.tap do |instructions|
        it "#{instructions.inspect}" do
          result = SORTING_ACTIVE_SET.sort(instructions)

          if left_type == :boolean
            expect(result.map(& left_type)).to eq result.map(& left_type).sort_by { |bool| bool ? 1 : 0 }.reverse!
          else
            expect(result.map(& left_type)).to eq result.map(& left_type).sort!.reverse!
          end

          result.each_cons(2) do |left_result, right_result|
            if left_result.send(left_type) == right_result.send(left_type)
              expect(left_result.assoc.send(right_type)).to be <= right_result.assoc.send(right_type)
            end
          end
        end
      end

      { "computed_#{left_type}" => 'asc', assoc: { right_type => 'asc' } }.tap do |instructions|
        it "#{instructions.inspect}" do
          result = SORTING_ACTIVE_SET.sort(instructions)

          if left_type == :boolean
            expect(result.map(&:"computed_#{left_type}")).to eq result.map(&:"computed_#{left_type}").sort_by { |bool| bool ? 1 : 0 }
          else
            expect(result.map(&:"computed_#{left_type}")).to eq result.map(&:"computed_#{left_type}").sort!
          end

          result.each_cons(2) do |left_result, right_result|
            if left_result.send("computed_#{left_type}") == right_result.send("computed_#{left_type}")
              expect(left_result.assoc.send(right_type)).to be <= right_result.assoc.send(right_type)
            end
          end
        end
      end

      { left_type => 'desc', assoc: { "computed_#{right_type}" => 'desc' } }.tap do |instructions|
        it "#{instructions.inspect}" do
          result = SORTING_ACTIVE_SET.sort(instructions)

          if left_type == :boolean
            expect(result.map(& left_type)).to eq result.map(& left_type).sort_by { |bool| bool ? 1 : 0 }.reverse!
          else
            expect(result.map(& left_type)).to eq result.map(& left_type).sort!.reverse!
          end

          result.each_cons(2) do |left_result, right_result|
            if left_result.send(left_type) == right_result.send(left_type)
              expect(left_result.assoc.send("computed_#{right_type}")).to be >= right_result.assoc.send("computed_#{right_type}")
            end
          end
        end
      end

      { "computed_#{left_type}" => 'asc', assoc: { "computed_#{right_type}" => 'desc' } }.tap do |instructions|
        it "#{instructions.inspect}" do
          result = SORTING_ACTIVE_SET.sort(instructions)

          if left_type == :boolean
            expect(result.map(&:"computed_#{left_type}")).to eq result.map(&:"computed_#{left_type}").sort_by { |bool| bool ? 1 : 0 }
          else
            expect(result.map(&:"computed_#{left_type}")).to eq result.map(&:"computed_#{left_type}").sort!
          end

          result.each_cons(2) do |left_result, right_result|
            if left_result.send("computed_#{left_type}") == right_result.send("computed_#{left_type}")
              expect(left_result.assoc.send("computed_#{right_type}")).to be >= right_result.assoc.send("computed_#{right_type}")
            end
          end
        end
      end

      { assoc: { left_type => 'desc' }, right_type => 'asc' }.tap do |instructions|
        it "#{instructions.inspect}" do
          result = SORTING_ACTIVE_SET.sort(instructions)

          if left_type == :boolean
            expect(result.map(&:assoc).map(& left_type)).to eq result.map(&:assoc).map(& left_type).sort_by { |bool| bool ? 1 : 0 }.reverse!
          else
            expect(result.map(&:assoc).map(& left_type)).to eq result.map(&:assoc).map(& left_type).sort!.reverse!
          end

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.send(left_type) == right_result.assoc.send(left_type)
              expect(left_result.send(right_type)).to be <= right_result.send(right_type)
            end
          end
        end
      end

      { assoc: { "computed_#{left_type}" => 'asc' }, "computed_#{right_type}" => 'asc' }.tap do |instructions|
        it "#{instructions.inspect}" do
          result = SORTING_ACTIVE_SET.sort(instructions)

          if left_type == :boolean
            expect(result.map(&:assoc).map(&:"computed_#{left_type}")).to eq result.map(&:assoc).map(&:"computed_#{left_type}").sort_by { |bool| bool ? 1 : 0 }
          else
            expect(result.map(&:assoc).map(&:"computed_#{left_type}")).to eq result.map(&:assoc).map(&:"computed_#{left_type}").sort!
          end

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.send("computed_#{left_type}") == right_result.assoc.send("computed_#{left_type}")
              expect(left_result.send("computed_#{right_type}")).to be <= right_result.send("computed_#{right_type}")
            end
          end
        end
      end

      { assoc: { left_type => 'desc' }, "computed_#{right_type}" => 'desc' }.tap do |instructions|
        it "#{instructions.inspect}" do
          result = SORTING_ACTIVE_SET.sort(instructions)

          if left_type == :boolean
            expect(result.map(&:assoc).map(& left_type)).to eq result.map(&:assoc).map(& left_type).sort_by { |bool| bool ? 1 : 0 }.reverse!
          else
            expect(result.map(&:assoc).map(& left_type)).to eq result.map(&:assoc).map(& left_type).sort!.reverse!
          end

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.send(left_type) == right_result.assoc.send(left_type)
              expect(left_result.send("computed_#{right_type}")).to be >= right_result.send("computed_#{right_type}")
            end
          end
        end
      end

      { assoc: { "computed_#{left_type}" => 'asc' }, right_type => 'desc' }.tap do |instructions|
        it "#{instructions.inspect}" do
          result = SORTING_ACTIVE_SET.sort(instructions)

          if left_type == :boolean
            expect(result.map(&:assoc).map(&:"computed_#{left_type}")).to eq result.map(&:assoc).map(&:"computed_#{left_type}").sort_by { |bool| bool ? 1 : 0 }
          else
            expect(result.map(&:assoc).map(&:"computed_#{left_type}")).to eq result.map(&:assoc).map(&:"computed_#{left_type}").sort!
          end

          result.each_cons(2) do |left_result, right_result|
            if left_result.assoc.send("computed_#{left_type}") == right_result.assoc.send("computed_#{left_type}")
              expect(left_result.send(right_type)).to be >= right_result.send(right_type)
            end
          end
        end
      end
    end
  end
end

Foo.destroy_all
