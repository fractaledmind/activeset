# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveSet do
  before(:all) do
    @thing_1 = FactoryBot.create(:thing, one: FactoryBot.create(:one))
    @thing_2 = FactoryBot.create(:thing, one: FactoryBot.create(:one))
  end
  after(:all) { Thing.delete_all }

  describe '#filter' do
    before(:all) { @active_set = ActiveSet.new(Thing.all.to_a) }
    let(:result) { @active_set.filter(instructions) }

    context do
      it { p @active_set.filter('id(eq)': 2).map(&:id) }
      it { p @active_set.filter('id(eq_any)': [2, 1]).map(&:id) }
      it { p @active_set.filter('id(eq_all)': [2, 1]).map(&:id) }
      it { p @active_set.filter('id(not_eq)': 2).map(&:id) }
      it { p @active_set.filter('id(not_eq_any)': [2, 3]).map(&:id) }
      it { p @active_set.filter('id(not_eq_all)': [2, 3]).map(&:id) }

      it { p @active_set.filter('string(matches)': "#{@thing_1.string[0..2]}%").map(&:id) }
      it { p @active_set.filter('string(matches_any)': ["#{@thing_1.string[0..2]}%", 'thing']).map(&:id) }
      it { p @active_set.filter('string(matches_all)': ["#{@thing_1.string[0..2]}%", 'thing']).map(&:id) }
      it { p @active_set.filter('string(does_not_match)': "#{@thing_1.string[0..2]}%").map(&:id) }
      it { p @active_set.filter('string(does_not_match_any)': ["#{@thing_1.string[0..2]}%", 'thing']).map(&:id) }
      it { p @active_set.filter('string(does_not_match_all)': ["#{@thing_1.string[0..2]}%", 'thing']).map(&:id) }

      it { p @active_set.filter('id(in)': [2, 3]).map(&:id) }
      it { p @active_set.filter('id(in_any)': [2, 3]).map(&:id) }
      it { p @active_set.filter('id(in_all)': [2, 3]).map(&:id) }
      it { p @active_set.filter('id(not_in)': [2, 3]).map(&:id) }
      it { p @active_set.filter('id(not_in_any)': [2, 3]).map(&:id) }
      it { p @active_set.filter('id(not_in_all)': [2, 3]).map(&:id) }

      it { p @active_set.filter('id(lt)': 2).map(&:id) }
      it { p @active_set.filter('id(lt_any)': [2, 3]).map(&:id) }
      it { p @active_set.filter('id(lt_all)': [2, 3]).map(&:id) }
      it { p @active_set.filter('id(lteq)': 2).map(&:id) }
      it { p @active_set.filter('id(lteq_any)': [2, 3]).map(&:id) }
      it { p @active_set.filter('id(lteq_all)': [2, 3]).map(&:id) }

      it { p @active_set.filter('id(gt)': 2).map(&:id) }
      it { p @active_set.filter('id(gt_any)': [2, 3]).map(&:id) }
      it { p @active_set.filter('id(gt_all)': [2, 3]).map(&:id) }
      it { p @active_set.filter('id(gteq)': 2).map(&:id) }
      it { p @active_set.filter('id(gteq_any)': [2, 3]).map(&:id) }
      it { p @active_set.filter('id(gteq_all)': [2, 3]).map(&:id) }

      context 'equality aliases' do
        it { p @active_set.filter('id(is_null)': true).map(&:id) }
        it { p @active_set.filter('id(not_null)': true).map(&:id) }

        it { p @active_set.filter('id(is_present)': true).map(&:id) }
        it { p @active_set.filter('id(not_present)': true).map(&:id) }

        it { p @active_set.filter('id(is_true)': true).map(&:id) }
        it { p @active_set.filter('id(is_false)': true).map(&:id) }
      end

      context 'matches aliases' do
        it { p @active_set.filter('string(start)': @thing_1.string[0..2]).map(&:id) }
        it { p @active_set.filter('string(start_any)': [@thing_1.string[0..2], 'thing']).map(&:id) }
        it { p @active_set.filter('string(start_all)': [@thing_1.string[0..2], 'thing']).map(&:id) }
        it { p @active_set.filter('string(not_start)': @thing_1.string[0..2]).map(&:id) }
        it { p @active_set.filter('string(not_start_any)': [@thing_1.string[0..2], 'thing']).map(&:id) }
        it { p @active_set.filter('string(not_start_all)': [@thing_1.string[0..2], 'thing']).map(&:id) }

        it { p @active_set.filter('string(end)': @thing_1.string[-3..-1]).map(&:id) }
        it { p @active_set.filter('string(end_any)': [@thing_1.string[-3..-1], 'thing']).map(&:id) }
        it { p @active_set.filter('string(end_all)': [@thing_1.string[-3..-1], 'thing']).map(&:id) }
        it { p @active_set.filter('string(not_end)': @thing_1.string[-3..-1]).map(&:id) }
        it { p @active_set.filter('string(not_end_any)': [@thing_1.string[-3..-1], 'thing']).map(&:id) }
        it { p @active_set.filter('string(not_end_all)': [@thing_1.string[-3..-1], 'thing']).map(&:id) }

        it { p @active_set.filter('string(contain)': @thing_1.string[3..-3]).map(&:id) }
        it { p @active_set.filter('string(contain_any)': [@thing_1.string[3..-3], 'thing']).map(&:id) }
        it { p @active_set.filter('string(contain_all)': [@thing_1.string[3..-3], 'thing']).map(&:id) }
        it { p @active_set.filter('string(not_contain)': @thing_1.string[3..-3]).map(&:id) }
        it { p @active_set.filter('string(not_contain_any)': [@thing_1.string[3..-3], 'thing']).map(&:id) }
        it { p @active_set.filter('string(not_contain_all)': [@thing_1.string[3..-3], 'thing']).map(&:id) }
      end
    end
  end
end
