# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveSet do
  before(:all) do
    @thing_1 = FactoryBot.create(:thing, one: FactoryBot.create(:one))
    @thing_2 = FactoryBot.create(:thing, one: FactoryBot.create(:one))
    @active_set = ActiveSet.new(Thing.all)
  end

  describe '#filter' do
    let(:result) { @active_set.filter(instructions) }

    ApplicationRecord::FIELD_TYPES.each do |type|
      [1, 2].each do |id|
        let(:matching_item) { instance_variable_get("@thing_#{id}") }

        all_possible_paths_for(type).each do |path|
          context "{ #{path}: }" do
            let(:instructions) do
              {
                path => filter_value_for(object: matching_item, path: path)
              }
            end

            it { expect(result.map(&:id)).to eq [matching_item.id] }
          end
        end
      end
    end

    ApplicationRecord::FIELD_TYPES.combination(2).each do |type_1, type_2|
      [1, 2].each do |id|
        context "matching @thing_#{id}" do
          let(:matching_item) { instance_variable_get("@thing_#{id}") }

          all_possible_path_combinations_for(type_1, type_2).each do |path_1, path_2|
            context "{ #{path_1}:, #{path_2} }" do
              let(:instructions) do
                {
                  path_1 => filter_value_for(object: matching_item, path: path_1),
                  path_2 => filter_value_for(object: matching_item, path: path_2)
                }
              end

              it { expect(result.map(&:id)).to eq [matching_item.id] }
            end
          end
        end
      end
    end
  end
end
