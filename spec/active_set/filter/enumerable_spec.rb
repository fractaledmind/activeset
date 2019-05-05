# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveSet do
  before(:all) do
    @thing_1 = FactoryBot.create(:thing, one: FactoryBot.create(:one))
    @thing_2 = FactoryBot.create(:thing, one: FactoryBot.create(:one))
    @active_set = ActiveSet.new(Thing.all.to_a)
  end

  describe '#filter' do
    let(:result) { @active_set.filter(instructions) }

    # ApplicationRecord::FIELD_TYPES.each do |type|
    #   context "with #{type.upcase} type" do
    #     [1, 2].each do |id|
    #       context "matching @thing_#{id}" do
    #         let(:matching_item) { instance_variable_get("@thing_#{id}") }

    #         %W[
    #           #{type}
    #           one.#{type}
    #           computed_one.#{type}
    #         ].each do |path|
    #           context "{ #{path}: }" do
    #             let(:instructions) do
    #               {
    #                 path => path.split('.').reduce(matching_item) { |obj, m| obj.send(m) }
    #               }
    #             end

    #             it { expect(result.map(&:id)).to eq [matching_item.id] }
    #           end
    #         end
    #       end
    #     end
    #   end
    # end

    context 'on a SCOPE' do
      context 'matching @thing_1' do
        let(:matching_item) { @thing_1 }

        context '{ string_starts_with: }' do
          let(:instructions) do
            {
              'string_starts_with': matching_item.string[0..3]
            }
          end

          it { expect(result.map(&:id)).to eq [matching_item.id] }
        end

        context '{ string_ends_with: }' do
          let(:instructions) do
            {
              'string_ends_with': matching_item.string[-3..-1]
            }
          end

          it { expect(result.map(&:id)).to eq [matching_item.id] }
        end

        context '{ one: { string_starts_with: } }' do
          let(:instructions) do
            {
              one: {
                'string_starts_with': matching_item.one.string[0..3]
              }
            }
          end

          it { expect(result.map(&:id)).to eq [matching_item.id] }
        end

        context '{ one: { string_ends_with: } }' do
          let(:instructions) do
            {
              one: {
                'string_ends_with': matching_item.one.string[-3..-1]
              }
            }
          end

          it { expect(result.map(&:id)).to eq [matching_item.id] }
        end

        context '{ computed_one: { string_starts_with: } }' do
          let(:instructions) do
            {
              computed_one: {
                'string_starts_with': matching_item.computed_one.string[0..3]
              }
            }
          end

          it { expect(result.map(&:id)).to eq [matching_item.id] }
        end

        context '{ computed_one: { string_ends_with: } }' do
          let(:instructions) do
            {
              computed_one: {
                'string_ends_with': matching_item.computed_one.string[-3..-1]
              }
            }
          end

          it { expect(result.map(&:id)).to eq [matching_item.id] }
        end
      end

      context 'matching @thing_2' do
        let(:matching_item) { @thing_2 }

        context '{ string_starts_with: }' do
          let(:instructions) do
            {
              'string_starts_with': matching_item.string[0..3]
            }
          end

          it { expect(result.map(&:id)).to eq [matching_item.id] }
        end

        context '{ string_ends_with: }' do
          let(:instructions) do
            {
              'string_ends_with': matching_item.string[-3..-1]
            }
          end

          it { expect(result.map(&:id)).to eq [matching_item.id] }
        end

        context '{ one: { string_starts_with: } }' do
          let(:instructions) do
            {
              one: {
                'string_starts_with': matching_item.one.string[0..3]
              }
            }
          end

          it { expect(result.map(&:id)).to eq [matching_item.id] }
        end

        context '{ one: { string_ends_with: } }' do
          let(:instructions) do
            {
              one: {
                'string_ends_with': matching_item.one.string[-3..-1]
              }
            }
          end

          it { expect(result.map(&:id)).to eq [matching_item.id] }
        end

        context '{ computed_one: { string_starts_with: } }' do
          let(:instructions) do
            {
              computed_one: {
                'string_starts_with': matching_item.computed_one.string[0..3]
              }
            }
          end

          it { expect(result.map(&:id)).to eq [matching_item.id] }
        end

        context '{ computed_one: { string_ends_with: } }' do
          let(:instructions) do
            {
              computed_one: {
                'string_ends_with': matching_item.computed_one.string[-3..-1]
              }
            }
          end

          it { expect(result.map(&:id)).to eq [matching_item.id] }
        end
      end

      context '{ nil_returning_class_method: }' do
        let(:instructions) do
          {
            'nil_returning_class_method': 0
          }
        end

        it { expect(result.map(&:id)).to eq [] }
      end

      context '{ item_returning_class_method: }' do
        let(:instructions) do
          {
            'item_returning_class_method': 0
          }
        end

        it { expect(result.map(&:id)).to eq [Thing.first.id] }
      end
    end
  end
end
