# frozen_string_literal: true

require 'spec_helper'

begin
  FactoryGirl.find_definitions
rescue FactoryGirl::DuplicateDefinitionError
end

FOO_PAGINATING_1 = FactoryGirl.create(:foo, assoc: FactoryGirl.create(:assoc))
FOO_PAGINATING_2 = FactoryGirl.create(:foo, assoc: FactoryGirl.create(:assoc))
FOO_PAGINATING_3 = FactoryGirl.create(:foo, assoc: FactoryGirl.create(:assoc))

PAGINATING_ACTIVE_SET = ActiveSet.new(Foo.all)

RSpec.describe ActiveSet do
  describe '#paginate' do
    { page: 1, size: 1 }.tap do |instructions|
      it "#{instructions.inspect}" do
        result = PAGINATING_ACTIVE_SET.paginate(instructions)

        expect(result.map(&:id)).to eq [FOO_PAGINATING_1.id]
      end
    end

    { page: 2, size: 1 }.tap do |instructions|
      it "#{instructions.inspect}" do
        result = PAGINATING_ACTIVE_SET.paginate(instructions)

        expect(result.map(&:id)).to eq [FOO_PAGINATING_2.id]
      end
    end

    { page: 10, size: 1 }.tap do |instructions|
      it "#{instructions.inspect}" do
        result = PAGINATING_ACTIVE_SET.paginate(instructions)

        expect(result.map(&:id)).to eq []
      end
    end

    { page: 1, size: 2 }.tap do |instructions|
      it "#{instructions.inspect}" do
        result = PAGINATING_ACTIVE_SET.paginate(instructions)

        expect(result.map(&:id)).to eq [FOO_PAGINATING_1.id, FOO_PAGINATING_2.id]
      end
    end

    { page: 2, size: 2 }.tap do |instructions|
      it "#{instructions.inspect}" do
        result = PAGINATING_ACTIVE_SET.paginate(instructions)

        expect(result.map(&:id)).to eq [FOO_PAGINATING_3.id]
      end
    end

    { page: 10, size: 2 }.tap do |instructions|
      it "#{instructions.inspect}" do
        result = PAGINATING_ACTIVE_SET.paginate(instructions)

        expect(result.map(&:id)).to eq []
      end
    end

    { page: 1, size: 3 }.tap do |instructions|
      it "#{instructions.inspect}" do
        result = PAGINATING_ACTIVE_SET.paginate(instructions)

        expect(result.map(&:id)).to eq [FOO_PAGINATING_1.id, FOO_PAGINATING_2.id, FOO_PAGINATING_3.id]
      end
    end

    { page: 10, size: 3 }.tap do |instructions|
      it "#{instructions.inspect}" do
        result = PAGINATING_ACTIVE_SET.paginate(instructions)

        expect(result.map(&:id)).to eq []
      end
    end

    { page: 1, size: 5 }.tap do |instructions|
      it "#{instructions.inspect}" do
        result = PAGINATING_ACTIVE_SET.paginate(instructions)

        expect(result.map(&:id)).to eq [FOO_PAGINATING_1.id, FOO_PAGINATING_2.id, FOO_PAGINATING_3.id]
      end
    end

    { page: 10, size: 5 }.tap do |instructions|
      it "#{instructions.inspect}" do
        result = PAGINATING_ACTIVE_SET.paginate(instructions)

        expect(result.map(&:id)).to eq []
      end
    end
  end
end

Foo.destroy_all
