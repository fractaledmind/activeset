# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveSet do
  before(:all) do
    @thing_1 = FactoryBot.create(:thing, one: FactoryBot.create(:one))
    @thing_2 = FactoryBot.create(:thing, one: FactoryBot.create(:one))
    @active_set = ActiveSet.new(Thing.all)
  end
  after(:all) { Thing.delete_all }

  describe '#filter' do
    let(:result) { @active_set.filter(instructions) }

    context 'equality' do
      context 'eq' do
        let(:instructions) do
          { 'id(eq)': @thing_1.id }
        end

        it { expect(result.map(&:id)).to eq [@thing_1.id] }
      end

      context 'not_eq' do
        let(:instructions) do
          { 'id(not_eq)': @thing_1.id }
        end

        it { expect(result.map(&:id)).to eq [@thing_2.id] }
      end

      context 'eq_any' do
        let(:instructions) do
          { 'id(eq_any)': [@thing_1.id, (@thing_2.id + 1)] }
        end

        it { expect(result.map(&:id)).to eq [@thing_1.id] }
      end

      context 'not_eq_any' do
        let(:instructions) do
          { 'id(not_eq_any)': [@thing_1.id, (@thing_2.id + 1)] }
        end

        it { expect(result.map(&:id)).to eq [@thing_1.id, @thing_2.id] }
      end

      context 'eq_all' do
        let(:instructions) do
          { 'id(eq_all)': [@thing_1.id, (@thing_2.id + 1)] }
        end

        it { expect(result.map(&:id)).to eq [] }
      end

      context 'not_eq_all' do
        let(:instructions) do
          { 'id(not_eq_all)': [@thing_1.id, (@thing_2.id + 1)] }
        end

        it { expect(result.map(&:id)).to eq [@thing_2.id] }
      end
    end

    context 'inclusion' do
      context 'in' do
        let(:instructions) do
          { 'id(in)': [@thing_1.id, (@thing_2.id + 1)] }
        end

        it { expect(result.map(&:id)).to eq [@thing_1.id] }
      end

      context 'not_in' do
        let(:instructions) do
          { 'id(not_in)': [@thing_1.id, (@thing_2.id + 1)] }
        end

        it { expect(result.map(&:id)).to eq [@thing_2.id] }
      end

      context 'in_any' do
        let(:instructions) do
          { 'id(in_any)': [@thing_1.id, (@thing_2.id + 1)] }
        end

        it { expect(result.map(&:id)).to eq [@thing_1.id] }
      end

      context 'not_in_any' do
        let(:instructions) do
          { 'id(not_in_any)': [@thing_1.id, (@thing_2.id + 1)] }
        end

        it { expect(result.map(&:id)).to eq [@thing_1.id, @thing_2.id] }
      end

      context 'in_all' do
        let(:instructions) do
          { 'id(in_all)': [@thing_1.id, (@thing_2.id + 1)] }
        end

        it { expect(result.map(&:id)).to eq [] }
      end

      context 'not_in_all' do
        let(:instructions) do
          { 'id(not_in_all)': [@thing_1.id, (@thing_2.id + 1)] }
        end

        it { expect(result.map(&:id)).to eq [@thing_2.id] }
      end
    end

    context 'comparison' do
      context 'lt' do
        let(:instructions) do
          { 'id(lt)': @thing_2.id }
        end

        it { expect(result.map(&:id)).to eq [@thing_1.id] }
      end

      context 'lteq' do
        let(:instructions) do
          { 'id(lteq)': @thing_2.id }
        end

        it { expect(result.map(&:id)).to eq [@thing_1.id, @thing_2.id] }
      end

      context 'lt_any' do
        let(:instructions) do
          { 'id(lt_any)': [@thing_1.id, (@thing_2.id + 1)] }
        end

        it { expect(result.map(&:id)).to eq [@thing_1.id, @thing_2.id] }
      end

      context 'lteq_any' do
        let(:instructions) do
          { 'id(lteq_any)': [@thing_1.id, (@thing_2.id + 1)] }
        end

        it { expect(result.map(&:id)).to eq [@thing_1.id, @thing_2.id] }
      end

      context 'lt_all' do
        let(:instructions) do
          { 'id(lt_all)': [@thing_1.id, (@thing_2.id + 1)] }
        end

        it { expect(result.map(&:id)).to eq [] }
      end

      context 'lteq_all' do
        let(:instructions) do
          { 'id(lteq_all)': [@thing_1.id, (@thing_2.id + 1)] }
        end

        it { expect(result.map(&:id)).to eq [@thing_1.id] }
      end

      context 'gt' do
        let(:instructions) do
          { 'id(gt)': @thing_1.id }
        end

        it { expect(result.map(&:id)).to eq [@thing_2.id] }
      end

      context 'gteq' do
        let(:instructions) do
          { 'id(gteq)': @thing_2.id }
        end

        it { expect(result.map(&:id)).to eq [@thing_2.id] }
      end

      context 'gt_any' do
        let(:instructions) do
          { 'id(gt_any)': [@thing_1.id, (@thing_2.id + 1)] }
        end

        it { expect(result.map(&:id)).to eq [@thing_2.id] }
      end

      context 'gteq_any' do
        let(:instructions) do
          { 'id(gteq_any)': [@thing_1.id, (@thing_2.id + 1)] }
        end

        it { expect(result.map(&:id)).to eq [@thing_1.id, @thing_2.id] }
      end

      context 'gt_all' do
        let(:instructions) do
          { 'id(gt_all)': [@thing_1.id, (@thing_2.id + 1)] }
        end

        it { expect(result.map(&:id)).to eq [] }
      end

      context 'gteq_all' do
        let(:instructions) do
          { 'id(gteq_all)': [@thing_1.id, (@thing_2.id + 1)] }
        end

        it { expect(result.map(&:id)).to eq [] }
      end
    end

    context 'matching' do
      context 'matches' do
        let(:instructions) do
          { 'string(matches)': "%#{@thing_1.string[1..-2]}%" }
        end

        it { expect(result.map(&:id)).to eq [@thing_1.id] }
      end

      context 'does_not_match' do
        let(:instructions) do
          { 'string(does_not_match)': "%#{@thing_1.string[1..-2]}%" }
        end

        it { expect(result.map(&:id)).to eq [@thing_2.id] }
      end

      context 'matches_any' do
        let(:instructions) do
          { 'string(matches_any)': ["%#{@thing_1.string[1..-2]}%", 'DOES NOT MATCH'] }
        end

        it { expect(result.map(&:id)).to eq [@thing_1.id] }
      end

      context 'does_not_match_any' do
        let(:instructions) do
          { 'string(does_not_match_any)': ["%#{@thing_1.string[1..-2]}%", 'DOES NOT MATCH'] }
        end

        it { expect(result.map(&:id)).to eq [@thing_1.id, @thing_2.id] }
      end

      context 'matches_all' do
        let(:instructions) do
          { 'string(matches_all)': ["%#{@thing_1.string[1..-2]}%", 'DOES NOT MATCH'] }
        end

        it { expect(result.map(&:id)).to eq [] }
      end

      context 'does_not_match_all' do
        let(:instructions) do
          { 'string(does_not_match_all)': ["%#{@thing_1.string[1..-2]}%", 'DOES NOT MATCH'] }
        end

        it { expect(result.map(&:id)).to eq [@thing_2.id] }
      end
    end
  end
end
