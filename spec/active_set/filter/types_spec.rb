# frozen_string_literal: true

require 'spec_helper'

RSpec.shared_examples 'a successful filter' do
  it { expect(result.map(&:id)).to eq [matching_item.id] }
end

RSpec.describe ActiveSet do
  before(:all) do
    @foo_1 = FactoryBot.create(:foo, assoc: FactoryBot.create(:assoc))
    @foo_2 = FactoryBot.create(:foo, assoc: FactoryBot.create(:assoc))
    @active_set = ActiveSet.new(Foo.all)
  end
  after(:all) { Foo.delete_all }

  describe '#filter' do
    let(:result) { @active_set.filter(instructions) }

    ApplicationRecord::FIELD_TYPES.each do |type|
      context "with #{type.upcase} type" do
        [1, 2].each do |foo_id|
          context "matching @foo_#{foo_id}" do
            let(:matching_item) { instance_variable_get("@foo_#{foo_id}") }

            %W[
              #{type}
              computed_#{type}
              assoc.#{type}
              assoc.computed_#{type}
              computed_assoc.#{type}
              computed_assoc.computed_#{type}
            ].each do |path|
              context "{ #{path}: }" do
                let(:instructions) do
                  {
                    path => path.split('.').reduce(matching_item) { |obj, m| obj.send(m) }
                  }
                end

                it_behaves_like 'a successful filter'
              end
            end
          end
        end
      end
    end

    ApplicationRecord::FIELD_TYPES.combination(2).each do |type_1, type_2|
      context "with #{type_1.upcase} and #{type_2.upcase} types" do
        [1, 2].each do |foo_id|
          context "matching @foo_#{foo_id}" do
            let(:matching_item) { instance_variable_get("@foo_#{foo_id}") }

            %W[
              #{type_1}
              #{type_2}
              computed_#{type_1}
              computed_#{type_2}
              assoc.#{type_1}
              assoc.#{type_2}
              assoc.computed_#{type_1}
              assoc.computed_#{type_2}
              computed_assoc.#{type_1}
              computed_assoc.#{type_2}
              computed_assoc.computed_#{type_1}
              computed_assoc.computed_#{type_2}
            ].combination(2).each do |path_1, path_2|
              context "{ #{path_1}:, #{path_2} }" do
                let(:instructions) do
                  {
                    path_1 => path_1.split('.').reduce(matching_item) { |obj, m| obj.send(m) },
                    path_2 => path_2.split('.').reduce(matching_item) { |obj, m| obj.send(m) }
                  }
                end

                it_behaves_like 'a successful filter'
              end
            end
          end
        end
      end
    end
  end
end
