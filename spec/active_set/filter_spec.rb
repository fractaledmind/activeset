# frozen_string_literal: true

require 'spec_helper'

begin
  FactoryGirl.find_definitions
rescue FactoryGirl::DuplicateDefinitionError
end

FOO_FILTERING_1 = FactoryGirl.create(:foo, assoc: FactoryGirl.create(:assoc))
FOO_FILTERING_2 = FactoryGirl.create(:foo, assoc: FactoryGirl.create(:assoc))

FILTERING_ACTIVE_SET = ActiveSet.new(Foo.all)

RSpec.describe ActiveSet do
  describe '#filter' do
    attribute_types = %i[binary boolean date datetime decimal float integer string text time]

    attribute_types.each do |type|
      instructions_generator_1 = lambda do |foo|
        [
          { type => foo.send(type) },
          { "computed_#{type}" => foo.send("computed_#{type}") },
          { type => foo.send(type),
            "computed_#{type}" => foo.send("computed_#{type}") },
          { assoc: { type => foo.assoc.send(type) } },
          { assoc: { "computed_#{type}" => foo.assoc.send("computed_#{type}")} },
          { assoc: { type => foo.assoc.send(type),
                     "computed_#{type}" => foo.assoc.send("computed_#{type}") } },
          { type => foo.send(type),
            assoc: { type => foo.assoc.send(type) } },
          { type => foo.send(type),
            assoc: { "computed_#{type}" => foo.assoc.send("computed_#{type}") } },
          { "computed_#{type}" => foo.send("computed_#{type}"),
            assoc: { type => foo.assoc.send(type) } },
          { "computed_#{type}" => foo.send("computed_#{type}"),
            assoc: { "computed_#{type}" => foo.assoc.send("computed_#{type}") } }
        ]
      end

      instructions_generator_1.call(FOO_FILTERING_1).each do |instructions|
        it "#{instructions.inspect}" do
          result = FILTERING_ACTIVE_SET.filter(instructions)
          expect(result.map(&:id)).to eq [FOO_FILTERING_1.id]
        end
      end

      instructions_generator_1.call(FOO_FILTERING_2).each do |instructions|
        it "#{instructions.inspect}" do
          result = FILTERING_ACTIVE_SET.filter(instructions)
          expect(result.map(&:id)).to eq [FOO_FILTERING_2.id]
        end
      end
    end

    attribute_types.combination(2).each do |left_type, right_type|
      instructions_generator_2 = lambda do |foo|
        [
          { left_type => foo.send(left_type),
            right_type => foo.send(right_type) },
          { "computed_#{left_type}" => foo.send("computed_#{left_type}"),
            "computed_#{right_type}" => foo.send("computed_#{right_type}") },
          { left_type => foo.send(left_type),
            "computed_#{right_type}" => foo.send("computed_#{right_type}") },
          { right_type => foo.send(right_type),
            "computed_#{left_type}" => foo.send("computed_#{left_type}") },
          { assoc: { left_type => foo.assoc.send(left_type),
                     right_type => foo.assoc.send(right_type) } },
          { assoc: { "computed_#{left_type}" => foo.assoc.send("computed_#{left_type}"),
                     "computed_#{right_type}" => foo.assoc.send("computed_#{right_type}") } },
          { assoc: { left_type => foo.assoc.send(left_type),
                     "computed_#{right_type}" => foo.assoc.send("computed_#{right_type}") } },
          { assoc: { right_type => foo.assoc.send(right_type),
                     "computed_#{left_type}" => foo.assoc.send("computed_#{left_type}") } },
          { left_type => foo.send(left_type),
            assoc: { right_type => foo.assoc.send(right_type) } },
          { right_type => foo.send(right_type),
            assoc: { left_type => foo.assoc.send(left_type) } },
          { left_type => foo.send(left_type),
            assoc: { "computed_#{right_type}" => foo.assoc.send("computed_#{right_type}") } },
          { right_type => foo.send(right_type),
            assoc: { "computed_#{left_type}" => foo.assoc.send("computed_#{left_type}") } },
          { "computed_#{left_type}" => foo.send("computed_#{left_type}"),
            assoc: { right_type => foo.assoc.send(right_type) } },
          { "computed_#{right_type}" => foo.send("computed_#{right_type}"),
            assoc: { left_type => foo.assoc.send(left_type) } },
          { "computed_#{left_type}" => foo.send("computed_#{left_type}"),
            assoc: { "computed_#{right_type}" => foo.assoc.send("computed_#{right_type}") } },
          { "computed_#{right_type}" => foo.send("computed_#{right_type}"),
            assoc: { "computed_#{left_type}" => foo.assoc.send("computed_#{left_type}") } }
        ]
      end

      instructions_generator_2.call(FOO_FILTERING_1).each do |instructions|
        it "#{instructions.inspect}" do
          result = FILTERING_ACTIVE_SET.filter(instructions)
          expect(result.map(&:id)).to eq [FOO_FILTERING_1.id]
        end
      end

      instructions_generator_2.call(FOO_FILTERING_2).each do |instructions|
        it "#{instructions.inspect}" do
          result = FILTERING_ACTIVE_SET.filter(instructions)
          expect(result.map(&:id)).to eq [FOO_FILTERING_2.id]
        end
      end
    end

    # it 'with all activerecord attributes' do
    #   result = @active_set.filter(binary: @foo_1.binary,
    #                               boolean: @foo_1.boolean,
    #                               date: @foo_1.date,
    #                               datetime: @foo_1.datetime,
    #                               decimal: @foo_1.decimal,
    #                               float: @foo_1.float,
    #                               integer: @foo_1.integer,
    #                               string: @foo_1.string,
    #                               text: @foo_1.text,
    #                               time: @foo_1.time,
    #                               assoc: {
    #                                 binary: @foo_1.assoc.binary,
    #                                 boolean: @foo_1.assoc.boolean,
    #                                 date: @foo_1.assoc.date,
    #                                 datetime: @foo_1.assoc.datetime,
    #                                 decimal: @foo_1.assoc.decimal,
    #                                 float: @foo_1.assoc.float,
    #                                 integer: @foo_1.assoc.integer,
    #                                 string: @foo_1.assoc.string,
    #                                 text: @foo_1.assoc.text,
    #                                 time: @foo_1.assoc.time,
    #                               })

    #   expect(result.map(&:id)).to eq [@foo_1.id]
    # end
  end
end

Foo.destroy_all
