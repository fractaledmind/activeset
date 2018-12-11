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

    context 'on a SCOPE' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ string_starts_with: }' do
          let(:instructions) do
            {
              'string_starts_with': matching_item.string[0..3]
            }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ string_ends_with: }' do
          let(:instructions) do
            {
              'string_ends_with': matching_item.string[-3..-1]
            }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { string_starts_with: } }' do
          let(:instructions) do
            {
              assoc: {
                'string_starts_with': matching_item.assoc.string[0..3]
              }
            }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { string_ends_with: } }' do
          let(:instructions) do
            {
              assoc: {
                'string_ends_with': matching_item.assoc.string[-3..-1]
              }
            }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { string_starts_with: } }' do
          let(:instructions) do
            {
              computed_assoc: {
                'string_starts_with': matching_item.computed_assoc.string[0..3]
              }
            }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { string_ends_with: } }' do
          let(:instructions) do
            {
              computed_assoc: {
                'string_ends_with': matching_item.computed_assoc.string[-3..-1]
              }
            }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ string_starts_with: }' do
          let(:instructions) do
            {
              'string_starts_with': matching_item.string[0..3]
            }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ string_ends_with: }' do
          let(:instructions) do
            {
              'string_ends_with': matching_item.string[-3..-1]
            }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { string_starts_with: } }' do
          let(:instructions) do
            {
              assoc: {
                'string_starts_with': matching_item.assoc.string[0..3]
              }
            }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { string_ends_with: } }' do
          let(:instructions) do
            {
              assoc: {
                'string_ends_with': matching_item.assoc.string[-3..-1]
              }
            }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { string_starts_with: } }' do
          let(:instructions) do
            {
              computed_assoc: {
                'string_starts_with': matching_item.computed_assoc.string[0..3]
              }
            }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { string_ends_with: } }' do
          let(:instructions) do
            {
              computed_assoc: {
                'string_ends_with': matching_item.computed_assoc.string[-3..-1]
              }
            }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'on a SCOPE and with STRING type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ string_starts_with:, string: }' do
          let(:instructions) do
            {
              'string_starts_with': matching_item.string[0..3],
              string: matching_item.string
            }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ string_ends_with:, string: }' do
          let(:instructions) do
            {
              'string_ends_with': matching_item.string[-3..-1],
              string: matching_item.string
            }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { string_starts_with:, string: } }' do
          let(:instructions) do
            {
              assoc: {
                'string_starts_with': matching_item.assoc.string[0..3],
                string: matching_item.assoc.string
              }
            }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { string_ends_with:, string: } }' do
          let(:instructions) do
            {
              assoc: {
                'string_ends_with': matching_item.assoc.string[-3..-1],
                string: matching_item.assoc.string
              }
            }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { string_starts_with:, string: } }' do
          let(:instructions) do
            {
              computed_assoc: {
                'string_starts_with': matching_item.computed_assoc.string[0..3],
                string: matching_item.computed_assoc.string
              }
            }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { string_ends_with:, string: } }' do
          let(:instructions) do
            {
              computed_assoc: {
                'string_ends_with': matching_item.computed_assoc.string[-3..-1],
                string: matching_item.computed_assoc.string
              }
            }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ string_starts_with:, string: }' do
          let(:instructions) do
            {
              'string_starts_with': matching_item.string[0..3],
              string: matching_item.string
            }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ string_ends_with:, string: }' do
          let(:instructions) do
            {
              'string_ends_with': matching_item.string[-3..-1],
              string: matching_item.string
            }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { string_starts_with:, string: } }' do
          let(:instructions) do
            {
              assoc: {
                'string_starts_with': matching_item.assoc.string[0..3],
                string: matching_item.assoc.string
              }
            }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { string_ends_with:, string: } }' do
          let(:instructions) do
            {
              assoc: {
                'string_ends_with': matching_item.assoc.string[-3..-1],
                string: matching_item.assoc.string
              }
            }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { string_starts_with:, string: } }' do
          let(:instructions) do
            {
              computed_assoc: {
                'string_starts_with': matching_item.computed_assoc.string[0..3],
                string: matching_item.computed_assoc.string
              }
            }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { string_ends_with:, string: } }' do
          let(:instructions) do
            {
              computed_assoc: {
                'string_ends_with': matching_item.computed_assoc.string[-3..-1],
                string: matching_item.computed_assoc.string
              }
            }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end
  end
end
